#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
win = this

class pkg.KrakenWorld
	
	_debug : null
	_callback : null
	world : null
	kill : []
	bodyFactory = null

	constructor : (debug, updateCallback) ->
		@_debug = debug ? false
		@_callback = updateCallback ? false
		@_startBox2D()

	_startBox2D : ->
		@_setupWorld()



	_setupWorld : ->
		@world = new win.b2World( new win.b2Vec2(0, consts.gravity), true )
		console.log "setup world"


