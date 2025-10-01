///@package io.alkapivo.core.util.store

///@param {String} _name
///@param {Struct} json
function StoreItem(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {Type}
  type = json.type

  ///@type {any}
  value = null

  ///@type {any}
  data = Struct.get(json, "data")

  ///@type {Map<String, StoreItemSubscriber>}
  subscribers = new Map(String, StoreItemSubscriber)

  ///@type {Boolean}
  lazyNotify = false

  ///@return {any}
  get = method(this, Assert.isType(Struct.getIfType(json, "get", Callable, function() {
    return this.value
  }), Callable))

  ///@param {any} value
  ///@return {StoreItem}
  set = method(this, Assert.isType(Struct.getIfType(json, "set", Callable, function(value, lazyNotify = false) {
    var _value = Assert.isType(this.passthrough(value), this.type, $"Store item name: {this.name}")
    this.validate(_value)
    this.value = _value
    if (lazyNotify) {
      this.lazyNotify = true
    } else {
      this.subscribers.forEach(function(subscriber, iterator, value) {
        subscriber.callback(value, subscriber.data)
      }, _value)
    }
    return this
  }), Callable))

  ///@param {any} value
  ///@return {any} value
  ///@throws {Exception}
  passthrough = method(this, Assert.isType(Struct.getIfType(json, "passthrough", Callable, function(value) {
    return value
  }), Callable))

  ///@return {any}
  factoryDefault = method(this, Assert.isType(Struct.getIfType(json, "factoryDefault", Callable, function() {
    return null
  }), Callable))

  ///@return {any}
  serialize = method(this, Assert.isType(Struct.getIfType(json, "serialize", Callable, function() { 
    var item = this.get()
    return Struct.contains(item, "serialize") && Core.isType(item.serialize, Callable)
      ? item.serialize()
      : item
  }), Callable))

  ///@param {any} value
  ///@return {StoreItem}
  parse = method(this, Assert.isType(Struct.getIfType(json, "parse", Callable, function(value) { 
    return this.set(value)
  }), Callable))

  ///@param {any} value
  ///@throws {Exception}
  validate = method(this, Assert.isType(Struct.getIfType(json, "validate", Callable, function(value) { 
    return // dummy
  }), Callable))

  ///@description Apply default value
  this.set(Struct.contains(json, "value") ? json.value : this.factoryDefault())

  ///@private
  ///@param {StoreItemSubscriber} subscriber
  ///@param {Number} index
  ///@param {String} name
  ///@return {Boolean}
  static findSubscriberByName = function(subscriber, index, name) {
    gml_pragma("forceinline")
    return subscriber.name == name
  }

  ///@param {Struct} config
  ///@return {StoreItem}
  ///@throws {Exception}
  static addSubscriber = function(config) {
    gml_pragma("forceinline")
    var subscriber = new StoreItemSubscriber(config)
    if (this.containsSubscriber(subscriber.name)) {
      if (Struct.get(config, "overrideSubscriber")) {
        Logger.debug("StoreItem", $"Overrride subscriber '{subscriber.name}'")
        this.removeSubscriber(subscriber.name)
      } else {
        throw new Exception($"Subscriber '{subscriber.name}' for store item '{this.name}' already exists")
      }
    }
    this.subscribers.add(subscriber, subscriber.name)

    ///@description Notify all subscribers
    if (Struct.get(subscriber.data, "notify") == true) {
      this.set(this.get())
    }
    return this
  }

  ///@param {String} name
  ///@return {?StoreItemSubscriber}
  static getSubscriber = function(name) {
    gml_pragma("forceinline")
    //return this.subscribers.find(this.findSubscriberByName, name)
    return this.subscribers.get(name)
  }

  ///@param {String} name
  ///@return {?StoreItemSubscriber}
  static removeSubscriber = function(name) {
    gml_pragma("forceinline")
    //var index = this.subscribers.findIndex(this.findSubscriberByName, name)
    //if (Core.isType(index, Number)) {
    //  subscribers.remove(index)
    //  //Logger.debug("Store", $"Remove subscriber: \{ \"key\": \"{this.name}\", \"subscriber\": \"{name}\" \}")
    //}
    this.subscribers.remove(name)
    return this
  }

  ///@param {String} name
  ///@return {Boolean}
  static containsSubscriber = function(name) {
    gml_pragma("forceinline")
    //return Core.isType(this.subscribers.find(this.findSubscriberByName, name), StoreItemSubscriber)
    return this.subscribers.contains(name)
  }

  ///@param {String}
  ///@return {StoreItem}
  static resolveLazyNotify = function(lazyNotify = false) {
    gml_pragma("forceinline")
    if (!this.lazyNotify && !lazyNotify) {
      return this
    }

    this.lazyNotify = false
    this.subscribers.forEach(function(subscriber, iterator, value) {
      subscriber.callback(value, subscriber.data)
    }, this.value)
    return this
  }
}