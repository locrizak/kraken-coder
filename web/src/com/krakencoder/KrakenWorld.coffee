#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
w = this

class pkg.KrakenWorld
	
	

	constructor : (debug, updateCallback) ->
		@_debug = debug ? false
		@_callback = updateCallback ? false
		@world = null
		@bodyFactory = null
		@_debug = true
		@_callback = null
		@_kill = []
		@_dudes = {}
		@_startBox2D()

	addDude : (token, isMe = false) ->
		@_dudes[token] = new pkg.display.dudes.Dude(@world, consts.canvas, isMe, token)

	_startBox2D : ->
		@_setupWorld()
		pkg.utils.BodyFactory.setWorld @world
		@_createScene()
		@_addDebug()

		pkg.utils.Contact.init()
		@world.SetContactListener(w.listener)
		#setInterval(@_update, consts.fps)

		_that = @
		setInterval(()->
			_that._update.call(_that)
		, consts.fps)

		if ($)
			$("body").trigger("worldReady", [@world])



	_setupWorld : ->
		@world = new w.b2World( new w.b2Vec2(0, consts.gravity), true )

	###
		@method _createScene
			Creates all of the static bodies for the world
	###

	_createScene : ->
		pkg.utils.BodyFactory.createBox(0,0,consts.worldWidth,10,false,false,"top");
		pkg.utils.BodyFactory.createBox(0,consts.worldHeight, consts.worldWidth, 10,false,false,"ground");
		pkg.utils.BodyFactory.createBox(0,0,10,consts.worldHeight,false,false,"left wall");
		pkg.utils.BodyFactory.createBox(consts.worldWidth,consts.worldHeight,10,consts.worldHeight,false,false,"right wall");
		pkg.utils.BodyFactory.createBox(550,consts.worldHeight-50,300, 10,false,false,"ground").SetAngle(Math.PI/5.1);
		pkg.utils.BodyFactory.createBox(0,consts.worldHeight-320,320, 10,false,false,"ground").SetAngle(Math.PI/10.2)#.SetAngle(Math.PI/5);
		pkg.utils.BodyFactory.createBox(consts.worldWidth-180,consts.worldHeight-50,300, 10,false,false,"ground").SetAngle(Math.PI/-8);

		#rightRamp;

	_addDebug : ->
		if (!@_debug)
			return false
		debugDraw = new w.b2DebugDraw()
		debugDraw.SetSprite(consts.debugContext);
		debugDraw.SetDrawScale(30.0);
		debugDraw.SetFillAlpha(0.5);
		debugDraw.SetLineThickness(1.0);
		debugDraw.SetFlags(w.b2DebugDraw.e_shapeBit);
		@world.SetDebugDraw(debugDraw)

	###
		@method _killDemBitches
			Runs on the main world loop to remove flagged bodies
	###
	_killDemBitches : ->
		for i in [o..@kill.length] by 1
			@world.DestroyBody(val.me)
		@_kill = []

	###
		@method _update
			The main loop of the app.
				-Updates the box2d world
				-Kill flagged bodies
	###
	_update : ->
		@world.Step(1/60, 10, 10)
		@world.ClearForces()
		@world.DrawDebugData()

		for tok, dude of @_dudes
			dude.update()

		if ( @_kill > 0 )
			@killDemBitches();




