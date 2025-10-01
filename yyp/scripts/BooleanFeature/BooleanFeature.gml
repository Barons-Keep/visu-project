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
