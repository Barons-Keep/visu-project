///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json
function AngleFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")

  ///@override
  ///@type {String}
  type = "AngleFeature"

  ///@type {Boolean}
  isRelative = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "isRelative")), Boolean, true)

  ///@type {?NumberTransformer}
  transform = Struct.contains(data, "transform")
    ? new NumberTransformer({
      value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "value")), Number, 0.0),
      factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "factor")), Number, 1.0),
      target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "target")), Number, 0.0),
      increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.transform, "increase")), Number, 0.0),
    })
    : null

  ///@type {?NumberTransformer}
  add = Struct.contains(data, "add")
    ? new NumberTransformer({
      value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "value")), Number, 0.0),
      factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "factor")), Number, 1.0),
      target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "target")), Number, 1.0),
      increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.add, "increase")), Number, 0.0),
    })
    : null

  ///@type {Boolean}
  isAngleSet = false

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    if (this.transform != null) {
      if (!this.isAngleSet) {
        this.transform.startValue = item.angle
        this.transform.target = item.angle + ((this.transform.factor >= 0 ? 1 : -1) * Math.fetchPointsAngleDiff(item.angle, (this.isRelative ? item.angle : 0.0) + this.transform.target))
        this.transform.startFactor = abs(this.transform.factor)
        this.transform.reset()
        this.isAngleSet = true
      }
      
      item.setAngle(this.transform.update().value)
    }

    if (this.add != null) {
      item.setAngle(item.angle + this.add.update().value)
    }
  }
}


///@param {Struct} json
///@return {GridItemFeature}
function _AngleFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray.resolveRandom)
  
  if (Struct.contains(data, "transform")) {
    data.transform = Struct.map(data.transform, GMArray.resolveRandom)
  }

  if (Struct.contains(data, "add")) {
    data.add = Struct.map(data.add, GMArray.resolveRandom)
  }

  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: AngleFeature,

    ///@type {Boolean}
    isAngleSet: false,

    ///@type {Boolean}
    isRelative: Struct.getIfType(data, "isRelative", Boolean, true),

    ///@type {?NumberTransformer}
    transform: Struct.contains(data, "transform")
      ? new NumberTransformer(data.transform)
      : null,

    ///@type {?NumberTransformer}
    add: Struct.contains(data, "add")
      ? new NumberTransformer({
        value: 0.0,
        factor: Struct.getDefault(data.add, "factor", 1.0),
        target: Struct.getDefault(data.add, "target", 1.0),
        increase: Struct.getDefault(data.add, "increase", 0.0),
      })
      : null,

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      if (this.transform != null) {
        if (!this.isAngleSet) {
          this.transform.startValue = item.angle
          this.transform.target = item.angle + ((this.transform.factor >= 0 ? 1 : -1) * Math.fetchPointsAngleDiff(item.angle, (this.isRelative ? item.angle : 0.0) + this.transform.target))
          this.transform.startFactor = abs(this.transform.factor)
          this.transform.reset()
          this.isAngleSet = true
        }
        
        item.setAngle(this.transform.update().value)
      }

      if (this.add != null) {
        item.setAngle(item.angle + this.add.update().value)
      }
    },
  }))
}
