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
    }
  }
}


///@param {Struct} json
///@return {GridItemFeature}
function _ParticleFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)
  
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: ParticleFeature,

    ///@type {String}
    particle: Assert.isType(Struct
      .getDefault(data, "particle", "particle_default"), String),

    ///@type {Number}
    duration: Assert.isType(Struct
      .getDefault(data, "duration", FRAME_MS), Number),

    ///@type {Number}
    amount: Assert.isType(Struct
      .getDefault(data, "amount", 100), Number),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      if (Optional.is(this.particle)) {
        var view = controller.gridService.view
        var _x = (item.x - view.x) * GRID_SERVICE_PIXEL_WIDTH
        var _y = (item.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT

        //if ((_x < 0 || _x > GRID_SERVICE_PIXEL_WIDTH) 
        //  || (_y < 0 || _y > GRID_SERVICE_PIXEL_HEIGHT)) {
        //  return
        //}

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
      }
    },
  }))
}