// Generated by CoffeeScript 1.6.1
(function() {
  var consts, pkg, w;

  pkg = this.pkg || {};

  consts = this.consts;

  w = this;

  pkg.KrakenWorld = (function() {

    function KrakenWorld(debug, updateCallback) {
      this._debug = debug != null ? debug : false;
      this._callback = updateCallback != null ? updateCallback : false;
      this.world = null;
      this.bodyFactory = null;
      this._debug = true;
      this._callback = null;
      this._kill = [];
      this._dudes = {};
      this._startBox2D();
    }

    KrakenWorld.prototype.addDude = function(token, isMe) {
      if (isMe == null) {
        isMe = false;
      }
      return this._dudes[token] = new pkg.display.dudes.Dude(this.world, consts.canvas, isMe, token);
    };

    KrakenWorld.prototype._startBox2D = function() {
      var _that;
      this._setupWorld();
      pkg.utils.BodyFactory.setWorld(this.world);
      this._createScene();
      this._addDebug();
      pkg.utils.Contact.init();
      this.world.SetContactListener(w.listener);
      _that = this;
      setInterval(function() {
        return _that._update.call(_that);
      }, consts.fps);
      if ($) {
        return $("body").trigger("worldReady", [this.world]);
      }
    };

    KrakenWorld.prototype._setupWorld = function() {
      return this.world = new w.b2World(new w.b2Vec2(0, consts.gravity), true);
    };

    /*
    		@method _createScene
    			Creates all of the static bodies for the world
    */


    KrakenWorld.prototype._createScene = function() {
      pkg.utils.BodyFactory.createBox(0, 0, consts.worldWidth, 10, false, false, "top");
      pkg.utils.BodyFactory.createBox(0, consts.worldHeight, consts.worldWidth, 10, false, false, "ground");
      pkg.utils.BodyFactory.createBox(0, 0, 10, consts.worldHeight, false, false, "left wall");
      pkg.utils.BodyFactory.createBox(consts.worldWidth, consts.worldHeight, 10, consts.worldHeight, false, false, "right wall");
      pkg.utils.BodyFactory.createBox(550, consts.worldHeight - 50, 300, 10, false, false, "ground").SetAngle(Math.PI / 5.1);
      pkg.utils.BodyFactory.createBox(0, consts.worldHeight - 320, 320, 10, false, false, "ground").SetAngle(Math.PI / 10.2);
      return pkg.utils.BodyFactory.createBox(consts.worldWidth - 180, consts.worldHeight - 50, 300, 10, false, false, "ground").SetAngle(Math.PI / -8);
    };

    KrakenWorld.prototype._addDebug = function() {
      var debugDraw;
      if (!this._debug) {
        return false;
      }
      debugDraw = new w.b2DebugDraw();
      debugDraw.SetSprite(consts.debugContext);
      debugDraw.SetDrawScale(30.0);
      debugDraw.SetFillAlpha(0.5);
      debugDraw.SetLineThickness(1.0);
      debugDraw.SetFlags(w.b2DebugDraw.e_shapeBit);
      return this.world.SetDebugDraw(debugDraw);
    };

    /*
    		@method _killDemBitches
    			Runs on the main world loop to remove flagged bodies
    */


    KrakenWorld.prototype._killDemBitches = function() {
      var i, _i, _ref;
      for (i = _i = o, _ref = this.kill.length; _i <= _ref; i = _i += 1) {
        this.world.DestroyBody(val.me);
      }
      return this._kill = [];
    };

    /*
    		@method _update
    			The main loop of the app.
    				-Updates the box2d world
    				-Kill flagged bodies
    */


    KrakenWorld.prototype._update = function() {
      var dude, tok, _ref;
      this.world.Step(1 / 60, 10, 10);
      this.world.ClearForces();
      this.world.DrawDebugData();
      _ref = this._dudes;
      for (tok in _ref) {
        dude = _ref[tok];
        dude.update();
      }
      if (this._kill > 0) {
        return this.killDemBitches();
      }
    };

    return KrakenWorld;

  })();

}).call(this);
