///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json
function FollowPlayerFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")

  ///@override
  ///@type {String}
  type = "FollowPlayerFeature"

  ///@type {NumberTransformer}
  value = new NumberTransformer({
    value: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "value"), "value")), Number, 0.0),
    factor: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "value"), "target")), Number, 1.0),
    target: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "value"), "factor")), Number, 1.0),
    increase: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "value"), "increase")), Number, 0.0),
  })

  ///@type {NumberTransformer}
  transformer = new NumberTransformer({
    value: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "transformer"), "value")), Number, 0.0),
    factor: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "transformer"), "target")), Number, 1.0),
    target: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "transformer"), "factor")), Number, 1.0),
    increase: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "transformer"), "increase")), Number, 0.0),
  })

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    var player = controller.playerService.player
    if (player == null) {
      return
    }

    ///@todo This will not work
    this.transformer.startValue = 0.0
    this.transformer.target = Math.fetchPointsAngleDiff(item.angle, Math.fetchPointsAngle(item.x, item.y, player.x, player.y))
    this.transformer.startFactor = abs(this.value.factor) * sign(this.transformer.target)
    this.transformer.reset()
    item.setAngle(item.angle - this.transformer.update().value)
  }
}


///@param {Struct} json
///@return {GridItemFeature}
function _FollowPlayerFeature(json = {}) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)
  
  if (Struct.contains(data, "value")) {
    data.value = Struct.map(data.value, GMArray.resolveRandom)
  }

  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: FollowPlayerFeature,

    ///@type {NumberTransformer}
    value: new NumberTransformer(data.value),


    ///@type {NumberTransformer}
    transformer: new NumberTransformer(),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      var player = controller.playerService.player
      if (!Optional.is(player)) {
        return
      }

      ///@todo This will not work
      this.transformer.startValue = 0.0
      this.transformer.target = Math.fetchPointsAngleDiff(item.angle, Math.fetchPointsAngle(item.x, item.y, player.x, player.y))
      this.transformer.startFactor = abs(this.value.factor) * sign(this.transformer.target)
      this.transformer.reset()
      item.setAngle(item.angle - this.transformer.update().value)
    },
  }))
}