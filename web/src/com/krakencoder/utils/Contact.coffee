#namespace: pkg = com.krakencoder
pkg = this.pkg || {}
consts = this.consts
w = this

class pkg.utils.Contact

	_listeners = 
		BeginContact : []
		EndContact : []
		PostSolve : []
		PreSolve : []

	@init = ->
		w.listener.BeginContact = Contact._onBeginContact
		w.listener.EndContact = Contact._onEndContact
		w.listener.PostSolve = Contact._onPostSolve
		w.listener.PreSolve = Contact._onPreSolve

	@registerContact = (type, fixtureA, fixtureB, callback) ->
		fixtureB ?= ""
		if ( _listeners.hasOwnProperty type )
			_listeners[type].push({fixtureA:fixtureA, fixtureB:fixtureB, callback:callback})

	@_onBeginContact = (contact) ->
		if ( _listeners.BeginContact.length > 0)
				for obj in _listeners.BeginContact
					if ( _getIfContactIsRegistered(contact.m_fixtureA.GetUserData(),contact.m_fixtureB.GetUserData(),obj) && typeof obj.callback == "function")
						obj.callback()
		@

	@_onEndContact = (contact) ->
		if ( _listeners.EndContact.length > 0)
				for obj in _listeners.EndContact
					if ( _getIfContactIsRegistered(contact.m_fixtureA.GetUserData(),contact.m_fixtureB.GetUserData(),obj) && typeof obj.callback == "function")
						obj.callback()
		@

	@_onPostSolve = (contact) ->
		@

	@_onPreSolve = (contact) ->
		if ( _listeners.PreSolve.length > 0)
				for obj in _listeners.PreSolve
					if ( _getIfContactIsRegistered(contact.m_fixtureA.GetUserData(),contact.m_fixtureB.GetUserData(),obj) && typeof obj.callback == "function")
						obj.callback()
		@



	_getIfContactIsRegistered = (a,b,val) ->
		# if the contact is just concerned about one body
		if ( a == "" || b == "" )
			if ( a==val.fixtureA || a == val.fixtureB || b == val.fixtureA || b == val.fixtureB )
				return true
		#if both a and b need to be matched
		else
			if ((a==val.fixtureA || a==val.fixtureB) && (b == val.fixtureA || b == val.fixtureB))
				return true
		false


