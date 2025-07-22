///@package io.alkapivo.core.util.store

///@param {Struct} json
function Store(json) constructor {

  ///@type {Map<String, any>}
  container = Struct.toMap(json, String, StoreItem, function(item, key) {
    return new StoreItem(key, item)
  })

  ///@param {String} name
  ///@return {?StoreItem}
  static get = function(name) {
    gml_pragma("forceinline")
    return this.container.get(name)
  }

  ///@type {String} name
  ///@param {any} [defaultValue]
  ///@return {?any}
  static getValue = function(name, defaultValue = null) {
    gml_pragma("forceinline")
    var item = this.get(name)
    return item != null ? item.get() : defaultValue
  }

  ///@param {StoreItem} item
  ///@return {Store}
  static add = function(item) {
    gml_pragma("forceinline")
    this.container.add(item, item.name)
    return this
  }

  ///@param {String} name
  ///@return {Boolean}
  static contains = function(name) {
    gml_pragma("forceinline")
    return this.container.contains(name)
  }

  ///@param {String} name
  ///@return {Store}
  static remove = function(name) {
    gml_pragma("forceinline")
    this.container.remove(key)
    return this
  }

  ///@param {Struct} json
  ///@return {Store}
  ///@throws {Exception}
  static parse = function(json) {
    gml_pragma("forceinline")
    Struct.forEach(json, function(value, key, store) {
      var item = store.get(key)
      if (!Core.isType(item, StoreItem)) {
        throw new Exception($"Unable to parse \{ '{key}': '{value}' \}")
      }
      item.set(value)
    }, this)
    return this
  }
}