///@package io.alkapivo.visu.service.shroom

///@type {Number}
#macro SHROOM_FADE_IN_TIME 0.25

///@type {Number}
#macro SHROOM_FADE_OUT_TIME 0.33


///@param {String} _name
///@param {Struct} json
function ShroomTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String,
    "ShroomTemplate::name must be type of String")
  
  ///@type {Struct}
  sprite = Assert.isType(Struct.get(json, "sprite"), Struct,
    "ShroomTemplate::sprite must be type of Struct")

  ///@type {?Struct}
  mask = Struct.getIfType(json, "mask", Struct)

  ///@type {Number}
  lifespanMax = Struct.getIfType(json, "lifespanMax", Number, 15.0)

  ///@type {Number}
  healthPoints = Struct.getIfType(json, "healthPoints", Number, 1.0)
  
  ///@type {Boolean}
  hostile = Struct.getIfType(json, "hostile", Boolean, true)

  ///@type {GMArray}
  inherit = Struct.getIfType(json, "inherit", GMArray, [])

  ///@type {GMArray}
  onDamage = Struct.getIfType(json, "onDamage", GMArray, [])

  ///@type {GMArray}
  onDeath = Struct.getIfType(json, "onDeath", GMArray, [])

  ///@type {GMArray}
  queue = Struct.getIfType(json, "queue", GMArray, [])

  ///@type {GMArray}
  features = Struct.getIfType(json, "features", GMArray, [])

  /* migrate to onDamage and onDeath
  features = []
  var _features = Struct.getIfType(json, "features", GMArray, [])
  GMArray.forEach(_features, function(entry, idx, template) {
    var type = Struct.get(entry, "type")
    if (!Core.isType(type, String)) {
      return
    }

    Core.print("parse", idx, "type", type)
    switch (type) {
      case "LifespanFeature":
        break
      case "CoinFeature":
        GMArray.add(template.onDeath, {
          type: type,
          conditions: [],
          data: Struct.getIfType(entry, "data", Struct, {}),
        })
        break
      case "ParticleFeature":
        GMArray.add(String.contains(entry.data.particle, "death") ? template.onDeath : template.onDamage, {
          type: type,
          conditions: [],
          data: Struct.getIfType(entry, "data", Struct, {}),
        })
        break
      default:
        GMArray.add(template.features, {
          type: type,
          conditions: Struct.getIfType(entry, "conditions", GMArray, []),
          data: Struct.getIfType(entry, "data", Struct, {}),
        })
        break
    }
  }, this)
  */

  ///@type {Boolean}
  use_shroom_mask = Struct.getIfType(json, "use_shroom_mask", Boolean, this.mask != null)

  ///@type {Boolean}
  use_shroom_lifespan = Struct.getIfType(json, "use_shroom_lifespan", Boolean, false)

  ///@type {Boolean}
  use_shroom_healthPoints = Struct.getIfType(json, "use_shroom_healthPoints", Boolean, false)

  ///@type {Boolean}
  use_shroom_inherit = Struct.getIfType(json, "use_shroom_inherit", Boolean, true)

  ///@type {Boolean}
  use_shroom_on_damage = Struct.getIfType(json, "use_shroom_on_damage", Boolean, true)

  ///@type {Boolean}
  use_shroom_on_death = Struct.getIfType(json, "use_shroom_on_death", Boolean, true)

  ///@type {Boolean}
  use_shroom_queue = Struct.getIfType(json, "use_shroom_queue", Boolean, true)

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
  shroom_hide_on_damage = Struct.getIfType(json, "shroom_hide_on_damage", Boolean, true)

  ///@type {Boolean}
  shroom_hide_on_death = Struct.getIfType(json, "shroom_hide_on_death", Boolean, true)

  ///@type {Boolean}
  shroom_hide_queue = Struct.getIfType(json, "shroom_hide_queue", Boolean, true)

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
      onDamage: JSON.clone(this.onDamage).getContainer(),
      onDeath: JSON.clone(this.onDeath).getContainer(),
      queue: JSON.clone(this.queue).getContainer(),
      features: JSON.clone(this.features).getContainer(),
      inherit: GMArray.clone(this.inherit),
      //onDamage: this.onDamage,
      //onDeath: this.onDeath,
      //queue: this.queue,
      //features: this.features,
      //inherit: this.inherit,

      use_shroom_mask: this.use_shroom_mask,
      use_shroom_lifespan: this.use_shroom_lifespan,
      use_shroom_healthPoints: this.use_shroom_healthPoints,
      use_shroom_inherit: this.use_shroom_inherit,
      use_shroom_features: this.use_shroom_features,
      use_shroom_queue: this.use_shroom_queue,
      use_shroom_on_damage: this.use_shroom_on_damage,
      use_shroom_on_death: this.use_shroom_on_death,
      shroom_hide: this.shroom_hide,
      shroom_hide_texture: this.shroom_hide_texture,
      shroom_hide_mask: this.shroom_hide_mask,
      shroom_hide_inherit: this.shroom_hide_inherit,
      shroom_hide_features: this.shroom_hide_features,
      shroom_hide_queue: this.shroom_hide_queue,
      shroom_hide_on_damage: this.shroom_hide_on_damage,
      shroom_hide_on_death: this.shroom_hide_on_death,
    }
  }

  serializeSpawn = function(x, y, speed, angle, uid, lifespan = null, hp = null) {
    return {
      name: this.name,
      sprite: this.sprite,
      mask: this.use_shroom_mask ? this.mask : null,
      lifespanMax: lifespan != null ? lifespan : (this.use_shroom_lifespan ? this.lifespanMax : 15),
      healthPoints: hp != null ? hp : (this.use_shroom_healthPoints ? this.healthPoints : 1),
      hostile: this.hostile,
      onDamage: this.use_shroom_on_damage ? JSON.clone(this.onDamage).getContainer() : [],
      onDeath: this.use_shroom_on_death ? JSON.clone(this.onDeath).getContainer() : [],
      queue: this.use_shroom_queue ? JSON.clone(this.queue).getContainer() : [],
      features: this.use_shroom_features ? JSON.clone(this.features).getContainer() : [],
      inherit: this.use_shroom_inherit ? GMArray.clone(this.inherit) : [],
      //onDamage: this.use_shroom_on_damage ? this.onDamage : [],
      //onDeath: this.use_shroom_on_death ? this.onDeath : [],
      //queue: this.use_shroom_queue ? this.queue : [],
      //features: this.use_shroom_features ? this.features : [],
      //inherit: this.use_shroom_inherit ? this.inherit : [],
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

  ///@private
  ///@param {GMArray<GridItemFeature>} features
  ///@return {Array<GridItemFeature>}
  static parseFeatures = function(features) {
    static parseFeature = function(json, index, features) {
      var featureName = Struct.get(json, "type")
      var feature = Callable.get(featureName)
      return feature != null
        ? features.add(new feature(json))
        : Logger.warn("Shroom", $"Found unsupported feature: '{featureName}'")
    }

    var parsed = new Array(Struct)
    GMArray.forEach(features, parseFeature, parsed)
    return parsed
  }

  ///@type {Number}
  lifespanMax = template.lifespanMax

  ///@type {Number}
  healthPoints = template.healthPoints

  ///@type {Boolean}
  hostile = template.hostile

  ///@type {Array<GridItemFeature>}
  onDamage = parseFeatures(template.onDamage)

  ///@type {Array<GridItemFeature>}
  onDeath = parseFeatures(template.onDeath)

  ///@type {Queue<GridItemFeature>}
  queue = new Queue(GridItemFeature, parseFeatures(template.queue).getContainer())

  ///@type {Array<GridItemFeature>}
  features = parseFeatures(template.features)

  ///@private
  ///@param {GridItem} item
  ///@param {VisuController} controller
  ///@param {Array<GridItemFeature} features
  ///@return {Shroom}
  static updateGridItemFeatures = function(item, controller, features) {
    gml_pragma("forceinline")
    var size = features.size()
    for (var index = 0; index < size; index++) {
      var feature = features.get(index)
      if (feature.checkConditions(item, controller)) {
        feature.update(item, controller)
      }
    }
    return this
  }

  ///@private
  ///@param {GridItem} item
  ///@param {VisuController} controller
  ///@param {Queue<GridItemFeature} queue
  ///@return {Shroom}
  static updateGridItemFeatureQueue = function(item, controller, queue) {
    var feature = queue.peek()
    if (feature == null) {
      return item
    }
    
    feature.update(item, controller)
    if (feature.updateTimer()) {
      queue.pop()
    }

    return item
  }

  ///@param {VisuController} controller
  ///@return {Shroom}
  static update = function(controller) {
    gml_pragma("forceinline")
    if (this.healthPoints == 0.0 && !this.signals.kill) {
      this.signals.freeReason = "shooted"
      this.signal("kill")
    }

    if (this.signals.damage && !this.signals.kill) {
      this.updateGridItemFeatures(this, controller, this.onDamage)
      controller.sfxService.play("shroom-damage")
    }

    if (this.signals.kill && (this.signals.bulletCollision 
      || this.signals.playerCollision)) {
      this.updateGridItemFeatures(this, controller, this.onDeath)
      controller.sfxService.play("shroom-die")
    }

    this.updateGridItemFeatures(this, controller, this.features)
    this.updateGridItemFeatureQueue(this, controller, this.queue)

    #region @Implement component Lifespan
    this.lifespan += DELTA_TIME * FRAME_MS
    //this.lifespan += DeltaTime.apply(FRAME_MS)
    if (!this.signals.kill && this.lifespan >= this.lifespanMax) {
      this.signals.freeReason = "expired"
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

    return this
  }
}
