///@package io.alkapivo.core.service.deltatime

///@type {String}
#macro BeanDeltaTimeService "DeltaTimeService"

///@param {?Struct} [config]
function DeltaTimeService(config = null): Service(config) constructor {

  ///@return {Number}
  static get = function() { 
    gml_pragma("forceinline")
    return DeltaTime.get()
  }

  ///@param {Number} value
  ///@return {Number}
  static apply = function(value) {
    gml_pragma("forceinline")
    return DeltaTime.apply(value)
  }

  ///@param {DeltaTimeMode} mode
  ///@return {DeltaTimeService}
  static setMode = function(mode) {
    DeltaTime.mode = Core.isEnum(mode, DeltaTimeMode) ? mode : DeltaTime.mode
    return this
  }

  ///@override
  ///@return {DeltaTimeService}
  static updateBegin = function() {
    DeltaTime.update()
    return this
  }
}
