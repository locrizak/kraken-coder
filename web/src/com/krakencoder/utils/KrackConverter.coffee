pkg = this.pkg || {}
consts = this.consts
w = this

class pkg.utils.KrackConverter

	@_RATIO = 30

	@getPixels = (meters) ->
		meters*pkg.utils.KrackConverter._RATIO
	@getMeters = (pixels) ->
		pixels/pkg.utils.KrackConverter._RATIO 