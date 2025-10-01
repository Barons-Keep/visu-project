///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json 
function PathFeature(json): GridItemFeature(json) constructor {
  
  ///@param {Struct} json
  ///@param {GridItem} item
  ///@param {VisuController} controller
  ///@return {Struct}
  static parsePoint = function(json, item, controller) {
    var relative = Core.getIfType(Struct.get(json, "relative"), Boolean, true)
    var duration = Core.getIfType(GMArray.resolveRandom(Struct.get(json, "duration")), Number, 0.0)
    var ease = Core.getIfType(Struct.get(json, "ease"), String, "LINEAR")
    var target = relative ? item : controller.gridService.view
    var point = new Vector2Transformer({
      x: {
        value: item.x,
        target: target.x + Core.getIfType(GMArray
          .resolveRandom(Struct.get(json, "x")), Number, 0.0),
        duration: duration,
        ease: ease,
      },
      y: {
        value: item.y,
        target: target.y + Core.getIfType(GMArray
          .resolveRandom(Struct.get(json, "y")), Number, 0.0),
        duration: duration,
        ease: ease,
      },
    })

    return point
  }

  var data = Struct.get(json, "data")
  
  ///@override
  ///@type {String}
  type = "PathFeature"

  ///@type {Queue<Struct>}
  points = new Queue(Struct, Core.getIfType(Struct.get(data, "points"), GMArray, []))

  ///@type {?Struct}
  point = null

  ///@type {Boolean}
  finished = false

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    if (this.finished) {
      return
    }

    if (this.point == null || this.point.finished) {
      var json = this.points.pop()
      if (json == null) {
        this.finished = true
        return
      } else {
        this.point = this.parsePoint(json, item, controller)
      }
    }

    var previousX = this.point.x.value
    var previousY = this.point.y.value
    this.point.update()
    item.x = this.point.x.value
    item.y = this.point.y.value
    if (!this.point.finished) {
      item.angle = Math.fetchPointsAngle(previousX, previousY, item.x, item.y)
      //item.speed = max(item.speed, Math.fetchLength(previousX, previousY, this.point.x.value, this.point.y.value))
    }
  }
}