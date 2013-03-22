window = exports ? this

window.namespace = 
	com : 
		krakencoder : 
			utils : {}
			display :
				dudes :{}
			ui : {}

window.pkg = window.namespace.com.krakencoder

window.consts = 
	worldWidth : 2000
	worldHeight : 1000
	windowMidWidth : if typeof $ != "undefined" then $(window).width()/2 else false
	windowMidHeight : if typeof $ != "undefined" then $(window).height()/2 else false
	offsetX:0
	offsetY:0
	#box2d
	fps : (1000/60)
	timestep : 1/60
	velocity_iter : 10
	position_iter : 10
	gravity : 9.8
	debug:true
	#categories
	playerCategory : 0x001
	playerMask : 0x000
	playerGroupIndex: -1
	#easel
	stage:null
	foregroundContainer:null
	playerContainer:null
	backgroundContainer:null
	middleBackgroundContainer:null
	farBackgroundContainer:null
	#mouse
	mouseX:0
	mouseY:0
	#player
	speed_limit : 9
	player_force : 1.5
	#canvas
	$canvasContainer:null
	canvas:null
	debugCanvas:null
	context:null
	debugContext:null
	#node
	port:9000
	io : null
	#sent from node
	#set in KrakenCoder on the client side
	auth:null
	#socket events
	onAuth : "iConnected"
	newClient : "biggerPartyStart"
	onDisconnect : "peaceOut!"
	playerMove : "playerMove"
	updatePlayer: "updatePlayer"

window.b2Vec2 = Box2D.Common.Math.b2Vec2
window.b2AABB = Box2D.Collision.b2AABB
window.b2BodyDef = Box2D.Dynamics.b2BodyDef
window.b2Body = Box2D.Dynamics.b2Body
window.b2FixtureDef = Box2D.Dynamics.b2FixtureDef
window.b2Fixture = Box2D.Dynamics.b2Fixture
window.b2World = Box2D.Dynamics.b2World
window.b2MassData = Box2D.Collision.Shapes.b2MassData
window.b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
window.b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
window.b2DebugDraw = Box2D.Dynamics.b2DebugDraw
window.b2MouseJointDef =  Box2D.Dynamics.Joints.b2MouseJointDef
window.listener = new Box2D.Dynamics.b2ContactListener
window.contactEdge = Box2D.Dynamics.Contacts.b2ContactEdge

