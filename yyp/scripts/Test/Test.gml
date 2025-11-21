///@package io.alkapivo.core.test

///@param {Struct} json
function Test(json) constructor {

  ///@type {String}
  handler = Assert.isType(json.handler, String, "Test::handler must be type of String")

  ///@type {String}
  description = Struct.getIfType(json, "description", String, "")
  
  ///@type {any}
  data = Struct.get(json, "data")

  ///@return {Struct}
  serialize = function() {
    var json = {
      handler: this.handler,
      description: this.description
    }

    if (Optional.is(this.data)) {
      Struct.set(json, "data", this.data)
    }
    
    return json
  }
}


///@param {Struct} [config]
function TestKeypress(config = {}) constructor {

  ///@type {String}
  key = Assert.isType(Struct.get(config, "key"), String, "TestKeypress.key must be type of String")

  ///@type {Array<Number>}
  durations = new Array(Number, Struct.getIfType(config, "durations", GMArray, []))

  ///@type {Number}
  luck = clamp(Struct.getIfType(config, "luck", Number, 0.0), 0.0, 1.0)

  ///@type {Timer}
  timer = new Timer(this.durations.getRandom())

  ///@type {Boolean}
  enable = false

  ///@return {TestKeypress}
  update = method(this, Struct.getIfType(config, "update", Callable, function() {
    if (!this.timer.finished && this.timer.update().finished) {
      this.enable = this.luck >= random(1.0)
      this.timer.reset().setDuration(this.durations.getRandom())
    }

    return this
  }))

  ///@param {Keyboard}
  ///@return {TestKeypress}
  updateKeyboard = function(keyboard) {
    var key = keyboard.getKey(this.key)
    if (!Optional.is(key)) {
      return this
    }

    if (this.enable) {
      if (key.pressed && key.on) {
        key.pressed = false
      }

      if (key.released) {
        key.released = false
      }

      if (!key.on) {
        key.on = true
        key.pressed = true
      }
    } else {
      if (key.pressed) {
        key.pressed = false
      } 

      if (key.released) {
        key.released = false
      }

      if (key.on) {
        key.on = false
        key.released = true
      }
    }

    return this
  }
}
