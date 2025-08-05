///@package io.alkapivo.visu.service.shroom

///@type {Number}
#macro SHROOM_FADE_IN_TIME 0.25

///@type {Number}
#macro SHROOM_FADE_OUT_TIME 0.33


///@param {String} _name
///@param {Struct} json
function ShroomTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)
  
  ///@type {Struct}
  sprite = Assert.isType(Struct.get(json, "sprite"), Struct)

  ///@type {?Struct}
  mask = Struct.getIfType(json, "mask", Struct, null)

  ///@type {?Number}
  lifespanMax = Struct.getIfType(json, "lifespanMax", Number, 15.0)

  ///@type {?Number}
  healthPoints = Struct.getIfType(json, "healthPoints", Number, 1.0)
  
  ///@type {Boolean}
  hostile = Struct.getIfType(json, "hostile", Boolean, true)

  ///@type {GMArray}
  inherit = Struct.getIfType(json, "inherit", GMArray, [ ])

  ///@type {Struct}
  //gameModes = Struct.appendUnique(
  //  Struct.filter(Struct.getDefault(json, "gameModes", {}), function(gameMode, key) { 
  //    return Core.isType(gameMode, Struct) && Core.isEnum(key, GameMode)
  //  }),
  //  SHROOM_GAME_MODES
  //)
  var _bulletHell = Struct.get(Struct.get(json, "gameModes"), "bulletHell")
  gameModes = {
    bulletHell: _bulletHell != null ? _bulletHell : {},
    platformer: {},
    racing: {}
  }

  ///@type {Boolean}
  use_shroom_mask = Struct.getIfType(json, "use_shroom_mask", Boolean, this.mask != null)

  ///@type {Boolean}
  use_shroom_lifespan = Struct.getIfType(json, "use_shroom_lifespan", Boolean, false)

  ///@type {Boolean}
  use_shroom_healthPoints = Struct.getIfType(json, "use_shroom_healthPoints", Boolean, false)

  ///@type {Boolean}
  use_shroom_inherit = Struct.getIfType(json, "use_shroom_inherit", Boolean, true)

  ///@type {Boolean}
  use_shroom_features = Struct.getIfType(json, "use_shroom_features", Boolean, true)

  ///@type {Boolean}
  shroom_hide = Struct.getIfType(json, "shroom_hide", Boolean, true)

  ///@type {Boolean}
  shroom_hide_texture = Struct.getIfType(json, "shroom_hide_texture", Boolean, true)

  ///@type {Boolean}
  shroom_hide_mask = Struct.getIfType(json, "shroom_hide_mask", Boolean, true)

  ///@type {Boolean}
  shroom_hide_inherit = Struct.getIfType(json, "shroom_hide_inherit", Boolean, true)

  ///@type {Boolean}
  shroom_hide_features = Struct.getIfType(json, "shroom_hide_features", Boolean, true)

  //@return {Struct}
  serialize = function() {
    return {
      name: this.name,
      sprite: this.sprite,
      mask: this.mask,
      lifespanMax: this.lifespanMax,
      healthPoints: this.healthPoints,
      hostile: this.hostile,
      gameModes: this.serializeGameModes(),
      inherit: this.inherit,
      use_shroom_mask: this.use_shroom_mask,
      use_shroom_lifespan: this.use_shroom_lifespan,
      use_shroom_healthPoints: this.use_shroom_healthPoints,
      use_shroom_inherit: this.use_shroom_inherit,
      use_shroom_features: this.use_shroom_features,
      shroom_hide: this.shroom_hide,
      shroom_hide_texture: this.shroom_hide_texture,
      shroom_hide_mask: this.shroom_hide_mask,
      shroom_hide_inherit: this.shroom_hide_inherit,
      shroom_hide_features: this.shroom_hide_features,
    }
  }

  serializeGameModes = function() {
    return JSON.clone(this.gameModes)
  }
  
  serializeSpawn = function(x, y, speed, angle, uid, lifespan = null, hp = null) {
    return {
      name: this.name,
      sprite: this.sprite,
      mask: this.use_shroom_mask ? this.mask : null,
      lifespanMax: lifespan != null ? lifespan : (this.use_shroom_lifespan ? this.lifespanMax : 15),
      healthPoints: hp != null ? hp : (this.use_shroom_healthPoints ? this.healthPoints : 1),
      hostile: this.hostile,
      gameModes: this.use_shroom_features ? JSON.clone(this.gameModes) : { bulletHell: {} },
      inherit: this.use_shroom_inherit ? GMArray.clone(this.inherit) : [],
      x: x,
      y: y,
      speed: speed,
      angle: angle,
      uid: uid,
    }
  }
}

 
///@param {Struct} template
function Shroom(template): GridItem(template) constructor {

  ///@type {Number}
  lifespanMax = template.lifespanMax

  ///@type {Number}
  healthPoints = template.healthPoints

  ///@type {Boolean}
  hostile = template.hostile

  ///@type {Array<Struct>}
  features = new Array(Struct)
  if (Struct.contains(template.gameModes.bulletHell, "features")) {
    GMArray.forEach(template.gameModes.bulletHell.features, function(json, index, features) {
      var featureName = Struct.get(json, "feature")
      var feature = Callable.get(featureName)
      if (!Optional.is(feature)) {
        Logger.warn("GridItem", $"Found unsupported feature '{featureName}'")
        return
      }

      features.add(new feature(json))
    }, this.features)
  }

  static updateFeatures = function(item, controller) {
    gml_pragma("forceinline")
    var features = item.features
    var size = features.size()
    for (var index = 0; index < size; index++) {
      var feature = features.get(index)
      if (feature.updateTimer() && feature.checkConditions(item, controller)) {
        feature.update(item, controller)
      }
    }
    return this
  }

  ///@param {VisuController} controller
  ///@return {Shroom}
  static update = function(controller) {
    gml_pragma("forceinline")
    //if (Optional.is(this.gameMode)) {
    //  gameMode.update(this, controller)
    //}
    if (this.healthPoints == 0) {
      this.signal("kill")
    }

    if (this.signals.damage && !this.signals.kill) {
      controller.sfxService.play("shroom-damage")
    }

    if (this.signals.kill && (this.signals.bulletCollision 
      || this.signals.playerCollision)) {
      controller.sfxService.play("shroom-die")
    }
    this.updateFeatures(this, controller)

    #region @Implement component Lifespan
    this.lifespan += DeltaTime.apply(FRAME_MS)
    if (this.lifespan >= this.lifespanMax) {
      this.signal("kill")
    }
    #endregion
    
    #region @Implement component Fade
    if (this.lifespan < this.lifespanMax - SHROOM_FADE_OUT_TIME) {
      if (this.fadeIn < 1.0) {
        this.fadeIn = clamp(this.lifespan / SHROOM_FADE_IN_TIME, 0.0, 1.0)
      }
    } else {
      this.fadeIn = clamp((this.lifespanMax - this.lifespan) / SHROOM_FADE_OUT_TIME, 0.0, 1.0)
    }
    #endregion

    if (this.lifespan >= this.lifespanMax) {
      this.signal("kill")
    }

    return this
  }

  //this.gameModes.set(GameMode.BULLETHELL, ShroomBulletHellGameMode(template.gameModes.bulletHell))
  //this.gameModes
    //.set(GameMode.BULLETHELL, ShroomBulletHellGameMode(Struct.getDefault(Struct.get(template, "gameModes"), "bulletHell", {})))
    //.set(GameMode.RACING, ShroomRacingGameMode(Struct.getDefault(Struct.get(template, "gameModes"), "racing", {})))
    //.set(GameMode.PLATFORMER, ShroomPlatformerGameMode(Struct.getDefault(Struct.get(template, "gameModes"), "platformer", {})))
}
