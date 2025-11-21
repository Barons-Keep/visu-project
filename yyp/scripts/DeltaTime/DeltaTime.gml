///@package io.alkapivo.core.service.deltatime

///@static
///@type {Number}
global.__DELTA_TIME = 1.0;
#macro DELTA_TIME global.__DELTA_TIME

///@static
function _DeltaTime() constructor {

  ///@type {Number}
  deltaTime = 1.0

  ///@private
  ///@type {Number}
  fpsMin = 15

  ///@private
  ///@type {Number}
  deltaTimePrevious = 1.0
  
  ///@private
  ///@type {Boolean}
  deltaTimeRestored = false
  
  ///@private
  ///@return {DeltaTime}
  static unsteadyDelta = function() {
    gml_pragma("forceinline")
    this.deltaTime = min(((GAME_FPS / 1000000.0) * delta_time), GAME_FPS / this.fpsMin)
    return this
  }

  ///@private
  ///@return {DeltaTime}
  static steadyDelta = function() {
    gml_pragma("forceinline")
    this.deltaTimePrevious = this.deltaTime
    this.deltaTime = delta_time / 1000000.0
    if (this.deltaTime > 1.0 / this.fpsMin) {
      if (this.deltaTimeRestored) {
        this.deltaTime = 1.0 / this.fpsMin
      } else {
        this.deltaTime = this.deltaTimePrevious
        this.deltaTimeRestored = true
      }
    } else {
      this.deltaTimeRestored = false
    }
    this.deltaTime = min(this.deltaTime * GAME_FPS, GAME_FPS / this.fpsMin)

    return this
  }

  ///@param {Number} [value]
  ///@return {Number}
  static apply = function(value = FRAME_MS) {
    gml_pragma("forceinline")
    return this.deltaTime * value
  }

  ///@return {Number}
  static get = function() {
    gml_pragma("forceinline")
    return this.deltaTime
  }

  ///@return {DeltaTime}
  static update = function() {
    if (Core.getProperty("core.delta-time.steady", true)) {
      this.steadyDelta()
    } else {
      this.unsteadyDelta()
    }

    if (Core.getProperty("core.delta-time.clamp-to-fps", false)) {
      this.deltaTime = min(fps, fps_real) < GAME_FPS ? this.deltaTime : 1.0
    }

    DELTA_TIME = this.deltaTime

    if (Core.getProperty("core.delta-time.performance.logger", false)) {
      Logger.debug(BeanDeltaTimeService, $"DeltaTime: {String.format(DELTA_TIME, 2, 6)}, FPS-Real: {fps_real}, FPS: {fps}")
    }

    return this
  }
}
global.__DeltaTime = new _DeltaTime()
#macro DeltaTime global.__DeltaTime
