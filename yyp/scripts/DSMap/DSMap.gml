///@package io.alkapivo.core.collection

#macro GMMap "GMMap"


///@param {Type} _keyType
///@param {Type} _valueType
///@param {?Struct} [_container]
function DSMap(_keyType = any, _valueType = any, _container = null) constructor {

  ///@type {?Type}
  keyType = _keyType

  ///@type {?Type}
  valueType = _valueType

  ///@private
  ///@type {Array}
  _keys = new Array(_keyType)

  ///@private
  ///@type {GMMap}
  container = ds_map_create()
  if (_container != null && Core.isType(_container, Struct)) {
    Struct.forEach(_container, function(value, key, container) {
      container[? key] = value
    }, this.container)
  }

  ///@param {any} key
  ///@return {any}
  static get = function(key) {
    gml_pragma("forceinline")
    return this.container[? key]
  }

  ///@return {any}
  static getFirst = function() {
    gml_pragma("forceinline")
    var key = ds_map_find_first(this.container)
    return key != null ? this.container[? key] : null
  }

  ///@return {any}
  static getLast = function() {
    gml_pragma("forceinline")
    var key = ds_map_find_last(this.container)
    return key != null ? this.container[? key] : null
  }

  ///@test MapTest.test_map_getdefault
  ///@param {any} key
  ///@param {any} defaultValue
  ///@return {any}
  static getDefault = function(key, defaultValue) {
    gml_pragma("forceinline")
    return this.contains(key) ? this.container[? key] : defaultValue
  }

  ///@param {any} key
  ///@param {Type} type
  ///@param {any} [defaultValue]
  ///@return {any}
  static getIfType = function(key, type, defaultValue = null) {
    gml_pragma("forceinline")
    var value = this.container[? key]
    return Core.isType(value, type) ? value : defaultValue
  }

  ///@param map
  ///@param key
  ///@return {Boolean}
  static contains = function(key) {
    gml_pragma("forceinline")
    return ds_map_exists(this.container, key)
  }

  ///@param {any} key
  ///@param {any} item
  ///@throws {InvalidClassException}
  ///@return {DSMap}
  static set = function(key, item) {
    gml_pragma("forceinline")
    Assert.isType(key, this.keyType)
    Assert.isType(item, this.valueType)
    this.container[? key] = item
    return this
  }


  ///@param {any} item
  ///@param {any} key
  ///@throws {Exception}
  ///@return {DSMap}
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
    return ds_map_size(this.container)
  }

  ///@param {any} key
  ///@return {DSMap}
  static remove = function(key) {
    gml_pragma("forceinline")
    ds_map_delete(this.container, key)
    return this
  }

  ///@return {Array}
  static keys = function() {
    gml_pragma("forceinline")
    this._keys.setContainer(ds_map_keys_to_array(this.container))
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
  ///@return {DSMap}
  static forEach = function(callback, acc = null) {
    gml_pragma("forceinline")
    for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
      var item = this.container[? key]
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
  ///@return {DSMap}
  static filter = function(callback, acc = null) {
    gml_pragma("forceinline")
    var filtered = new DSMap(this.keyType, this.valueType)
    var keys = this.keys()
    var size = keys.size()
    for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
      var item = this.container[? key]
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
  ///@return {DSMap}
  static map = function(callback, acc = null, keyType = null, valueType = null) {
    gml_pragma("forceinline")
    var mapped = new DSMap(keyType == null ? this.keyType : keyType, 
      valueType == null ? this.valueType : valueType)
    var keys = this.keys()
    var size = keys.size()
    for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
      var item = this.container[? key]
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
    for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
      var item = this.container[? key]
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
    for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
      var item = this.container[? key]
      if (callback(item, key, acc)) {
        return key
      }
    }
    return null
  }

  ///@override
  ///@return {DSMap}
  static clear = function() {
    gml_pragma("forceinline")
    ds_map_clear(this.container)
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
    var struct = {}
    if (callback) {
      for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
        var item = this.container[? key]
        Struct.set(struct, key, callback(item, key, acc))
      }
    } else {
      for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
        var item = this.container[? key]
        Struct.set(struct, key, item)
      }
    }
    return struct
  }

  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@param {Type} [keyType]
  ///@return {Array}
  static toArray = function(callback, acc = null, keyType = null) {
    gml_pragma("forceinline")
    var size = this.size()
    var arr = new Array(keyType == null ? this.keyType : keyType, GMArray.createGMArray(size))
    var index = 0
    for (var key = ds_map_find_first(this.container); key != null; key = ds_map_find_next(this.container, key)) {
      var item = this.container[? key]
      arr.set(index, callback(item, key, acc))
      index++
    }
    return arr
  }

  ///@return {Struct}
  static getContainer = function() {
    gml_pragma("forceinline")
    return this.container
  }

  ///@param {GMMap} container
  ///@return {DSMap}
  static setContainer = function(container) {
    gml_pragma("forceinline")
    Assert.isTrue(typeof(container) == "ref" && ds_exists(container, ds_type_map), "container must be type of GMMap")
    this.container = container
    return this
  }

  ///@param {...Map} map
  ///@return {DSMap}
  static merge = function(/*...map*/) {
    gml_pragma("forceinline")
    for (var index = 0; index < argument_count; index++) {
      var map = argument[index]
      map.forEach(function(item, key, items) {
        items.add(item, key)
        //items.container[? key] = item
      }, this)
    }
    return this
  }

  static free = function() {
    if (typeof(this.container) == "ref" && ds_exists(this.container, ds_type_map)) {
      ds_map_destroy(this.container)
      this.container = null
    }
  }
}
