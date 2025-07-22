///@package com.alkapivo.visu.service.grid.GridItem

///@type {Struct}
global.__GRID_ITEM_DEFAULT_SPRITE = { name: "texture_missing" }
#macro GRID_ITEM_DEFAULT_SPRITE global.__GRID_ITEM_DEFAULT_SPRITE

///@type {Number}
#macro GRID_ITEM_SPEED_SCALE 1000.0

function GridItemSignals() constructor {
  
  ///@type {Boolean}
  kill = false

  ///@type {Boolean}
  damage = false
  
  ///@type {?GridItem}
  bulletCollision = null
  
  ///@type {?GridItem}
  shroomCollision = null
  
  ///@type {?GridItem}
  playerCollision = null

  ///@type {Boolean}
  playerLanded = false

  ///@type {Boolean}
  playerLeave = false

  ///@param {String} key
  ///@param {any} value
  ///@return {GridItemSignals}
  static set = function(key, value) {
    gml_pragma("forceinline")
    Struct.set(this, key, value)
    return this
  }

  ///@return {GridItemSignals}
  static reset = function() {
    gml_pragma("forceinline")
    //this.kill = false
    this.damage = false
    this.bulletCollision = null
    this.shroomCollision = null
    this.playerCollision = null
    this.playerLanded = false
    this.playerLeave = false
    return this
  }
}


///@param {?Struct} [json]
///@param {Boolean} [useScale]
function GridItemMovement(json = null, _useScale = true) constructor {
  
  ///@todo Make it deprecated
  ///@type {Boolean}
  useScale = _useScale

  ///@type {Number}
  speed = Struct.getIfType(json, "speed", Number, 0.0) / (this.useScale ? 100.0 : 1.0)
  
  ///@type {Number}
  speedMax = Struct.getIfType(json, "speedMax", Number, 2.1) / (this.useScale ? 100.0 : 1.0)

  ///@type {Number}
  speedMaxFocus = Struct.getIfType(json, "speedMaxFocus", Number, 0.66) / (this.useScale ? 100.0 : 1.0)
  
  ///@type {Number}
  acceleration = Struct.getIfType(json, "acceleration", Number, 1.92) / (this.useScale ? GRID_ITEM_SPEED_SCALE : 1.0)
  
  ///@type {Number}
  friction = Struct.getIfType(json, "friction", Number, 9.3) / (this.useScale ? 10000.0 : 1.0)

  ///@return {Struct}
  serialize = function() {
    return {
      speed: this.speed * (this.useScale ? 100.0 : 1.0),
      speedMax: this.speedMax * (this.useScale ? 100.0 : 1.0),
      acceleration: this.acceleration * (this.useScale ? GRID_ITEM_SPEED_SCALE : 1.0),
      friction: this.friction * (this.useScale ? 10000.0 : 1.0),
    }
  }
}


///@param {?Struct} [json]
function GridItemEmitter(json = null) constructor {
  
  ///@type {Number}
  x = Struct.getIfType(json, "x", Number, 0)

  ///@type {Number}
  y = Struct.getIfType(json, "y", Number, 0)

  ///@type {Number}
  amount = Struct.getIfType(json, "amount", Number, 1)

  ///@type {Number}
  //arrays = Struct.getIfType(json, "arrays", Number, 1)

  ///@type {NumberTransformer}
  arrays = new NumberTransformer(Struct.getDefault(json, "arrays", {
    value: 1.0,
    target: 1.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {NumberTransformer}
  angle = new NumberTransformer(Struct.getDefault(json, "angle", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {Number}
  angleRng = Struct.getIfType(json, "angleRng", Number, 0.0)

  ///@type {NumberTransformer}
  //angleRng = new NumberTransformer(Struct.getDefault(json, "angleRng", {
  //  value: 0.0,
  //  target: 0.0,
  //  duration: 0.0,
  //  ease: EaseType.LINEAR,
  //}))

  ///@type {Number}
  //angleStep = Struct.getIfType(json, "angleStep", Number, 0.0)

  ///@type {NumberTransformer}
  angleStep = new NumberTransformer(Struct.getDefault(json, "angleStep", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {Number}
  //perArray = Struct.getIfType(json, "perArray", Number, 1)

  ///@type {NumberTransformer}
  perArray = new NumberTransformer(Struct.getDefault(json, "perArray", {
    value: 1.0,
    target: 1.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))
  
  ///@type {NumberTransformer}
  anglePerArray = new NumberTransformer(Struct.getDefault(json, "anglePerArray", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {Number}
  anglePerArrayRng = Struct.getIfType(json, "anglePerArrayRng", Number, 0.0)

  ///@type {NumberTransformer}
  //anglePerArrayRng = new NumberTransformer(Struct.getDefault(json, "anglePerArrayRng", {
  //  value: 0.0,
  //  target: 0.0,
  //  duration: 0.0,
  //  ease: EaseType.LINEAR,
  //}))

  ///@type {Number}
  //anglePerArrayStep = Struct.getIfType(json, "anglePerArrayStep", Number, 0.0)

  ///@type {NumberTransformer}
  anglePerArrayStep = new NumberTransformer(Struct.getDefault(json, "anglePerArrayStep", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))
  
  ///@type {NumberTransformer}
  speed = new NumberTransformer(Struct.getDefault(json, "speed", {
    value: 1.0,
    target: 1.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {Number}
  speedRng = Struct.getIfType(json, "speedRng", Number, 0.0)

  ///@type {NumberTransformer}
  //speedRng = new NumberTransformer(Struct.getDefault(json, "speedRng", {
  //  value: 0.0,
  //  target: 0.0,
  //  duration: 0.0,
  //  ease: EaseType.LINEAR,
  //}))

  ///@type {Number}
  duration = Struct.getIfType(json, "duration", Number, 0)

  ///@type {Number}
  interval = this.amount <= 1 ? this.duration : (this.duration / (this.amount - 1))

  ///@type {NumberTransformer}
  offset = new NumberTransformer(Struct.getDefault(json, "offset", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {NumberTransformer}
  offsetX = new NumberTransformer(Struct.getDefault(json, "offsetX", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {NumberTransformer}
  offsetY = new NumberTransformer(Struct.getDefault(json, "offsetY", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {NumberTransformer}
  wiggleFrequency = new NumberTransformer(Struct.getDefault(json, "wiggleFrequency", {
    value: 1.0,
    target: 1.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {NumberTransformer}
  wiggleAmplitude = new NumberTransformer(Struct.getDefault(json, "wiggleAmplitude", {
    value: 0.0,
    target: 0.0,
    duration: 0.0,
    ease: EaseType.LINEAR,
  }))

  ///@type {any}
  state = Struct.get(json, "state")

  ///@type {?Callable} function(item, controller, emitter) { }
  preCallback = Struct.getIfType(json, "preCallback", Callable)

  ///@type {?Callable} function(item, controller, emitter, idx, arrIdx, x, y, angle, speed) { }
  callback = Struct.getIfType(json, "callback", Callable)

  ///@type {?Callable} function(item, controller, emitter) { }
  postCallback = Struct.getIfType(json, "postCallback", Callable)

  ///@type {Number}
  emitted = 0

  ///@type {Number}
  time = this.interval

  ///@type {Number}
  timeSum = 0.0

  ///@param {GridItem} item
  ///@param {VisuController} controller
  ///@return {GridItemEmitter}
  static update = function(item, controller) {
    if (this.emitted >= this.amount) {
      return
    }

    this.offset.update()
    this.offsetX.update()
    this.offsetY.update()
    this.speed.update()
    this.angle.update()
    this.anglePerArray.update()
    this.wiggleFrequency.update()
    this.wiggleAmplitude.update()
    this.arrays.update()
    //this.angleRng.update()
    this.angleStep.update()
    this.perArray.update()
    //this.anglePerArrayRng.update()
    this.anglePerArrayStep.update()
    //this.speedRng.update()

    this.time += DeltaTime.apply(FRAME_MS)
    if (this.time < this.interval) {
      return this
    }
    this.timeSum += this.time
    this.time = this.time - (floor(this.time / this.interval) * this.interval)

    var _offset = this.offset.value * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
    var _offsetX = this.offsetX.value * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
    var _offsetY = this.offsetY.value * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
    var pixelWidth = SHROOM_SPAWN_AMOUNT
    var pixelHeight = SHROOM_SPAWN_AMOUNT
    var offsetLength = Math.fetchLength(0.0, 0.0, _offsetX, _offsetY)
    var offsetAngle = Math.fetchPointsAngle(0.0, 0.0, _offsetX, _offsetY)
    var posX = this.x + Math.fetchCircleX(offsetLength, offsetAngle)
    var posY = this.y + Math.fetchCircleY(offsetLength, offsetAngle)
    var startAngle = this.angle.value + item.angle
    var spd = this.speed.value + item.speed

    if (this.preCallback != null) {
      this.preCallback(item, controller, this)
    }

    if (this.callback != null) {
      var wiggle = sin(this.wiggleFrequency.value * this.timeSum) * this.wiggleAmplitude.value
      for (var idx = 0; idx < floor(this.arrays.value); idx++) {
        var angle = startAngle + (idx * this.angleStep.value) + random(this.angleRng/*.value*/) + wiggle
        var _posX = Math.fetchCircleX(_offset, angle)
        var _posY = Math.fetchCircleY(_offset, angle)
        for (var arrIdx = 0; arrIdx < floor(this.perArray.value); arrIdx++) {
          this.callback(
            item, controller, this, idx, arrIdx, posX + _posX, posY + _posY,
            angle + this.anglePerArray.value + (arrIdx * this.anglePerArrayStep.value) + random(this.anglePerArrayRng/*.value*/),
            spd + random(this.speedRng/*.value*/)
          )
        }
      }
    }
    this.emitted += 1

    if (this.postCallback != null) {
      this.postCallback(item, controller, this)
    }

    return this
  }

  ///@return {GridItemEmitter}
  static reset = function() {
    this.time = 0.0
    this.timeSum = 0.0
    this.emitted = 0
    this.offset.reset()
    this.offsetX.reset()
    this.offsetY.reset()
    this.speed.reset()
    this.angle.reset()
    this.anglePerArray.reset()
    this.wiggleFrequency.reset()
    this.wiggleAmplitude.reset()
    this.arrays.reset()
    //this.angleRng.reset()
    this.angleStep.reset()
    this.perArray.reset()
    //this.anglePerArrayRng.reset()
    this.anglePerArrayStep.reset()
    //this.speedRng.reset()
    return this
  }

  ///@return {Boolean}
  static finished = function() {
    return this.emitted >= this.amount
  }
}


///@interface
///@param {Struct} config
///@return {GridItem}
function GridItem(config) constructor {

  ///@type {String}
  uid = Assert.isType(config.uid, String, "GridItem.uid must be type of String")

  ///@type {Number}
  x = Assert.isType(Struct.get(config, "x"), Number, "GridItem.x must be type of Number")

  ///@type {Number}
  y = Assert.isType(Struct.get(config, "y"), Number, "GridItem.y must be type of Number")

  ///@type {Number}
  z = Struct.getIfType(config, "z", Number, 0.0)

  ///@type {Sprite}
  sprite = SpriteUtil.parse(Struct.get(config, "sprite"), GRID_ITEM_DEFAULT_SPRITE)

  ///@type {Rectangle}
  mask = Core.isType(Struct.get(config, "mask"), Struct)
    ? new Rectangle(config.mask)
    : new Rectangle({ 
      x: 0, 
      y: 0, 
      width: this.sprite.getWidth(), 
      height: this.sprite.getHeight()
  })

  ///@type {Number}
  speed = Struct.getIfType(config, "speed", Number, 0.0)

  ///@type {Number}
  angle = Struct.getIfType(config, "angle", Number, 0.0)

  ///@type {Number}
  lifespan = Struct.getIfType(config, "lifespan", Number, 0.0)

  ///@type {GridItemSignals}
  signals = new GridItemSignals()

  ///@type {Map<String, GridItemGameMode>}
  gameModes = new Map(String, GridItemGameMode)
  
  ///@type {?GridItemGameMode}
  gameMode = null

  ///@type {Number}
  fadeIn = 0.0

  ///@type {?Struct}
  chunkPosition = Struct.getIfType(config, "chunkPosition", Struct)
    
  ///@param {Number} angle
  ///@return {GridItem}
  static setAngle = function(angle) {
    gml_pragma("forceinline")
    this.angle = angle
    return this
  }

  ///@param {Number} speed
  ///@return {GridItem}
  static setSpeed = function(speed) {
    gml_pragma("forceinline")
    if (speed > 0) {
      this.speed = speed
    }
    return this
  }

  ///@param {Sprite} sprite
  ///@return {GridItem}
  static setSprite = function(sprite) {
    gml_pragma("forceinline")
    this.sprite = sprite
    return this
  }

  ///@param {Rectangle} mask
  ///@return {GridItem}
  static setMask = function(mask) {
    gml_pragma("forceinline")
    this.mask = mask
    return this
  }

  ///@param {GameMode} mode
  ///@return {GridItem}
  static updateGameMode = function(mode) {
    gml_pragma("forceinline")
    this.gameMode = this.gameModes.get(mode)
    this.gameMode.onStart(this, Beans.get(BeanVisuController))
    return this
  }

  ///@param {any} name
  ///@param {any} [value]
  ///@return {GridItem}
  static signal = function(name, value = true) {
    gml_pragma("forceinline")
    this.signals.set(name, value)
    return this
  }

  ///@param {GridItem} target
  ///@return {Bollean} collide?
  static collide = function(target) {
    gml_pragma("forceinline")
    var halfSourceWidth = (this.mask.z * this.sprite.scaleX) / 2.0
    var halfSourceHeight = (this.mask.a * this.sprite.scaleY) / 2.0
    var halfTargetWidth = (target.mask.z * target.sprite.scaleX) / 2.0
    var halfTargetHeight = (target.mask.a * target.sprite.scaleY) / 2.0
    var sourceX = this.x * GRID_SERVICE_PIXEL_WIDTH
    var sourceY = this.y * GRID_SERVICE_PIXEL_HEIGHT
    var targetX = target.x * GRID_SERVICE_PIXEL_WIDTH
    var targetY = target.y * GRID_SERVICE_PIXEL_HEIGHT
    return Math.rectangleOverlaps(
      sourceX - halfSourceWidth, sourceY - halfSourceHeight,
      sourceX + halfSourceWidth, sourceY + halfSourceHeight,
      targetX - halfTargetWidth, targetY - halfTargetHeight,
      targetX + halfTargetWidth, targetY + halfTargetHeight
    )
  }

  ///@param {VisuController} controller
  ///@return {GridItem}
  static move = function() {
    gml_pragma("forceinline")
    this.signals.reset()
    this.x += Math.fetchCircleX(DeltaTime.apply(this.speed), this.angle)
    this.y += Math.fetchCircleY(DeltaTime.apply(this.speed), this.angle)
    return this
  }

  ///@param {VisuController} controller
  ///@return {GridItem}
  static update = function(controller) { 
    gml_pragma("forceinline")
    if (this.gameMode != null) {
      gameMode.update(this, controller)
    }

    if (this.fadeIn < 1.0) {
      this.fadeIn = clamp(this.fadeIn + VISU_FADE_FACTOR, 0.0, 1.0)
    }

    return this
  }
}
