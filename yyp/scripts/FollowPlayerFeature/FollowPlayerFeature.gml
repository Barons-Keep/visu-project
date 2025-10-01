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
    target: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "value"), "target")), Number, 0.0),
    duration: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "value"), "duration")), Number, 0.0),
    ease: Core.getIfType(GMArray.resolveRandom(Struct.get(Struct.get(data, "value"), "ease")), String, EaseType.LINEAR),
  })

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    var player = controller.playerService.player
    if (player == null) {
      return
    }

    var angle = Math.fetchPointsAngleDiff(item.angle, Math.fetchPointsAngle(item.x, item.y, player.x, player.y))
    item.setAngle(item.angle - (angle * this.value.update().value))
  }
}
