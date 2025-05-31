///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json 
function LifespanFeature(json): GridItemFeature(json) constructor {

  ///@override
  ///@type {String}
  type = "LifespanFeature"

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    //Core.print("@deprecated: LifespanFeature")
  }
}


///@param {Struct} json
///@return {GridItemFeature}
function _LifespanFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)
  
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: LifespanFeature,

    ///@type {Timer}
    lifespanTimer: new Timer(data.duration),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      item.lifespan = this.lifespanTimer.update().time
      if (this.lifespanTimer.finished) {
        item.signal("kill")
      }
    },
  }))
}