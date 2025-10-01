///@package io.alkapivo.util

///@param {Struct} config
function JSONModelType(config) constructor {
  
  ///@type {String}
  template = config.template

  ///@param {String} model
  ///@return {Boolean}
  is = Callable.bind(this, Assert.isType(Struct.getDefault(config, "is", 
    function(model) {
      return model == String.template(this.template, this.getTypeFullName(model))
        && this.getType(model) != null
    }), Callable))

  ///@param {String} model
  ///@return {?Type}
  getType = Callable.bind(this, Assert.isType(Struct.getDefault(config, "getType", 
    function(model) {
      return Core.getConstructor(this.getTypeName(model))
    }), Callable))

  ///@param {String} model
  ///@return {String}
  getTypeName = Callable.bind(this, Assert.isType(Struct.getDefault(config, "getTypeName", 
    function(model) {
      return String.split(this.getTypeFullName(model), ".").getLast()
    }), Callable))

  ///@param {String} model
  ///@return {String}
  getTypeFullName = Callable.bind(this, Assert.isType(Struct.getDefault(config, "getTypeFullName", 
    function(model) {
      return model
    }), Callable))

  ///@param {any} data
  ///@return {any}
  getData = Callable.bind(this, Assert.isType(Struct.get(config, "getData"), Callable))

  ///@param {Callable} callback
  ///@param {any} [acc]
  next = Callable.bind(this, Assert.isType(Struct.get(config, "next"), Callable))
}


///@static
///@type {Struct}
global.__JSONModelTypes = {
  "Struct": {
    template: "{0}",
    getData: function(data) {
      return Core.isType(data, Struct) ? data : null
    },
    next: function(callback, acc = null) {
      if (this.parsed) {
        return
      }
      //callback(new this.prototype(this.data), 0, acc)
      callback(this.prototype, this.data, 0, acc)
      this.parsed = true
    },
  },
  "Collection": { 
    template: "Collection<{0}>",
    getTypeFullName: function(model) {
      return new StringBuilder(model)
        .replace("Collection", "")
        .replace("<", "")
        .replace(">", "")
        .get()
    },
    getData: function(data) {
      if (Core.isType(data, Struct)) {
        return new Map(any, any, data)
      } 
      
      if (Core.isType(data, GMArray)) {
        return new Array(any, data)
      }

      throw new Exception("Unsupported data type")
    },
    next: function(callback, acc = null) {
      static nextMap = function(context, callback, acc) {
        if (context.parsed) {
          return context
        }

        var keys = context.data.keys()
        var size = keys.size()
        if (size == 0) {
          context.parsed = true
          return context
        }

        if (context.pointer == null) {
          context.pointer = 0
        }

        var key = keys.get(context.pointer)
        var json = context.data.get(key)
        callback(context.prototype, json, key, acc)
        if (context.pointer == size - 1) {
          context.parsed = true
        } else {
          context.pointer++
        }

        return context
      }

      static nextArray = function(context, callback, acc) {
        if (context.parsed) {
          return context
        }

        var size = context.data.size()
        if (size == 0) {
          context.parsed = true
          return context
        }

        if (context.pointer == null) {
          context.pointer = 0
        }

        var index = context.pointer
        var json = context.data.get(index)
        callback(context.prototype, json, index, acc)
        if (context.pointer == size - 1) {
          context.parsed = true
        } else {
          context.pointer++
        }

        return context
      }

      if (Core.isType(this.data, Map)) {
        return nextMap(this, callback, acc)
      }
      
      if (Core.isType(this.data, Array)) {
        return nextArray(this, callback, acc)
      }
      
      throw new Exception("Unsupported data type")
    }
  },
}

///@param {Struct} json
///@param {?String} [assertModel]
function JSONModelParser(json, assertModel = null) constructor {

  ///@private
  ///@param {String} model
  ///@return {?JSONModelType}
  static findModelType = function(model) {
    static findType = function(type, name, model) {
      if (Core.isType(type, JSONModelType)) {
        return type.is(model)
      } else {
        Logger.debug("JSONModelParser", $"init type {name}")
        var modelType = new JSONModelType(type)
        Struct.set(JSONModelTypes, name, modelType)
        return modelType.is(model)
      }
    }

    var filtered = Struct.keys(Struct.filter(JSONModelTypes, findType, model))
    if (GMArray.size(filtered) == 0) {
      Logger.warn("JSONModelParser", $"model {model} type was not found")
      return null
    }

    return Struct.get(JSONModelTypes, GMArray.getFirst(filtered))
  }

  ///@type {String}
  model = Assert.isType(Struct.get(json, "model"), String,
    "JSONModelParser::model must be type of String")
  
  if (assertModel != null) {
    Assert.areEqual(this.model, assertModel, 
      $"JSONModelParser::model must be equal to {assertModel} (model: {this.model})")
  }

  ///@private
  ///@type {JSONModelType}
  modelType = Assert.isType(this.findModelType(this.model), JSONModelType,
    "JSONModelParser::modelType must be type of JSONModelType")

  ///@type {Type}
  prototype = Assert.isType(this.modelType.getType(this.model), NonNull,
    "JSONModelParser::prototype must be type of Type")

  ///@type {NonNull}
  data = Assert.isType(this.modelType.getData(Struct.get(json, "data")), NonNull,
    "JSONModelParser::data must be type of NonNull")

  ///@param {any} [context]
  next = Callable.bind(this, Assert.isType(Struct.get(this.modelType, "next"), Callable,
    "JSONModelParser::next must be type of Callable"))

  ///@type {Boolean}
  parsed = false

  ///@private
  ///@type {?String|Number}
  pointer = null

  ///@param {Callable} callback(item, idx, acc)
  ///@param {any} [acc]
  ///@return {JSONModelParser}
  static parse = function(callback, acc = null) {
    if (this.parsed) {
      return this
    }

    this.next(callback, acc)
    return this
  }
}
#macro JSONModelTypes global.__JSONModelTypes


function _JSON() constructor {

  ///@param {String} text
  ///@return {?Struct|?Array|?String|?Number|?Boolean}
  parse = function(text) {
    var result = null
    try {
      result = json_parse(text)
      if (Core.isType(result, GMArray)) {
        result = new Array(any, result)
      }
    } catch (exception) {
      Logger.error("JSON::parse", exception.message)
    }
    
    return result
  }

  ///@param {any} object
  ///@param {?Struct} [config]
  ///@return {?String}
  stringify = function(object, config = null) {
    var result = null
    try {
      result = json_stringify(object, Struct.getDefault(config, "pretty", false))
    } catch (exception) {
      Logger.error("JSON::stringify", exception.message)
    }
    return result
  }

  ///@param {Struct} object
  ///@param {?Struct} [config]
  ///@return {?Struct|?GMArray|?String|?Number|?Boolean}
  clone = function(object, config = null) {
    return this.parse(this.stringify(object, config))
  }

  ///@param {String} json
  ///@param {Struct} config
  ///@return {?Task}
  parserTask = function(json, config) {
    var task = null
    try {
      task = new Task("parse-json-model")
        .setPromise(new Promise())
        .setState(new Map(String, any, {
          parser: Assert.isType(new JSONModelParser(JSON.parse(json), Struct.get(config, "model")), JSONModelParser,
            "JSON::parserTask parse-json-model parser must be type of JSONModelParser"),
          callback: Assert.isType(Struct.get(config, "callback"), Callable,
            "JSON::parserTask parse-json-model callback must be type of Callable"),
          steps: Struct.getIfType(config, "steps", Number, 1000),
          acc: Struct.get(config, "acc"),
        }))
        .whenUpdate(function() {
          var parser = this.state.get("parser")
          var callback = this.state.get("callback")
          var acc = this.state.get("acc")
          var steps = this.state.get("steps")
          for (var step = 0; step < steps; step++) {
            if (parser.parse(callback, acc).parsed) {
              break
            }
          }

          if (parser.parsed) {
            this.fullfill()
          }
        })
    } catch (exception) {
      Logger.error("JSON::parserTask", exception.message)
    }

    return task
  }
}
global.__JSON = new _JSON()
#macro JSON global.__JSON


