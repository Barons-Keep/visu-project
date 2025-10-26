///@package io.alkapivo.visu.service.coin

function CoinService(): Service() constructor {

  ///@type {Array<Coin>}
  coins = new Array(Coin).enableGC()

  ///@type {Map<String, CoinTemplate>}
  templates = new Map(String, CoinTemplate)

  ///@param {String} name
  ///@return {?CoinTemplate}
  getTemplate = function(name) {
    var template = this.templates.get(name)
    return template == null
      ? Visu.assets().coinTemplates.get(name)
      : template
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "spawn-coin": function(event) {
      if (event.data.template == "coin-empty") {
        return
      }
      
      var template = new CoinTemplate(event.data.template, this
        .getTemplate(event.data.template)
        .serialize())
      Struct.set(template, "x", Assert.isType(event.data.x, Number))
      Struct.set(template, "y", Assert.isType(event.data.y, Number))
      Struct.set(template, "angle", Struct.get(event.data, "angle"))
      if (Optional.is(Struct.get(event.data, "speed"))) {
        Struct.append(template.speed, event.data.speed)
      }
      
      this.coins.add(new Coin(template))
    },
    "clear-coins": function(event) {
      this.coins.clear()
    },
    "reset-templates": function(event) {
      this.templates.clear()
      this.dispatcher.container.clear()
    },
  }), {
    loggerPrefix: "CoinService",
    enableLogger: true,
    catchException: false,
  })

  ///@private
  ///@param {Coin} coin
  ///@param {Number} index
  ///@param {VisuController} controller
  updateCoin = function(coin, index, controller) {
    var player = controller.playerService.player
    var coins = controller.coinService.coins
    var view = controller.gridService.view
    coin.move(player)
    if (player != null && coin.collide(player)) {
      player.stats.dispatchCoin(coin)
      coins.addToGC(index)
    } else {
      var length = Math.fetchLength(coin.x, coin.y, view.x + (view.width / 2.0), view.y + (view.height / 2.0))
      if (length > GRID_ITEM_FRUSTUM_RANGE) {
        coins.addToGC(index)
      }
    }
  }

  ///@param {String} name
  ///@param {Number} x
  ///@param {Number} y
  ///@param {?Number} [angle]
  ///@param {?Number} [speed]
  spawnCoin = function(name, x, y, angle = null, speed = null) {
    if (name == "coin-empty") {
      return
    }

    var template = this.getTemplate(name)
    if (template == null) {
      Logger.warn("CoinService", $"Found null coin-template for name {name}")
      return
    }
    
    var coin = new Coin(template.serializeSpawn(x, y, angle, speed))
    this.coins.add(coin)
  }

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }
  
  ///@override
  ///@return {CoinService}
  update = function() { 
    this.dispatcher.update()
    this.coins.forEach(this.updateCoin, Beans.get(BeanVisuController)).runGC()
    return this
  }

  this.send(new Event("reset-templates"))
}