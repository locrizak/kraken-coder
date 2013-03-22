#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
w = this

class pkg.ui.Keyboard

	@west = false
	@east = false
	@north = false
	@south = false

	@_upAllowed = true
	@_inited = false

	@init = () ->
		if (!Keyboard._inited)
			Keyboard._inited = true
			$(window).on("keydown", Keyboard._onKeyDown)
			$(window).on("keyup", Keyboard._onKeyDown)
			$(window).on("resetup", Keyboard._resetUp)

	@_onKeyDown : (e) ->
		switch e.keyCode
			when 37, 65
				Keyboard.west = e.type == "keydown"
			when 38, 87
				if( e.type == "keydown" &&	Keyboard._upAllowed)
					Keyboard.north = true
					Keyboard._upAllowed = false
			when 39,68
				Keyboard.east = e.type == "keydown"

	@_resetUp : (e) ->
		Keyboard.north = false
		Keyboard._upAllowed = true