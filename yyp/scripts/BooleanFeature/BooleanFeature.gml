///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json 
function BooleanFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")

  ///@override
  ///@type {String}
  type = "BooleanFeature"

  ///@type {Number}
  value = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "value")), Boolean, false)

  ///@type {String}
  field = Assert.isType(GMArray.resolveRandom(Struct.get(data, "field")), String, "field must be type of String")

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    Struct.set(item, this.field, this.value)
  }
}

///@param {Struct} json 
///@return {GridItemFeature}
function _BooleanFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)
  
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: BooleanFeature,

    ///@type {Number}
    value: Assert.isType(Struct.getDefault(data, "value", false), Boolean),

    ///@type {String}
    field: Assert.isType(data.field, String),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      Struct.set(item, this.field, this.value)
    },
  }))
}
