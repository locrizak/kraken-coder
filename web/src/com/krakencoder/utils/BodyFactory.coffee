#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
w = this

class pkg.utils.BodyFactory

	_world = null

	###
		@method createbox - Util method to create a body body
			@param {int} the x position of the body in pixels
			@param {int} the y position of the body in pixels
			@param {int} the width of the body
			@param {int} the height of the body
			@param {boolean:false} if the body is dynamic or not
			@param {string} data to attach to the body for use later
	###
	@createBox = (px,py,wid,h,d,isSen,ud)->
		if( @_world == null ) 
			throw ("World need to be set. To set it call com.krakencoder.utils.BodyFactory.setWorld(world)")

		d ?= false
		isSen ?= false
		ud ?= ""

		# convient reference
		kc = pkg.utils.KrackConverter

		bodyDef = new w.b2BodyDef()
		shape = new w.b2PolygonShape()
		fixDef = new w.b2FixtureDef()

		bodyDef.position.Set(kc.getMeters(px), kc.getMeters(py))
		bodyDef.type = w.b2Body.b2_dynamicBody if d
		shape.SetAsBox(kc.getMeters(wid), kc.getMeters(h))

		fixDef.isSensor = isSen
		fixDef.shape = shape
		fixDef.userData = ud
		body = @_world.CreateBody(bodyDef)
		body.SetUserData(ud)
		body.CreateFixture(fixDef)

		#set group index
		fixList = body.GetFixtureList()
		filter = fixList.GetFilterData()
		#filter.categoryBits =0x004;
		#filter.maskBits = -1;
		filter.groupIndex = 2
		fixList.SetFilterData(filter)
		body

	###
		Util method to create a body body
		@method createBox
			@param {int} the width of the fixture
			@param {int} the height of the fixture
			@param {int} the x position of the body
			@param {int} the y position of the body
			@param {boolean} if the fixture is a sensor 
			@param {int} The density of the fixture
			@param {int} the friction of the body
			@param {int} the restitution of the body
	###
	@createBoxFixture = (wid,h,x,y,s,ud,d,f,r,mask)->
		if( @_world == null ) 
			throw ("World need to be set. To set it call com.krakencoder.utils.BodyFactory.setWorld(world)")
		x ?= 0
		y ?= 0
		s ?= false
		# convient reference
		kc = pkg.utils.KrackConverter

		fixDef = new w.b2FixtureDef();
		shape = new w.b2PolygonShape();
		shape.SetAsOrientedBox(kc.getMeters(wid), kc.getMeters(h), new w.b2Vec2(kc.getMeters(x), kc.getMeters(y)))
		fixDef.isSensor = s
		fixDef.shape = shape
		fixDef.userData = ud
		BodyFactory.applyFixtureProps(fixDef,s,d,f,r)

	@createCircleFixture = (wid,x,y,s,ud,d,f,r,mask) ->
		if( @_world == null ) 
 			throw ("World need to be set. To set it call com.krakencoder.utils.BodyFactory.setWorld(world)")
		x ?= 0
		y ?= 0
		s ?= false
		# convient reference
		kc = pkg.utils.KrackConverter
		fixDef = new w.b2FixtureDef()
		shape = new w.b2CircleShape(kc.getMeters(wid))
		shape.m_p.Set(kc.getMeters(x), kc.getMeters(y))
		fixDef.isSensor = s
		fixDef.userData = ud
		fixDef.shape = shape
		BodyFactory.applyFixtureProps(fixDef,d,f,r)


	@applyFixtureProps = (fixDef,d,f,r) ->
		fixDef.density = d if d
		fixDef.friction = f if f
		fixDef.restitution = r if r
		fixDef

	@setWorld : (world) ->
		@_world = world
