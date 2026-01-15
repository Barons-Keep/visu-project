///@package io.alkapivo.core.lang.type

#macro Number "Number"
#macro Infinity infinity

///@type {Number}
global.__MIN_INT_64 = int64(-922337203685477588)
#macro MIN_INT_64 global.__MIN_INT_64

///@type {Number}
global.__MAX_INT_64 = int64(922337203685477587)
#macro MAX_INT_64 global.__MAX_INT_64

///@static
function _NumberUtil() constructor {

  ///@param {String} text
  ///@return {Number}
  ///@throws {Exception}
  fromString = function(text) {
    return real(text)
  }

  ///@param {any} text
  ///@param {Number} [defaultValue]
  ///@return {Number}
  parse = function(text, defaultValue = 0.0) {
    try {
      return real(text)
    } catch (exception) {
      return defaultValue
    }
  }
}
global.__NumberUtil = new _NumberUtil()
#macro NumberUtil global.__NumberUtil
