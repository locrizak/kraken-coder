#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
w = this

class pkg.display.dudes.Dude

	constructor : (world, canvas, isMe=false, name="") ->
		@world = world
		@$canvas = canvas
		@isMe = isMe
		@name = name

		@size = 0
		@friction = 0
		@density = 0
		@restituation = 0
		@me = null
		@body = null
		@me = null
		@grounded = false
		@contactCount = 0
		@landed = false
		@prevVelocity = 0
		@startX = 400
		@startY = 500
		#used for updating
		@updateTimer = null
		@linearVelocity = 0
		# easel Refs
		@display = null
		@bodyRef = null
		@rArmRef = null
		@lArmRef = null
		@headRef = null

		@kc = pkg.utils.KrackConverter
		@bf = pkg.utils.BodyFactory
		@kb = pkg.ui.Keyboard
		@kb.init()

		@_createBox2DSkeleton()
		if(@isMe)
			@_setupMe()


	update : () ->
		force = new w.b2Vec2(0,0)
		if (@kb.east)
			force.Add(new w.b2Vec2(@_getForce(true),0))
		if (@kb.west)
			force.Add(new w.b2Vec2(-@_getForce(true),0))
		if (@kb.north && @_isGrounded())
			force.Add(new w.b2Vec2(0, -@_getForce()))

		if ( force.x || force.y)
			@_applyImpulse(force, @me.GetWorldCenter())
			#KrakenCoder.sendMessage(Kraken.playerMove, {id:Kraken.auth, movement:{force:force, center:this.me.GetWorldCenter()}})

		@_generalUpdate()
		
	
	_setupMe : () ->
		_that = @
		pkg.utils.Contact.registerContact("BeginContact", "ground", @name+"_feet", ()->
			_that.landed = true
			_that.contactCount=1
			$(w).trigger("resetup")
		)
		pkg.utils.Contact.registerContact("EndContact", "ground", @name+"_feet", ()->
				_that.contactCount=0
			)


	_createBox2DSkeleton : () ->
		fixList = null
		@body = new b2BodyDef
		@body.type = b2Body.b2_dynamicBody
		@body.position.Set(@kc.getMeters(@startX), @kc.getMeters(@startY))

		@me = @world.CreateBody(@body)
		circle = @bf.createCircleFixture(15,0,30,false,@name+"_feet",false,5,0)
		@me.CreateFixture(circle)
		
		@me.CreateFixture(@bf.createBoxFixture(15,37,0,0,false,@name))
		@me.SetFixedRotation(true)

		# sensor for hit test doesn't work the greatest but it might be worth another look later on
		#@me.CreateFixture(@bf.createBoxFixture(15,17,0,34,true,@name+"_sensor"))

		@me.userData = @name
		fixList = @me.GetFixtureList()
		fixList.SetFilterData(@_setCollisionData(fixList.GetFilterData()))

	_generalUpdate : () ->
		pos = @me.GetPosition()
		vel = @me.GetLinearVelocity()

		# vel -x = to the left
		# vel x = to the right
		# vel -y = up
		# vel y = down
		# Still needs a some work when the animations get in there
		if ( Math.abs(vel.y) > 0 && @kb.north )
			if ( vel.y <= 0 && @currentFrame != "jump" )
				@_playAnimation("jump")
			else if (vel.y > 0 && @currentFrame != "fall")
				@_playAnimation("fall")
		else
			if (Math.abs(vel.x) < 1 && @contactCount == 1 )
				@_playAnimation("standing")
			else
				@_playAnimation("walking")


		@

	_playAnimation : (frame) ->
		#console.log frame
		@

	_applyImpulse : (force, center) ->
		@me.ApplyImpulse(force, center)
		@_police()

	_police : () ->
		velocity = @me.GetLinearVelocity()
		if (velocity.x > consts.speed_limit)
			@me.SetLinearVelocity(new b2Vec2(consts.speed_limit, velocity.y))
		else if (velocity.x < -consts.speed_limit)
			@me.SetLinearVelocity(new b2Vec2(-consts.speed_limit, velocity.y))

	_isGrounded : () ->
		@contactCount == 1

	_getForce : (isX) ->
		if ( isX)
			# Checks if the dude is grouded to apply a slower x velocity if in the air
			# because accelerating while in the air doesn't make any kind of sense
			return if @_isGrounded() then consts.player_force else consts.player_force / 6
		consts.player_force*3

	_setCollisionData : (filter) ->
		filter.groupIndex = consts.playerGroupIndex
		filter

