#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
w = this

class pkg.utils.BodyFactory

	_kc : pkg.utils.KrackConverter

	@_world = null

	constructor : ->

		###
			Util method to create a body body
				@method createbox
				@public
				@param {int} the x position of the body in pixels
				@param {int} the y position of the body in pixels
				@param {int} the width of the body
				@param {int} the height of the body
				@param {boolean:false} if the body is dynamic or not
				@param {string} data to attach to the body for use later
		###

		@createBox = (px,py,w,h,d,isSen,ud)->
			if( @_world == null ) throw ("World need to be set. To set it call com.krakencoder.utils.BodyFactory.setWorld(world)")

			d ?= false
			isSen ?= false
			ud ?= ""

			bodyDef = new w.b2BodyDef()
			shape = new w.b2PolygonShape()
			fixDef = new w.b2FictureDef()

			bodyDef.position.Set(@_kc.getMeters(px), @_kc.getMeters(py))
			bodyDef.type = w.b2Body.b2_dynamicBody if d
			shape.SetAsBox(@_kc.getMeters(w), @_kc.getMeters(h))

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
			filter.groupIndex = 2;
			fixList.SetFilterData(filter)
			body

		@setWorld : (world) ->
			@_world = world