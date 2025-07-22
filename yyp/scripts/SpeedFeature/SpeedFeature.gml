///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json
function SpeedFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")

  ///@override
  ///@type {String}
  type = "SpeedFeature"

  ///@type {Boolean}
  isRelative = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "isRelative")), Boolean, true)

  ///@type {Boolean}
  isSpeedSet = false

  ///@type {?NumberTransformer}
  transform = Struct.contains(data, "transform")
    ? new NumberTransformer({
      value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "value")), Number, 0.0),
      factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "factor")), Number, 1.0),
      target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "target")), Number, 0.0),
      increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "increase")), Number, 0.0),
      duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "duration")), Number, 0.0),
      ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "ease")), String, EaseType.LEGACY), // todo migrate
    })
    : null

  ///@type {?NumberTransformer}
  add = Struct.contains(data, "add")
    ? new NumberTransformer({
      value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "value")), Number, 0.0),
      factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "factor")), Number, 1.0),
      target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "target")), Number, 0.0),
      increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "increase")), Number, 0.0),
      duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "duration")), Number, 0.0),
      ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "ease")), String, EaseType.LEGACY), // todo migrate
    })
    : null

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    if (this.transform != null) {
      if (!this.isSpeedSet) {
        this.transform.value = (this.isRelative
          ? this.transform.value + (item.speed * GRID_ITEM_SPEED_SCALE) 
          : this.transform.value)
        this.transform.startValue = this.transform.value
        this.transform.target = this.transform.target + (this.isRelative
          ? item.speed * GRID_ITEM_SPEED_SCALE
          : 0.0)
        this.transform.reset()
        this.isSpeedSet = true
      }
      item.setSpeed(this.transform.update().value / GRID_ITEM_SPEED_SCALE)
    }

    if (this.add != null) {
      item.setSpeed(item.speed + (this.add.update().value / GRID_ITEM_SPEED_SCALE))
    }
  }
}


///@param {Struct} json
///@return {GridItemFeature}
function _SpeedFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)
  
  if (Struct.contains(data, "transform")) {
    data.transform = Struct.map(data.transform, GMArray.resolveRandom)
  }

  if (Struct.contains(data, "add")) {
    data.add = Struct.map(data.add, GMArray.resolveRandom)
  }
  
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: SpeedFeature,

    ///@type {?Number}
    initTransformValue: Struct.get(Struct.get(data, "transform"), "value"),

    ///@type {?NumberTransformer}
    transform: Struct.contains(data, "transform")
      ? new NumberTransformer(data.transform)
      : null,

    ///@type {?NumberTransformer}
    add: Struct.contains(data, "add")
      ? new NumberTransformer(data.add)
      : null,

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      if (this.transform != null) {
        if (this.initTransformValue == null) {
          this.transform.value = item.speed * GRID_ITEM_SPEED_SCALE
          this.transform.startValue = this.transform.value
          this.initTransformValue = this.transform.value
        }
        item.setSpeed(this.transform.update().value / GRID_ITEM_SPEED_SCALE)
      }

      if (this.add != null) {
        item.setSpeed(item.speed + (this.add.update().value / GRID_ITEM_SPEED_SCALE))
      }
    },
  }))
}