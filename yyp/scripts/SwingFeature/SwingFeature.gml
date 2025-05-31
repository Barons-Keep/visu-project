///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json 
function SwingFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")
  
  ///@override
  ///@type {String}
  type = "SwingFeature"

  ///@type {Number}
  size = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "size")), Number, 1.0)

  ///@type {Number}
  amount = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "amount")), Number, 1.0)

  ///@type {Struct}
  swingTimer = new Timer(pi * 2.0, { 
    loop: Infinity, 
    amount: FRAME_MS * this.amount,
  })

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    item.angle = item.angle + (cos(this.swingTimer.update().time) * this.size)
  }
}


///@param {Struct} json
///@return {GridItemFeature}
function _SwingFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)
  
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: SwingFeature,

    ///@type {Struct}
    swingTimer: new Timer(pi * 2, { 
      loop: Infinity, 
      amount: FRAME_MS * (Core.isType(Struct.get(data, "amount"), Number) 
        ? data.amount : 1.0),
    }),

    ///@type {Number}
    size: Core.isType(Struct.get(data, "size"), Number) ? data.size : 1.0,

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      item.angle = item.angle + (cos(this.swingTimer.update().time) * this.size)
    },
  }))
}