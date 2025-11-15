///@package io.alkapivo.core.service.deltatime

///@static
///@type {Number}
global.__DELTA_TIME = 1.0;
#macro DELTA_TIME global.__DELTA_TIME

///@static
function _DeltaTime() constructor {
	
	///@type {Number}
  deltaTime = 1.0
	
  ///@type {Number}
  expectedDeltaTime = game_get_speed(gamespeed_fps) / 1000000

  ///@type {Number}
  maxLagCompensation = 4

  ///@return {DeltaTime}
  static update = function() {
    gml_pragma("forceinline")
    this.deltaTime = min((this.expectedDeltaTime * delta_time), this.maxLagCompensation)
    DELTA_TIME = this.deltaTime

    if (Core.getProperty("core.delta-time.performance.logger", false)) {
      Logger.debug(BeanDeltaTimeService, $"DeltaTime: {String.format(DELTA_TIME, 2, 6)}, FPS-Real: {fps_real}, FPS: {fps}")
    }
    return this
  }

  ///@private
	///@type {Number}
  fpsMin = 3

  ///@private
  ///@type {Number}
  deltaTimeMax = GAME_FPS / this.fpsMin

  ///@private
	///@type {Number}
	deltaTimePrecision = 1000000.0
	
	///@private
  ///@type {Number}
	deltaTimePrevious = 1.0
	
  ///@private
	///@type {Boolean}
	deltaTimeRestored = false
  
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
  static _update = function() {
    gml_pragma("forceinline")
    this.deltaTimePrevious = this.deltaTime
    this.deltaTime = delta_time / this.deltaTimePrecision
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
    this.deltaTime = clamp(this.deltaTime * GAME_FPS, 1.0, this.deltaTimeMax)
    DELTA_TIME = this.deltaTime

    if (Core.getProperty("core.delta-time.performance.logger", false)) {
      Logger.debug(BeanDeltaTimeService, $"DeltaTime: {String.format(DELTA_TIME, 2, 6)}, FPS-Real: {fps_real}, FPS: {fps}")
    }

    return this
  }
}
global.__DeltaTime = new _DeltaTime()
#macro DeltaTime global.__DeltaTime
