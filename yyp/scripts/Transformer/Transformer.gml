///@package io.alkapivo.core.util

///@interface
///@param {Struct} [json]
function Transformer(json = null) constructor {

  ///@type {any}
  value = Core.isType(json, Struct) ? Struct.get(json, "value"): json

  ///@type {any}
  startValue = this.value

  ///@type {Boolean}
  finished = false

  ///@type {Boolean}
  overrideValue = Struct.get(json, "overrideValue") == true

  ///@return {any}
  static get = function() {
    return this.value
  }

  ///@param {any} value
  ///@return {Transformer}
  static set = function(value) {
    this.value = value 
    return this
  }

  ///@return {Transformer}
  static update = function() { return this }

  ///@return {Struct} 
  static serialize = function() {
    return {
      value: this.value
    }
  }

  ///@return {Transformer}
  static reset = function() {
    this.finished = false 
    this.value = this.startValue
    return this
  }
}


///@param {?Struct} [json]
function ColorTransformer(json = null) constructor {

  ///@type {String}
  startValue = Core.isType(json, String)
    ? json
    : Struct.getIfType(json, "value", String, "#ffffff")

  ///@type {Color}
  value = ColorUtil.fromHex(this.startValue)

  ///@type {Boolean}
  finished = false

  ///@type {Boolean}
  overrideValue = Struct.get(json, "overrideValue") == true

  ///@type {Color}
  target = ColorUtil.fromHex(Struct.get(json, "target"))

  ///@type {Number}
  duration = Struct.getIfType(json, "duration", Number, 0.0)

  ///@type {Number}
  factor = Struct.getIfType(json, "factor", Number, 0.0)

  ///@return {Transformer}
  static setDuration = function(duration) {
    this.duration = clamp(duration, 0.0, 999.9)

    var length = max(
      abs(this.value.red - this.target.red),
      abs(this.value.green - this.target.green),
      abs(this.value.blue - this.target.blue)
    )
    this.factor = this.duration > 0.0 && length > 0.0
      ? (length / (this.duration * GAME_FPS))
      : 1.0
    return this
  }
  
  ///@return {any}
  static get = function() {
    return this.value
  }

  ///@param {any} value
  ///@return {Transformer}
  static set = function(value) {
    this.value = value 
    return this
  }

  ///@return {ColorTransformer}
  static update = function() {
    if (this.finished) {
      return this
    }

    var _factor = DeltaTime.apply(this.factor)
    this.value.red = Math.transformNumber(this.value.red, this.target.red, _factor)
    this.value.green = Math.transformNumber(this.value.green, this.target.green, _factor)
    this.value.blue = Math.transformNumber(this.value.blue, this.target.blue, _factor)
    this.value.alpha = Math.transformNumber(this.value.alpha, this.target.alpha, _factor)
    if (ColorUtil.areEqual(this.value, this.target)) {
      this.finished = true
    }
    return this
  }

  ///@return {Struct}
  static serialize = function() {
    return {
      value: this.value.serialize(),
      target: this.target.serialize(),
      duration: this.duration,
    }
  }

  ///@return {ColorTransformer}
  static reset = function() {
    this.finished = false

    var color = ColorUtil.fromHex(this.startValue)
    this.value.red = color.red
    this.value.green = color.green
    this.value.blue = color.blue
    this.value.alpha = color.alpha
    return this
  }

  this.setDuration(this.duration)
}


///@param {?Struct|?Number} [json]
function NumberTransformer(json = null) constructor {

  ///@type {Number}
  value = Core.isType(json, Number) 
    ? json
    : Struct.getIfType(json, "value", Number, 0.0)

  ///@type {Number}
  startValue = this.value

  ///@type {Boolean}
  finished = false

  ///@type {Boolean}
  overrideValue = Struct.get(json, "overrideValue") == true

  ///@type {Number}
  target = Struct.getIfType(json, "target", Number, this.value)

  ///@type {Number}
  factor = Struct.getIfType(json, "factor", Number, 1.0)

  ///@type {Number}
  startFactor = this.factor

  ///@type {Number}
  increase = Struct.getIfType(json, "increase", Number, 0.0)

  ///@type {Number}
  size = this.target - this.value

  ///@type {EaseType}
  easeType = Struct.getIfType(json, "ease", String, EaseType.LEGACY)

  ///@type {Callable}
  ease = Ease.get(this.easeType)
  
  ///@type {Number}
  duration = Struct.getIfType(json, "duration", Number, 1.0)
  if (this.easeType == EaseType.LEGACY) {
    this.duration = this.factor != 0.0
      ? (abs(this.value - this.target) / abs(this.factor)) / GAME_FPS
      : this.duration
  }
  
  ///@type {Number}
  time = Struct.getIfType(json, "time", Number, 0.0)

  ///@type {Number}
  startTime = this.time
  
  ///@return {any}
  static get = function() {
    return this.value
  }

  ///@param {any} value
  ///@return {Transformer}
  static set = function(value) {
    this.value = value 
    return this
  }
  
  ///@return {NumberTransformer}
  static updateNew = function() {
    if (this.finished) {
      return this
    }

    this.time += DeltaTime.apply()
    if (this.time >= this.duration) {
      this.finished = true
      this.time = this.duration
    }
    this.value = this.startValue + (this.size * this.ease((this.duration == 0.0 ? 0.0 : (this.time / this.duration))))

    return this
  }

  ///@return {NumberTransformer}
  static updateLegacy = function() {
    if (this.finished) {
      return this
    }

    this.factor += DeltaTime.apply(this.increase * 0.5)
    this.value = Math.transformNumber(this.value, this.target, DeltaTime.apply(this.factor))
    this.factor += DeltaTime.apply(this.increase * 0.5)
    if (this.value == this.target) {
      this.finished = true
    }

    return this
  }

  ///@return {NumberTransformer}
  static update = function() {
    return this.easeType == EaseType.LEGACY ? this.updateLegacy() : this.updateNew()
  }

  ///@return {Struct}
  static serialize = function() {
    return {
      value: this.value,
      target: this.target,
      factor: this.factor,
      increase: this.increase,
      duration: this.duration,
      ease: this.easeType,
    }
  }

  ///@return {NumberTransformer}
  static reset = function() {
    this.finished = false 
    this.value = this.startValue
    this.factor = this.startFactor
    this.time = this.startTime
    this.size = this.target - this.value
    this.ease = Ease.get(this.easeType)
    if (this.easeType == EaseType.LEGACY) {
      this.duration = this.factor != 0.0
        ? (abs(this.value - this.target) / abs(this.factor)) / GAME_FPS
        : this.duration
    }
    
    return this
  }
}


///@param {?Struct} [json]
function Vector2Transformer(json = null) constructor {

  ///@type {NumberTransformer}
  x = new NumberTransformer(Struct.get(json, "x"))

  ///@type {NumberTransformer}
  y = new NumberTransformer(Struct.get(json, "y"))

  ///@type {Vector2}
  value = new Vector2(this.x.value, this.y.value)

  ///@type {Boolean}
  finished = false

  ///@type {Boolean}
  overrideValue = Struct.get(json, "overrideValue") == true

  ///@return {any}
  static get = function() {
    return this.value
  }

  ///@param {any} value
  ///@return {Transformer}
  static set = function(value) {
    this.value = value 
    return this
  }

  ///@return {Vector2Transformer}
  static update = function() {
    if (this.finished) {
      return this
    }
    
    this.x.value = this.value.x
    this.y.value = this.value.y
    this.value.x = this.x.update().get()
    this.value.y = this.y.update().get()

    if (this.value.x == this.x.target 
      && this.value.y == this.y.target) {
      this.finished = true
    }
    return this
  }

  ///@return {Struct}
  static serialize = function() {
    return {
      x: this.x.serialize(),
      y: this.y.serialize(),
    }
  }

  ///@return {Vector2Transformer}
  static reset = function() {
    this.finished = false 
    this.x.reset()
    this.y.reset()
    return this
  }
}


///@param {?Struct} [json]
function Vector3Transformer(json = null) constructor {

  ///@type {NumberTransformer}
  x = new NumberTransformer(Struct.get(json, "x"))

  ///@type {NumberTransformer}
  y = new NumberTransformer(Struct.get(json, "y"))

  ///@type {NumberTransformer}
  z = new NumberTransformer(Struct.get(json, "z"))

  ///@type {Vector3}
  value = new Vector3(this.x.value, this.y.value, this.z.value)

  ///@type {Boolean}
  finished = false

  ///@type {Boolean}
  overrideValue = Struct.get(json, "overrideValue") == true

  ///@return {any}
  static get = function() {
    return this.value
  }

  ///@param {any} value
  ///@return {Transformer}
  static set = function(value) {
    this.value = value 
    return this
  }

  ///@return {Vector3Transformer}
  static update = function() {
    if (this.finished) {
      return this
    }

    this.x.value = this.value.x
    this.y.value = this.value.y
    this.z.value = this.value.z
    this.value.x = this.x.update().get()
    this.value.y = this.y.update().get()
    this.value.z = this.z.update().get()

    if (this.value.x == this.x.target 
      && this.value.y == this.y.target
      && this.value.z == this.z.target) {

      this.finished = true
    }
    return this
  }

  ///@return {Struct}
  static serialize = function() {
    return {
      x: this.x.serialize(),
      y: this.y.serialize(),
      z: this.z.serialize(),
    }
  }

  ///@return {Vector3Transformer}
  static reset = function() {
    this.finished = false 
    this.x.reset()
    this.y.reset()
    this.z.reset()
    return this
  }
}


///@param {?Struct} [json]
function Vector4Transformer(json = null) constructor {

  ///@type {NumberTransformer}
  x = new NumberTransformer(Struct.get(json, "x"))

  ///@type {NumberTransformer}
  y = new NumberTransformer(Struct.get(json, "y"))

  ///@type {NumberTransformer}
  z = new NumberTransformer(Struct.get(json, "z"))

  ///@type {NumberTransformer}
  a = new NumberTransformer(Struct.get(json, "a"))

  ///@type {Vector4}
  value = new Vector4(this.x.value, this.y.value, this.z.value, this.a.value)

  ///@type {Boolean}
  finished = false

  ///@type {Boolean}
  overrideValue = Struct.get(json, "overrideValue") == true

  ///@return {any}
  static get = function() {
    return this.value
  }

  ///@param {any} value
  ///@return {Transformer}
  static set = function(value) {
    this.value = value 
    return this
  }
  ///@return {Vector4Transformer}
  static update = function() {
    if (this.finished) {
      return this
    }

    this.x.value = this.value.x
    this.y.value = this.value.y
    this.z.value = this.value.z
    this.a.value = this.value.a
    this.value.x = this.x.update().get()
    this.value.y = this.y.update().get()
    this.value.z = this.z.update().get()
    this.value.a = this.a.update().get()

    if (this.value.x == this.x.target 
      && this.value.y == this.y.target
      && this.value.z == this.z.target
      && this.value.a == this.a.target) {

      this.finished = true
    }
    return this
  }

  ///@return {Struct}
  static serialize = function() {
    return {
      x: this.x.serialize(),
      y: this.y.serialize(),
      z: this.z.serialize(),
      a: this.a.serialize(),
    }
  }

  ///@return {Vector4Transformer}
  static reset = function() {
    this.finished = false 
    this.value.x = this.x.reset().get()
    this.value.y = this.y.reset().get()
    this.value.z = this.z.reset().get()
    this.value.a = this.a.reset().get()
    return this
  }
}


///@param {?Struct} [json]
function ResolutionTransformer(json = null) constructor {

  ///@type {Vector2}
  value = new Vector2(GuiWidth(), GuiHeight())

  ///@type {Boolean}
  finished = false

  ///@type {Boolean}
  overrideValue = Struct.getDefault(json, "overrideValue", true)

  ///@return {any}
  static get = function() {
    return this.value
  }

  ///@param {any} value
  ///@return {Transformer}
  static set = function(value) {
    this.value = value 
    return this
  }

  ///@return {Vector2}
  static update = function() {
    if (this.overrideValue) {
      return this
    }
    
    this.value.x = GuiWidth()
    this.value.y = GuiHeight() 
    return this
  }

  ///@return {Struct} 
  static serialize = function() {
    return {
      value: this.value.serialize(),
    }
  }

  ///@return {ResolutionTransformer}
  static reset = function() {
    this.finished = false 
    return this
  }
}
