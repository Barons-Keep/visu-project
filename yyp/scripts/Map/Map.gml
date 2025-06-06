///@package io.alkapivo.core.collection

///@param {Type} _keyType
///@param {Type} _valueType
///@param {?Struct} [_container]
///@param {?Struct} [config]
function Map(_keyType = any, _valueType = any, _container = null) constructor {

  ///@private
  _acc = null

  ///@private
  ///@type {?Callable}
  _callback = null

  ///@private
  ///@param {any} key
  ///@param {any} value
  _forEachWrapper = function(key, value) {
    this._callback(value, key, this._acc)
  }

  ///@type {?Type}
  keyType = _keyType

  ///@type {?Type}
  valueType = _valueType

  ///@private
  ///@type {Struct}
  container = typeof(_container) == "struct" ? _container : {}

  ///@private
  ///@type {Array}
  _keys = new Array(_keyType)

  ///@test MapTest.test_map_get
  ///@param {any} key
  ///@return {any}
  static get = function(key) {
    gml_pragma("forceinline")
    return Struct.get(this.container, key)
  }

  ///@return {any}
  static getFirst = function() {
    gml_pragma("forceinline")
    var key = this.keys().getFirst()
    return key != null ? this.get(key) : null
  }

  ///@return {any}
  static getLast = function() {
    gml_pragma("forceinline")
    var key = this.keys().getLast()
    return key != null ? this.get(key) : null
  }

  ///@test MapTest.test_map_getdefault
  ///@param {any} key
  ///@param {any} defaultValue
  ///@return {any}
  static getDefault = function(key, defaultValue) {
    gml_pragma("forceinline")
    return this.contains(key) ? this.get(key) : defaultValue
  }

  ///@param {any} key
  ///@param {Type} type
  ///@param {any} [defaultValue]
  ///@return {any}
  static getIfType = function(key, type, defaultValue = null) {
    gml_pragma("forceinline")
    return Struct.getIfType(this.container, key, type, defaultValue)
  }

  ///@param map
  ///@param key
  ///@return {Boolean}
  static contains = function(key) {
    gml_pragma("forceinline")
    return Struct.contains(this.container, key)
  }

  ///@param {any} key
  ///@param {any} item
  ///@throws {InvalidClassException}
  ///@return {Map}
  static set = function(key, item) {
    gml_pragma("forceinline")
    Assert.isType(key, this.keyType)
    Assert.isType(item, this.valueType)
    Struct.set(this.container, key, item)
    return this
  }


  ///@param {any} item
  ///@param {any} key
  ///@throws {Exception}
  ///@return {Map}
  static add = function(item, key = null) {
    gml_pragma("forceinline")
    var _key = key
    if (_key == null) {
      _key = this.generateKey()
    }

    if (this.contains(_key)) {
      throw new Exception($"Key already exists: '{_key}'")
    }

    this.set(_key, item)
    return this
  }

  ///@override
  ///@return {Number}
  static size = function() {
    gml_pragma("forceinline")
    return Struct.size(this.container)
  }

  ///@param {any} key
  ///@return {Map}
  static remove = function(key) {
    gml_pragma("forceinline")
    Struct.remove(this.container, key)
    return this
  }

  ///@return {Array}
  static keys = function() {
    gml_pragma("forceinline")
    this._keys.setContainer(Struct.keys(this.container))
    return this._keys
  }

  ///@param {any} key
  ///@return {any} item
  static inject = function(key, item) {
    gml_pragma("forceinline")
    if (!this.contains(key)) {
      this.set(key, item)
    }
    return this.get(key)
  }

  ///@override
  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {Map}
  static _forEach = function(callback, acc = null) {
    gml_pragma("forceinline")
    var keys = this.keys()
    var size = keys.size()
    for (var index = 0; index < size; index++) {
      var key = keys.get(index)
      var item = this.get(key)
      var result = callback(item, key, acc)
      if (result == BREAK_LOOP) {
        break
      }
    }
    return this
  }

  ///@override
  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {Map}
  static forEach = function(callback, acc = null) {
    gml_pragma("forceinline")
    this._callback = callback
    this._acc = acc
    struct_foreach(this.getContainer(), this._forEachWrapper)
    this._callback = null
    this._acc = null
    return this
  }

  ///@override
  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {Map}
  static filter = function(callback, acc = null) {
    gml_pragma("forceinline")
    var filtered = new Map(this.keyType, this.valueType)
    var keys = this.keys()
    var size = keys.size()
    for (var index = 0; index < size; index++) {
      var key = keys.get(index)
      var item = this.get(key)
      if (callback(item, key, acc)) {
        filtered.set(key, item)
      }
    }
    return filtered
  }

  ///@override
  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@param {Type} [keyType]
  ///@param {Type} [valueType]
  ///@return {Map}
  static map = function(callback, acc = null, keyType = null, valueType = null) {
    gml_pragma("forceinline")
    var mapped = new Map(keyType == null ? this.keyType : keyType, 
      valueType == null ? this.valueType : valueType)
    var keys = this.keys()
    var size = keys.size()
    for (var index = 0; index < size; index++) {
      var key = keys.get(index)
      var item = this.get(key)
      var result = callback(item, key, acc)
      if (result == BREAK_LOOP) {
        break
      }
      mapped.set(key, result)
    }
    return mapped
  }

  ///@override
  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {any}
  static find = function(callback, acc = null) {
    gml_pragma("forceinline")
    var keys = this.keys()
    var size = keys.size()
    for (var index = 0; index < size; index++) {
      var key = keys.get(index)
      var item = this.get(key)
      if (callback(item, key, acc)) {
        return item
      }
    }
    return null
  }

  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {any}
  static findKey = function(callback, acc = null) {
    gml_pragma("forceinline")
    var keys = this.keys()
    var size = keys.size()
    for (var index = 0; index < size; index++) {
      var key = keys.get(index)
      var item = this.get(key)
      if (callback(item, key, acc)) {
        return key
      }
    }
    return null
  }

  ///@override
  ///@return {Map}
  static clear = function() {
    gml_pragma("forceinline")
    var keys = this.keys()
    var size = keys.size()
    for (var index = 0; index < size; index++) {
      var key = keys.get(index)
      Struct.remove(this.container, key)
    }
    return this
  }

  ///@param {Number} [seed]
  ///@return {String}
  ///@throws {Exception}
  static generateKey = function(seed = random(100000)) {
    gml_pragma("forceinline")
    var size = this.size()
    var key = md5_string_utf8(string(seed))
    if (this.contains(key)) {
      var ATTEMPTS = 100
      for (var index = 1; index < ATTEMPTS; index++) {
        key = md5_string_utf8(key + string(index * random(100000 + current_time)))
        if (!this.contains(key)) {
          break
        }

        if (index == ATTEMPTS - 1) {
          throw new Exception("Unable to generate key")
        }
      }
    }
    return key
  }

  ///@param {?Callable} [callback]
  ///@param {any} [acc]
  ///@return {Struct}
  static toStruct = function(callback = null, acc = null) {
    gml_pragma("forceinline")
    var struct = null
    if (callback) {
      struct = {}
      var keys = this.keys()
      var size = keys.size()
      for (var index = 0; index < size; index++) {
        var key = keys.get(index)
        var item = this.get(key)
        Struct.set(struct, key, callback(item, key, acc))
      }
    } else {
      struct = JSON.clone(this.container)
    }
    return struct
  }

  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@param {Type} [keyType]
  ///@return {Array}
  static toArray = function(callback, acc = null, keyType = null) {
    gml_pragma("forceinline")
    var keys = this.keys()
    var size = keys.size()
    var arr = new Array(keyType == null ? this.keyType : keyType, GMArray.createGMArray(size))
    for (var index = 0; index < size; index++) {
      var key = keys.get(index)
      var item = this.get(key)
      arr.set(index, callback(item, key, acc))
    }
    return arr
  }

  ///@return {Struct}
  static getContainer = function() {
    gml_pragma("forceinline")
    return this.container
  }

  ///@param {Struct} container
  ///@return {Map}
  static setContainer = function(container) {
    gml_pragma("forceinline")
    this.container = container
    return this
  }

  ///@param {...Map} map
  ///@return {Map}
  static merge = function(/*...map*/) {
    gml_pragma("forceinline")
    for (var index = 0; index < argument_count; index++) {
      var map = argument[index]
      map.forEach(function(item, key, items) {
        items.add(item, key)
      }, this)
    }
    return this
  }
}
