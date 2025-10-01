///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json 
function ParticleFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")
  
  ///@override
  ///@type {String}
  type = "ParticleFeature"

  ///@type {String}
  particle = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "particle")), String, "particle-default")

  ///@type {Number}
  duration = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "duration")), Number, FRAME_MS)

  ///@type {Number}
  amount = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "amount")), Number, 10.0)

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    if (Optional.is(this.particle)) {
      var view = controller.gridService.view
      var _x = (item.x - view.x) * GRID_SERVICE_PIXEL_WIDTH
      var _y = (item.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT

      //if ((_x < 0 || _x > GRID_SERVICE_PIXEL_WIDTH) 
      //  || (_y < 0 || _y > GRID_SERVICE_PIXEL_HEIGHT)) {
      //  return
      //}
      controller.particleService.spawnParticleEmitter(
        "main",
        this.particle,
        _x,
        _y,
        _x,
        _y,
        this.duration,
        this.amount
      )

      /*
      controller.particleService.send(controller.particleService
        .factoryEventSpawnParticleEmitter(
          {
            particleName: this.particle,
            beginX: _x,
            beginY: _y,
            endX: _x,
            endY: _y,
            duration: this.duration,
            amount: this.amount,
          }, 
        ))
      */
    }
  }
}
