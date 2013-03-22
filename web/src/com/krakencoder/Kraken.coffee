#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
window = this

class pkg.Kraken

	#private vars
	_canvas : null
	_context : null
	_$canvas : null
	_$canvasDebug : null
	_world : null
	_me : null
	_dudes : {}
	_socket : null
	_forDestruction : []
	_playerUpdates : []

	constructor: ->
		@_onConnect()

	#private methods
	_onConnect : ->
		@_buildWorld()
		@_world = new pkg.KrakenWorld(true)

		@_world.addDude("abc", true)

	_buildWorld : ->
		if ($("#krack-world-container").length > 0 )
			$("<canvas></canvas>")
				.attr({
					id:"krack-world"
					#width:$(window).width()
					#height:$(window).height()
					width:consts.worldWidth,
					height:consts.worldHeight
				})
				#.appendTo("#krack-world-container")
			$("<canvas></canvas>")
				.attr({
					id:"krack-world-debug"
					#width:$(window).width()
					#height:$(window).height()
					width:consts.worldWidth,
					height:consts.worldHeight
				})
				.appendTo("#krack-world-container")
			$("#krack-world-container").css(
				#width: $(window).width()
				#height: $(window).height()
				width:consts.worldWidth,
				height:consts.worldHeight
			)
			@_$canvas = $("#krack-world")
			@_$debugCanvas = $("#krack-world-debug")
			#consts.canvas = document.getElementById("krack-world")
			#consts.context = consts.canvas.getContext("2d")
			consts.debugCanvas = document.getElementById("krack-world-debug")
			consts.debugContext = consts.debugCanvas.getContext("2d")
			consts.$canvasContainer = $("#krack-world-container")

			@_setupWorldContainers()
			###
			#@TODO setup easeljs stuff
			#Kraken.stage = new createjs.Stage(Kraken.canvas);
			#createjs.Ticker.setFPS(30);
			#createjs.Ticker.useRAF = true;

			#@TODO use this to setup stage mouse position
			Kraken.debugCanvas.addEventListener('mousemove', function(evt) {
		        var rect = Kraken.canvas.getBoundingClientRect();
		        Kraken.mouseX = evt.clientX - rect.left;
				Kraken.mouseY = evt.clientY - rect.top;
		      }, false);
 			
 			setupWorldContainers();
 			
 			Kraken.canvas.addEventListener("mousemove",function(e){
 				var rect = Kraken.canvas.getBoundingClientRect();
				console.log(rect);
				Kraken.mouseX = e.clientX - rect.left;
				Kraken.mouseY = e.clientY - rect.top;
 			}, false);
			###
	_setupWorldContainers : ->
		#@TODO for easel to setup multiple containers for a little bit of paralax
		###
		function setupWorldContainers(){
		Kraken.foregroundContainer = new createjs.Container();
		Kraken.playerContainer = new createjs.Container();
		Kraken.backgroundContainer = new createjs.Container();
		Kraken.middleBackgroundContainer = new createjs.Container();
		Kraken.farBackgroundContainer = new createjs.Container();
		
		Kraken.stage.addChild(Kraken.farBackgroundContainer);
		Kraken.stage.addChild(Kraken.backgroundContainer);
		Kraken.stage.addChild(Kraken.middleBackgroundContainer);
		Kraken.stage.addChild(Kraken.playerContainer);
		Kraken.stage.addChild(Kraken.foregroundContainer);
		
		console.log(Kraken.stage);
		
		var boatfg = new createjs.Bitmap("/core/images/boat/full.png");
		var boatbg = new createjs.Bitmap("/core/images/boat/full.png");
		var bg = new createjs.Bitmap("/core/images/background_8bit.png");
		
		var wave = new createjs.Bitmap("/core/images/waves.png");
		Kraken.backgroundContainer.addChild(wave);
		#
		for (var x = 0; x < Kraken.worldWidth; x+=150){
			for ( var y = 0; y < Kraken.worldHeight; y+=100){
				var wave = new createjs.BitmapAnimation(new createjs.SpriteSheet(waveJson));
				wave.x = x;
				wave.y = y;
				Kraken.middleBackgroundContainer.addChild(wave);
			}
		}
		#
		
		
		
		boatbg.y = 500;
		boatfg.y = 520;
		Kraken.foregroundContainer.addChild(boatfg);
		
		Kraken.farBackgroundContainer.addChild(bg);
		
		//Kraken.backgroundContainer.addChild(boatbg);
		
	};
		###
			



this.onload = ->
	Kraken = new pkg.Kraken