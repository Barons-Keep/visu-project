///@package io.alkapivo.core.util

///@param {String} _name
///@param {Number} [_size]
function DebugTimer(_name, _size = 60) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {Number}
  value = 0.0

  ///@type {Number}
  maxSize = Assert.isType(_size, Number)

  ///@private
  ///@type {Number}
  a = 0.0

  ///@private
  ///@type {Number}
  b = 0.0

  ///@private
  ///@type {Number}
  size = 0.0

  ///@return {DebugTimer}
  start = function() {
    this.a = get_timer()
    if (this.size > this.maxSize) {
      this.size = 0
      this.value = 0
    }

    return this
  }

  ///@return {DebugTimer}
  finish = function() {
    this.b = get_timer()
    this.size = this.size + 1
    this.value = this.value + ((this.b - this.a) / 1000)
    return this
  }

  ///@return {Number} time in ms (there are 1000 miliseconds per second)
  getValue = function() {
    return this.size > 0 ? this.value / this.size : 0.0
  }

  ///@return {String}
  getMessage = function() {
    return $"{this.name} avg: {string_format(this.getValue(), 1, 4)}ms"
  }
}


/** Example:
 * new DebugNumericKeyboardValue({
    name: "debugLine",
    value: -10,
    factor: 1,
    keyIncrement: ord("T"),
    keyDecrement: ord("Y"),
    pressed: true,
  })
 */
///@param {Struct} config
function DebugNumericKeyboardValue(config) constructor {

  ///@type {String}
  name = Assert.isType(config.name, String)

  ///@type {Number}
  value = Assert.isType(config.value, Number)

  ///@type {Number}
  factor = Core.isType(Struct.get(config, "factor"), Number) ? config.factor : 1

  ///@type {?Number}
  minValue = Core.isType(Struct.get(config, "minValue"), Number) ? config.minValue : null

  ///@type {?Number}
  maxValue = Core.isType(Struct.get(config, "maxValue"), Number) ? config.maxValue : null

  ///@type {Number}
  keyIncrement = Assert.isType(config.keyIncrement, Number)

  ///@type {Number}
  keyDecrement = Assert.isType(config.keyDecrement, Number)

  ///@type {Boolean}
  pressed = Core.isType(Struct.get(config, "pressed"), Boolean) ? config.pressed : false

  ///@return {DebugNumericKeyboardValue}
  update = function() {
    var keyFunction = this.pressed ? keyboard_check_pressed : keyboard_check
    if (keyFunction(this.keyIncrement)) {
      this.value = this.value + this.factor
      if (Optional.is(this.minValue) && this.value < this.minValue) {
        this.value = this.minValue
      }
      if (Optional.is(this.maxValue) && this.value > this.maxValue) {
        this.value = this.maxValue
      }

      Logger.debug(this.name, $"Increment: {this.value}")
    }

    if (keyFunction(this.keyDecrement)) {
      this.value = this.value - this.factor
      if (Optional.is(this.minValue) && this.value < this.minValue) {
        this.value = this.minValue
      }
      if (Optional.is(this.maxValue) && this.value > this.maxValue) {
        this.value = this.maxValue
      }

      Logger.debug(this.name, $"Decrement: {this.value}")
    }

    return this
  }
}


///@param {Struct} config
function DebugBlendModesKeyboard(config) constructor {
  
  ///@private
  ///@type {Struct}
  blendModes = {
    source: BlendModeExt.ZERO,
    target: BlendModeExt.ZERO,
    equation: BlendEquation.ADD,
    blendModesExt: BlendModeExt.keys(),
    blendEquation: BlendEquation.keys(),
    sourceKey: new DebugNumericKeyboardValue({
      name: "sourceKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 10,
      keyIncrement: ord("T"),
      keyDecrement: ord("G"),
      pressed: true,
    }),
    targetKey: new DebugNumericKeyboardValue({
      name: "targetKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 10,
      keyIncrement: ord("Y"),
      keyDecrement: ord("H"),
      pressed: true,
    }),
    equationKey: new DebugNumericKeyboardValue({
      name: "equationKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 4,
      keyIncrement: ord("U"),
      keyDecrement: ord("J"),
      pressed: true,
    }),
    update: function() {
      var sourceIndex = this.sourceKey.update().value
      var targetIndex = this.targetKey.update().value
      var equationIndex = this.equationKey.update().value

      var source = BlendModeExt.get(this.blendModesExt.get(sourceIndex))
      var target = BlendModeExt.get(this.blendModesExt.get(targetIndex))
      var equation = BlendEquation.get(this.blendEquation.get(equationIndex))

      if (source != this.source 
          || target != this.target 
          || equation != this.equation) {
        Core.print(
          $"# {irandom(99) + 99}|", 
          "Source:", this.blendModesExt.get(sourceIndex), 
          "Target:", this.blendModesExt.get(targetIndex), 
          "Equation:", this.blendEquation.get(equationIndex)
        )
      }

      this.source = source
      this.target = target
      this.equation = equation
      /*
      GPU.set.blendModeExt(this.blendModes.source, this.blendModes.target)
      GPU.set.blendEquation(this.blendModes.equation)

      GPU.reset.blendMode()
      GPU.reset.blendEquation()
      */
    }
  }

  ///@return {DebugBlendModesKeyboard}
  update = function() {
    this.blendModes.update()
    return this
  }
}