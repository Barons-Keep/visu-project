///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json 
function CoinFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")
  
  ///@override
  ///@type {String}
  type = "CoinFeature"

  //@type {String}
  coin = Assert.isType(GMArray.resolveRandom(Struct.get(data, "coin")), String, "coin must be type of String")

  ///@type {Number}
  offsetX = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "offsetX")), Number, 0.0)

  ///@type {Number}
  offsetY = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "offsetY")), Number, 0.0)

  ///@type {Number}
  amount = clamp(toInt(Core.getIfType(GMArray.resolveRandom(Struct.get(data, "amount")), Number, 1)), 1, 99)

  ///@type {Number}
  luck = clamp(Core.getIfType(GMArray.resolveRandom(Struct.get(data, "luck")), Number, 1.0), 0.0, 1.0)

  ///@type {Boolean}
  spawned = false

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    if (this.spawned) {
      return
    }

    this.spawned = true
    for (var index = 0; index < this.amount; index++) {
      if (random(1.0) > this.luck) {
        continue
      }

      var verticalOffset = choose(1.0, -1.0) * random((item.sprite.getWidth() * item.sprite.getScaleX()) / 2.0)
      var horizontalOffset = -1.0 * random((item.sprite.getHeight() * item.sprite.getScaleY()) / 2.0)
      controller.coinService.spawnCoin(
        this.coin,
        item.x + ((verticalOffset + this.offsetX) / GRID_SERVICE_PIXEL_WIDTH),
        item.y + ((horizontalOffset + this.offsetY) / GRID_SERVICE_PIXEL_HEIGHT)
      )

      //controller.coinService.send(new Event("spawn-coin", {
      //  template: this.coin,
      //  x: item.x + ((verticalOffset + this.offsetX) / GRID_SERVICE_PIXEL_WIDTH),
      //  y: item.y + ((horizontalOffset + this.offsetY) / GRID_SERVICE_PIXEL_HEIGHT),
      //}))
    }
  }
}
