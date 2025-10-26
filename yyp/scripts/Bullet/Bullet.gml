///@package io.alkapivo.visu.service.bullet

///@type {Number}
#macro BULLET_FADE_IN_TIME 0.125


///@type {Number}
#macro BULLET_FADE_OUT_TIME 0.33


///@param {String}
///@param {Struct} json
function BulletTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String,
    "BulletTemplate::name must be type of String")

  ///@type {Struct}
  sprite = Assert.isType(Struct.get(json, "sprite"), Struct,
    "BulletTemplate::sprite must be type of Struct")

  ///@type {?Struct}
  mask = Struct.getIfType(json, "mask", Struct)

  ///@type {Number}
  lifespanMax = Struct.getIfType(json, "lifespanMax", Number, 15.0)

  ///@type {Number}
  damage = Struct.getIfType(json, "damage", Number, 1.0)

  ///@type {Boolean}
  wiggle = Struct.getIfType(json, "wiggle", Boolean, false)

  ///@type {Number}
  wiggleTime = Struct.getIfType(json, "wiggleTime", Number, 0.0)

  ///@type {Boolean}
  wiggleTimeRng = Struct.getIfType(json, "wiggleTimeRng", Boolean, false)

  ///@type {Number}
  wiggleFrequency = Struct.getIfType(json, "wiggleFrequency", Number, FRAME_MS)

  ///@type {Boolean}
  wiggleDirRng = Struct.getIfType(json, "wiggleDirRng", Boolean, false)

  ///@type {Number}
  wiggleAmplitude = Struct.getIfType(json, "wiggleAmplitude", Number, 0.0)

  ///@type {?Struct}
  angleOffset = Struct.getIfType(json, "angleOffset", Struct)

  ///@type {Boolean}
  sumAngleOffset = Struct.getIfType(json, "sumAngleOffset", Boolean, false)

  ///@type {Boolean}
  angleOffsetRng = Struct.getIfType(json, "angleOffsetRng", Boolean, false)

  ///@type {Boolean}
  useAngleOffset = Struct.getIfType(json, "useAngleOffset", Boolean, false)

  ///@type {Boolean}
  changeAngleOffset = Struct.getIfType(json, "changeAngleOffset", Boolean, false)

  ///@type {?Struct}
  speedOffset = Struct.getIfType(json, "speedOffset", Struct)

  ///@type {Boolean}
  sumSpeedOffset = Struct.getIfType(json, "sumSpeedOffset", Boolean, false)

  ///@type {Boolean}
  useSpeedOffset = Struct.getIfType(json, "useSpeedOffset", Boolean, false)

  ///@type {Boolean}
  changeSpeedOffset = Struct.getIfType(json, "changeSpeedOffset", Boolean, false)

  ///@type {?String}
  onDeath = Struct.getIfType(json, "onDeath", String)

  ///@type {?Number}
  onDeathAmount = Struct.getIfType(json, "onDeathAmount", Number)

  ///@type {?Number}
  onDeathAngle = Struct.getIfType(json, "onDeathAngle", Number)

  ///@type {?Boolean}
  onDeathAngleRng = Struct.getIfType(json, "onDeathAngleRng", Boolean)

  ///@type {?Number}
  onDeathAngleStep = Struct.getIfType(json, "onDeathAngleStep", Number)

  ///@type {?Number}
  onDeathAngleIncrease = Struct.getIfType(json, "onDeathAngleIncrease", Number)

  ///@type {?Number}
  onDeathRngStep = Struct.getIfType(json, "onDeathRngStep", Number)

  ///@type {?Number}
  onDeathSpeed = Struct.getIfType(json, "onDeathSpeed", Number)

  ///@type {?Boolean}
  onDeathSpeedMerge = Struct.getIfType(json, "onDeathSpeedMerge", Boolean)

  ///@type {?Number}
  onDeathRngSpeed = Struct.getIfType(json, "onDeathRngSpeed", Number)

  ///@return {Struct}
  serialize = function() {
    return {
      angleOffset: this.angleOffset,
      useAngleOffset: this.useAngleOffset,
      changeAngleOffset: this.changeAngleOffset,
      sumAngleOffset: this.sumAngleOffset,
      angleOffsetRng: this.angleOffsetRng,
      speedOffset: this.speedOffset,
      useSpeedOffset: this.useSpeedOffset,
      changeSpeedOffset: this.changeSpeedOffset,
      sumSpeedOffset: this.sumSpeedOffset,

      damage: this.damage,
      lifespanMax: this.lifespanMax,
      sprite: this.sprite,
      mask: this.mask,
      wiggle: this.wiggle,
      wiggleTime: this.wiggleTime,
      wiggleTimeRng: this.wiggleTimeRng,
      wiggleFrequency: this.wiggleFrequency,
      wiggleDirRng: this.wiggleDirRng,
      wiggleAmplitude: this.wiggleAmplitude,
      onDeath: this.onDeath,
      onDeathAmount: this.onDeathAmount,
      onDeathAngle: this.onDeathAngle,
      onDeathAngleRng: this.onDeathAngleRng,
      onDeathAngleStep: this.onDeathAngleStep,
      onDeathAngleIncrease: this.onDeathAngleIncrease,
      onDeathRngStep: this.onDeathRngStep,
      onDeathSpeed: this.onDeathSpeed,
      onDeathSpeedMerge: this.onDeathSpeedMerge,
      onDeathRngSpeed: this.onDeathRngSpeed,
    }
  }

  ///@param {String} uid
  ///@param {Shroom|Player} producer
  ///@param {Number} x
  ///@param {Number} y
  ///@param {Number} angle
  ///@param {Number} speed
  ///@param {?Number|?Struct} [angleOffset]
  ///@param {?Boolean} [angleOffsetRng]
  ///@param {?Boolean} [sumAngleOffset]
  ///@param {?Number|?Struct} [speedOffset]
  ///@param {?Boolean} [sumSpeedOffset]
  ///@param {?Number} [lifespan]
  ///@param {?Number} [damage]
  ///@return {Struct}
  serializeSpawn = function(uid, producer, x, y, angle, speed, angleOffset = null, 
      angleOffsetRng = null, sumAngleOffset = null, speedOffset = null, 
      sumSpeedOffset = null, lifespan = null, damage = null) {

    return {
      uid: uid,
      producer: producer,
      x: x,
      y: y,
      angle: angle,
      speed: speed,
      angleOffset: angleOffset != null ? angleOffset : this.angleOffset,
      angleOffsetRng: angleOffsetRng != null ? angleOffsetRng : this.angleOffsetRng,
      useAngleOffset: angleOffset != null ? true : this.useAngleOffset,
      changeAngleOffset: angleOffset != null ? true : this.changeAngleOffset,
      sumAngleOffset: sumAngleOffset != null ? sumAngleOffset : this.sumAngleOffset,
      speedOffset: speedOffset != null ? speedOffset : this.speedOffset,
      useSpeedOffset: speedOffset != null ? true : this.useSpeedOffset,
      changeSpeedOffset: speedOffset != null ? true : this.changeSpeedOffset,
      sumSpeedOffset: sumSpeedOffset != null ? sumSpeedOffset : this.sumSpeedOffset,

      damage: damage != null ? damage : this.damage,
      lifespanMax: lifespan != null ? lifespan : this.lifespanMax,
      sprite: this.sprite,
      mask: this.mask,
      wiggle: this.wiggle,
      wiggleTime: this.wiggleTime,
      wiggleTimeRng: this.wiggleTimeRng,
      wiggleFrequency: this.wiggleFrequency,
      wiggleDirRng: this.wiggleDirRng,
      wiggleAmplitude: this.wiggleAmplitude,
      onDeath: this.onDeath,
      onDeathAmount: this.onDeathAmount,
      onDeathAngle: this.onDeathAngle,
      onDeathAngleRng: this.onDeathAngleRng,
      onDeathAngleStep: this.onDeathAngleStep,
      onDeathAngleIncrease: this.onDeathAngleIncrease,
      onDeathRngStep: this.onDeathRngStep,
      onDeathSpeed: this.onDeathSpeed,
      onDeathSpeedMerge: this.onDeathSpeedMerge,
      onDeathRngSpeed: this.onDeathRngSpeed,
    }
  }
}


///@param {BulletTemplate} template
function Bullet(template): GridItem(template) constructor {

  ///@param {Number}
  startAngle = this.angle

  ///@param {Number}
  startSpeed = this.speed
  
  ///@type {Player|Shroom}
  producer = template.producer

  ///@type {Number}
  lifespanMax = template.lifespanMax
  
  ///@type {Number}
  damage = template.damage

  ///@type {Boolean}
  wiggle = template.wiggle

  ///@type {Boolean}
  wiggleTimeRng = template.wiggleTimeRng

  ///@type {Number}
  wiggleTime = this.wiggleTimeRng
    ? random(template.wiggleTime)
    : template.wiggleTime
  
  ///@type {Boolean}
  wiggleDirRng = template.wiggleDirRng

  ///@type {Number}
  this.wiggleFrequency = template.wiggleFrequency
    * (this.wiggleDirRng ? choose(1.0, -1.0) : 1.0)

  ///@type {Number}
  wiggleAmplitude = template.wiggleAmplitude

  ///@type {?NumberTransformer}
  angleOffset = template.angleOffset != null && template.useAngleOffset
    ? new NumberTransformer(template.changeAngleOffset
      ? template.angleOffset 
      : Struct.get(template.angleOffset, "value"))
    : null

  ///@type {Boolean}
  angleOffsetRng = template.angleOffsetRng

  ///@type {Boolean}
  sumAngleOffset = template.sumAngleOffset

  ///@param {Number}
  angleOffsetDir = this.angleOffsetRng ? choose(1.0, -1.0) : 1.0

  ///@type {?NumberTransformer}
  speedOffset = template.speedOffset != null && template.useSpeedOffset
    ? new NumberTransformer(template.changeSpeedOffset
      ? template.speedOffset 
      : Struct.get(template.speedOffset, "value"))
    : null

  ///@type {Boolean}
  sumSpeedOffset = template.sumSpeedOffset
  
  ///@type {?String}
  onDeath = template.onDeath

  ///@type {?Number}
  onDeathAmount = template.onDeathAmount

  ///@type {?Number}
  onDeathAngle = template.onDeathAngle

  ///@type {?Boolean}
  onDeathAngleRng = template.onDeathAngleRng

  ///@type {?Number}
  onDeathAngleStep = template.onDeathAngleStep

  ///@type {?Number}
  onDeathAngleIncrease = template.onDeathAngleIncrease

  ///@type {?Number}
  onDeathRngStep = template.onDeathRngStep

  ///@type {?Number}
  onDeathSpeed = template.onDeathSpeed

  ///@type {?Boolean}
  onDeathSpeedMerge = template.onDeathSpeedMerge

  ///@type {?Number}
  onDeathRngSpeed = template.onDeathRngSpeed

  ///@override
  ///@param {VisuController} controller
  ///@return {Bullet}
  static update = function(controller) {
    gml_pragma("forceinline")

    #region @Implement component Lifespan
    this.lifespan += DeltaTime.apply(FRAME_MS)
    if (this.lifespan >= this.lifespanMax
        || this.signals.shroomCollision != null
        || this.signals.playerCollision != null) {
      this.signal("kill")
    }
    #endregion

    #region @Implement component Fade
    if (this.lifespan < this.lifespanMax - BULLET_FADE_OUT_TIME) {
      if (this.fadeIn < 1.0) {
        this.fadeIn = clamp(this.lifespan / BULLET_FADE_IN_TIME, 0.0, 1.0)
      }
    } else if (this.onDeath == null) {
      this.fadeIn = clamp((this.lifespanMax - this.lifespan) / BULLET_FADE_OUT_TIME, 0.0, 1.0)
    }
    #endregion

    #region @Implement component Angle
    var componentAngle = 0.0
    if (this.wiggle) {
      this.wiggleTime += DeltaTime.apply(this.wiggleFrequency * FRAME_MS)
      this.wiggleTime = this.wiggleTime > TAU
        ? this.wiggleTime - TAU
        : (this.wiggleTime < 0.0
          ? this.wiggleTime + TAU
          : this.wiggleTime)
      componentAngle += this.angleOffsetDir * sin(this.wiggleTime) * this.wiggleAmplitude
    }
    
    if (this.angleOffset != null) {
      componentAngle += this.angleOffsetDir * this.angleOffset.update().value
    }

    this.angle = this.sumAngleOffset
      ? this.angle + componentAngle
      : this.startAngle + componentAngle
    #endregion

    #region @Implement component Speed
    var componentSpeed = 0.0
    if (this.speedOffset != null) {
      componentSpeed = this.speedOffset.update().value / GRID_ITEM_SPEED_SCALE
    }

    this.speed = this.sumSpeedOffset
      ? this.speed + componentSpeed
      : this.startSpeed + componentSpeed
    #endregion

    return this
  }
}