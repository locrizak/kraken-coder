#namespace
com = krakencoder : {}

class com.krakencoder.Kraken
	init: ->
		console.log "init"
		false


Kraken = new com.krakencoder.Kraken;
window.onload = Kraken.init