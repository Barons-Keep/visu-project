///@package io.alkapivo.core.collection

#macro GMList "GMList"


///@param {Type} [_type]
///@param {GMList} [_container]
function DSList(_type = any, _container = null) constructor {

  ///@type {Type}
  type = _type
  
  ///@private
  ///@type {GMList}
  container = ds_list_create()
  //container = _container != null ? _container : ds_list_create()
  if (_container != null && Core.isType(_container, GMArray)) {
    var size = GMArray.size(_container)
    for (var index = 0; index < size; index++) {
      ds_list_add(this.container, _container[index])
    }
  }

  ///@private
  ///@type {?Stack<Number>}
  gc = null

  ///@private
  ///@type {any}
  _acc = null

  ///@private
  ///@type {?Callable}
  _callback = null

  ///@private
  ///@param {Number} index
  ///@param {any} value
  static _forEachWrapper = function(value, index) {
    gml_pragma("forceinline")
    this._callback(value, index, this._acc)
  }

  ///@override
  ///@return {Number}
  static size = function() {
    gml_pragma("forceinline")
    return ds_list_size(this.container)
  }

  ///@param {Number} index
  ///@return {DSList}
  static remove = function(index) {
    gml_pragma("forceinline")
    ds_list_delete(this.container, index)
    return this
  }

  ///@param {Number} index
  ///@return {any}
  static get = function(index) {
    gml_pragma("forceinline")
    return this.container[| index]
  }

  ///@param {Number} index
  ///@return {DSList}
  static set = function(index, value) {
    gml_pragma("forceinline")
    Assert.isType(value, this.type)
    ds_list_set(this.container, index, value)
    return this
  }
  
  ///@param {any} item
  ///@param {Number} [index]
  ///@return {DSList}
  static add = function(item, index = null) {
    gml_pragma("forceinline")
    if (this.type != null && !Core.isType(item, this.type)) {
      throw new InvalidClassException()
    }
    
    index = index == null
      ? ds_list_add(this.container, item)
      : ds_list_set(this.container, index, value)
    
    return this
  }

  ///@override
  ///@return {DSList}
  static clear = function() {
    gml_pragma("forceinline")
    if (Core.isType(this.gc, Stack)) {
      this.gc.clear()
    }
    
    ds_list_clear(this.container)
    return this
  }

  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {any}
  static find = function(callback, acc = null) {
    gml_pragma("forceinline")
    var size = this.size()
    for (var index = 0; index < size; index++) {
      var item = this.container[| index]
      if (callback(item, index, acc)) {
        return item
      }
    }
    return null
  }

  ///@param {any} value
  ///@param {any} [acc]
  ///@return {?Number}
  static findIndex = function(callback, acc = null) {
    gml_pragma("forceinline")
    var size = this.size()
    for (var index = 0; index < size; index++) {
      var item = this.container[| index]
      if (callback(item, index, acc)) {
        return index
      }
    }
    return null
  }

  ///@override
  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {DSList}
  static forEach = function(callback, acc = null) {
    gml_pragma("forceinline")
    var size = this.size()
    for (var index = 0; index < size; index++) {
      var item = this.container[| index]
      callback(item, index, acc)
    }
    return this
  }

  ///@override
  ///@param {Callable} callback
  ///@param {any} [acc]
  ///@return {DSList}
  static filter = function(callback, acc = null) {
    gml_pragma("forceinline")
    var filtered = new DSList(this.type)
    var size = this.size()
    for (var index = 0; index < size; index++) {
      var item = this.container[| index]
      if (callback(item, index, acc)) {
        filtered.add(item)
      }
    }
    return filtered
  }
  
  ///@override
  ///@param {?Callable} [callback]
  ///@param {any} [acc]
  ///@param {?Type} [type]
  ///@return {DSList}
  static map = function(callback = null, acc = null, type = any) {
    gml_pragma("forceinline")
    var mapped = new DSList(this.type)
    var _callback = callback == null ? Lambda.passthrough : callback
    var size = this.size()
    for (var index = 0; index < size; index++) {
      var item = this.container[| index]
      var result = _callback(item, index, acc)
      if (result == BREAK_LOOP) {
        break
      }
      mapped.add(result)
    }
    return mapped
  }

  ///@override
  ///@param {any} searchItem
  ///@param {Callable} [comparator]
  ///@return {Boolean}
  static contains = function(searchItem, comparator = function(a, b) { return a == b }) {
    gml_pragma("forceinline")
    var size = this.size()
    var found = false
    for (var index = 0; index < size; index++) {
      var item = this.container[| index]
      if (comparator(item, searchItem)) {
        found = true
        break
      }
    }
    return found
  }

  ///@param {String} [delimiter]
  ///@return {String}
  static join = function(delimiter = ", ") {
    gml_pragma("forceinline")
    var size = this.size()
    var buffer = ""
    if (size > 1) {
      for (var index = 0; index < size; index++) {
        var item = this.container[| index]
        buffer = index == size - 1
          ? buffer + item
          : buffer + item + delimiter
      }
    } else {
      buffer = size > 0 ? this.container[| 0] : ""
    }
    return buffer
  }

  ///@return {any}
  static getFirst = function() {
    gml_pragma("forceinline")
    return this.size() > 0 ? this.get(0) : null
  }

  ///@return {any}
  static getLast = function() {
    gml_pragma("forceinline")
    var size = this.size()
    return size > 0 ? this.get(size - 1) : null
  }

  ///@return {any}
  static getRandom = function() {
    gml_pragma("forceinline")
    var size = this.size()
    if (size == 0) {
      return null
    }

    return this.get(irandom(size - 1))
  }

  ///@param {Number} indexA
  ///@param {Number} indexB
  ///@return {DSList}
  static swapItems = function(indexA, indexB) {
    gml_pragma("forceinline")
    var size = this.size()
    if (indexA >= size || indexB >= size) {
      return this //todo throw OutOfBoundary?
    }

    var itemA = this.get(indexA)
    var itemB = this.get(indexB)
    this.set(indexB, itemA)
    this.set(indexA, itemB)
    return this
  }

  ///@param {Collection<Number>} keys
  ///@return {DSList}
  static removeMany = function(keys) {
    static setGCTargetEntry = function(index, gcIndex, list) {
      if (list.size() > index) {
        list.container[| index] = GC_TARGET_ENTRY
      }
    }

    var size = this.size()
    if (size == 0) {
      return this
    }

    keys.forEach(setGCTargetEntry, this)
    for (var index = size - 1; index >= 0; index--) {
      if (this.container[| index] == GC_TARGET_ENTRY) {
        this.remove(index)
      }
    }
    
    return this
  }

  ///@param {Callable} [comparator]
  ///@return {DSList}
  static sort = function(comparator) {
    static quickSort = function(list, low, high, comparator, quickSortRef) {
      static partition = function(list, low, high, comparator) {
        var pivot = list[| high]
        var acc = 0
        for (var index = 0; index < high; index++) {
          if (comparator(list[| index], pivot)) {
            var temp = list[| acc]
            list[| acc++] = list[| index]
            list[| index] = temp

          }
        }
        var temp = list[| acc]
        list[| acc] = list[| high]
        list[| high] = temp
        return acc
      }

      if (low < high) {
        var _partition = partition(list, low, high, comparator)
        quickSortRef(list, low, _partition - 1, comparator, quickSortRef)
        quickSortRef(list, _partition + 1, high, comparator, quickSortRef)
      }

      return list
    }

    if (this.size() <= 1) {
      return this
    }

    this.setContainer(quickSort(this.container, 0, this.size() - 1, comparator, quickSort))

    return this
  }

  ///@return {GMList}
  static getContainer = function() {
    gml_pragma("forceinline")
    return this.container
  }

  ///@param {GMList} container
  ///@return {DSList}
  static setContainer = function(container) {
    gml_pragma("forceinline")
    Assert.isTrue(typeof(container) == "ref" && ds_exists(container, ds_type_list), "container must be type of GMList")
    this.container = container
    return this
  }

  ///@param {Type} [keyType]
  ///@param {Type} [valueType]
  ///@param {?Calllable} [valueCallback]
  ///@param {any} [acc]
  ///@param {?Calllable} [keyCallback]
  ///@return {Map}
  static toMap = function(keyType = any, valueType = any, valueCallback = null, acc = null, keyCallback = null) {
    gml_pragma("forceinline")
    var map = new Map(keyType, valueType)
    var size = this.size()
    var isValueCallback = Core.isType(valueCallback, Callable)
    if (Core.isType(keyCallback, Callable)) {
      if (isValueCallback) {
        for (var index = 0; index < size; index++) {
          var value = this.container[| index]
          map.set(keyCallback(value, index, acc), valueCallback(value, index, acc))
        }
      } else {
        for (var index = 0; index < size; index++) {
          var value = this.container[| index]
          map.set(keyCallback(value, index, acc), value)
        }
      }
    } else {
      if (isValueCallback) {
        for (var index = 0; index < size; index++) {
          var value = this.container[| index]
          map.set($"_{index}", valueCallback(value, index, acc))
        }
      } else {
        for (var index = 0; index < size; index++) {
          map.set($"_{index}", this.container[| index])
        }
      }
    }
    return map
  }

  ///@param {Calllable} [keyCallback]
  ///@param {any} [acc]
  ///@param {Calllable} [valueCallback]
  ///@return {Struct}
  static toStruct = function(keyCallback = null, acc = null, valueCallback = null) {
    gml_pragma("forceinline")
    var struct = {}
    var size = this.size()
    var isValueCallback = Core.isType(valueCallback, Callable)
    if (Core.isType(keyCallback, Callable)) {
      if (isValueCallback) {
        for (var index = 0; index < size; index++) {
          var value = this.container[| index]
          Struct.set(struct, keyCallback(value, index, acc), valueCallback(value, index, acc))
        }
      } else {
        for (var index = 0; index < size; index++) {
          var value = this.container[| index]
          Struct.set(struct, keyCallback(value, index, acc), value)
        }
      }
    } else {
      if (isValueCallback) {
        for (var index = 0; index < size; index++) {
          var value = this.container[| index]
          Struct.set(struct, $"_{index}", valueCallback(value, index, acc))
        }
      } else {
        for (var index = 0; index < size; index++) {
          Struct.set(struct, $"_{index}", this.container[| index])
        }
      }
    }
    return struct
  }

  ///@param {Number} from
  ///@param {Number} to
  ///@return {DSList}
  static move = function(from, to) {
    gml_pragma("forceinline")
    var size = this.size()
    if (from < 0 || from >= size)
      || (to < 0 || to >= size) {
      return this
    }
    
    var value = this.get(from)
    ds_list_delete(this.container, from)
    ds_list_insert(this.container, to, value)
    return this
  }

  ///@return {DSList}
  static enableGC = function() {
    gml_pragma("forceinline")
    this.gc = !Core.isType(this.gc, Stack) ? new Stack(Number) : this.gc
    return this
  }

  ///@return {DSList}
  static disableGC = function() {
    gml_pragma("forceinline")
    this.gc = null
    return this
  }

  ///@type {Number} index
  ///@return {DSList}
  static addToGC = function(index) {
    static sortDesc = function(a, b) {
      return a >= b
    }

    if (!Core.isType(this.gc, Stack)) {
      this.enableGC()
    }

    var last = this.gc.peek()
    if (last == null) {
      this.gc.push(index)
    } else if (last > index) {
      this.gc.push(index)
      this.gc.container = GMArray.sort(this.gc.container, sortDesc)
    } else if (last != index) {
      this.gc.push(index)
    }
    
    return this
  }

  ///@return {DSList}
  static runGC = function() {
    static removeIndex = function(index, gcIndex, list) {
      list.remove(index)
    }

    if (this.gc != null && this.gc.size() > 0) {
      this.gc.forEach(removeIndex, this)
    }

    return this
  }

  static free = function() {
    if (typeof(this.container) == "ref" && ds_exists(this.container, ds_type_list)) {
      ds_list_destroy(this.container)
      this.container = null
    }
  }
}