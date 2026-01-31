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
      
      var coin = new Coin(template)
      this.coins.add(coin)
      this.statistics.factoryCoin(coin)
    },
    "clear-coins": function(event) {
      static freeCoin = function(coin, idx, coinService) {
        coinService.statistics.freeCoin(coin, coin.freeReason)
      }

      this.coins.forEach(freeCoin, this).clear()
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

  statistics = {
    spawnedByForceCount: 0,
    spawnedByForceValue: 0,
    collectedByForceCount: 0,
    collectedByForceValue: 0,
    expiredByForceCount: 0,
    expiredByForceValue: 0,
    spawnedByPointCount: 0,
    spawnedByPointValue: 0,
    collectedByPointCount: 0,
    collectedByPointValue: 0,
    expiredByPointCount: 0,
    expiredByPointValue: 0,
    spawnedByBombCount: 0,
    spawnedByBombValue: 0,
    collectedByBombCount: 0,
    collectedByBombValue: 0,
    expiredByBombCount: 0,
    expiredByBombValue: 0,
    spawnedByLifeCount: 0,
    spawnedByLifeValue: 0,
    collectedByLifeCount: 0,
    collectedByLifeValue: 0,
    expiredByLifeCount: 0,
    expiredByLifeValue: 0,
    report: function() {
      return {
        spawnedByForceCount: this.spawnedByForceCount,
        spawnedByForceValue: this.spawnedByForceValue,
        collectedByForceCount: this.collectedByForceCount,
        collectedByForceValue: this.collectedByForceValue,
        expiredByForceCount: this.expiredByForceCount,
        expiredByForceValue: this.expiredByForceValue,
        spawnedByPointCount: this.spawnedByPointCount,
        spawnedByPointValue: this.spawnedByPointValue,
        collectedByPointCount: this.collectedByPointCount,
        collectedByPointValue: this.collectedByPointValue,
        expiredByPointCount: this.expiredByPointCount,
        expiredByPointValue: this.expiredByPointValue,
        spawnedByBombCount: this.spawnedByBombCount,
        spawnedByBombValue: this.spawnedByBombValue,
        collectedByBombCount: this.collectedByBombCount,
        collectedByBombValue: this.collectedByBombValue,
        expiredByBombCount: this.expiredByBombCount,
        expiredByBombValue: this.expiredByBombValue,
        spawnedByLifeCount: this.spawnedByLifeCount,
        spawnedByLifeValue: this.spawnedByLifeValue,
        collectedByLifeCount: this.collectedByLifeCount,
        collectedByLifeValue: this.collectedByLifeValue,
        expiredByLifeCount: this.expiredByLifeCount,
        expiredByLifeValue: this.expiredByLifeValue,
      }
    },
    reset: function() {
      this.spawnedByForceCount = 0
      this.spawnedByForceValue = 0
      this.collectedByForceCount = 0
      this.collectedByForceValue = 0
      this.expiredByForceCount = 0
      this.expiredByForceValue = 0
      this.spawnedByPointCount = 0
      this.spawnedByPointValue = 0
      this.collectedByPointCount = 0
      this.collectedByPointValue = 0
      this.expiredByPointCount = 0
      this.expiredByPointValue = 0
      this.spawnedByBombCount = 0
      this.spawnedByBombValue = 0
      this.collectedByBombCount = 0
      this.collectedByBombValue = 0
      this.expiredByBombCount = 0
      this.expiredByBombValue = 0
      this.spawnedByLifeCount = 0
      this.spawnedByLifeValue = 0
      this.collectedByLifeCount = 0
      this.collectedByLifeValue = 0
      this.expiredByLifeCount = 0
      this.expiredByLifeValue = 0
      return this
    },
    factoryCoin: function(coin) {
      switch (coin.category) {
        case CoinCategory.FORCE:
          this.spawnedByForceCount += 1
          this.spawnedByForceValue += coin.amount
          break
        case CoinCategory.POINT:
          this.spawnedByPointCount += 1
          this.spawnedByPointValue += coin.amount
          break
        case CoinCategory.BOMB:
          this.spawnedByBombCount += 1
          this.spawnedByBombValue += coin.amount
          break
        case CoinCategory.LIFE:
          this.spawnedByLifeCount += 1
          this.spawnedByLifeValue += coin.amount
          break
      }
      return this
    },
    freeCoin: function(coin, reason) {
      if (reason == "collected") {
        switch (coin.category) {
          case CoinCategory.FORCE:
            this.collectedByForceCount += 1
            this.collectedByForceValue += coin.amount
            break
          case CoinCategory.POINT:
            this.collectedByPointCount += 1
            this.collectedByPointValue += coin.amount
            break
          case CoinCategory.BOMB:
            this.collectedByBombCount += 1
            this.collectedByBombValue += coin.amount
            break
          case CoinCategory.LIFE:
            this.collectedByLifeCount += 1
            this.collectedByLifeValue += coin.amount
            break
        }
      } else {
        switch (coin.category) {
          case CoinCategory.FORCE:
            this.expiredByForceCount += 1
            this.expiredByForceValue += coin.amount
            break
          case CoinCategory.POINT:
            this.expiredByPointCount += 1
            this.expiredByPointValue += coin.amount
            break
          case CoinCategory.BOMB:
            this.expiredByBombCount += 1
            this.expiredByBombValue += coin.amount
            break
          case CoinCategory.LIFE:
            this.expiredByLifeCount += 1
            this.expiredByLifeValue += coin.amount
            break
        }
      }
      return this
    },
    validate: function() {      
      Assert.areEqual(this.spawnedByForceCount - this.collectedByForceCount, this.expiredByForceCount, "Invalid ForceCount")
      Assert.areEqual(this.spawnedByForceValue - this.collectedByForceValue, this.expiredByForceValue, "Invalid ForceValue")
      Assert.areEqual(this.spawnedByPointCount - this.collectedByPointCount, this.expiredByPointCount, "Invalid PointCount")
      Assert.areEqual(this.spawnedByPointValue - this.collectedByPointValue, this.expiredByPointValue, "Invalid PointValue")
      Assert.areEqual(this.spawnedByBombCount - this.collectedByBombCount, this.expiredByBombCount, "Invalid BombCount")
      Assert.areEqual(this.spawnedByBombValue - this.collectedByBombValue, this.expiredByBombValue, "Invalid BombValue")
      Assert.areEqual(this.spawnedByLifeCount - this.collectedByLifeCount, this.expiredByLifeCount, "Invalid LifeCount")
      Assert.areEqual(this.spawnedByLifeValue - this.collectedByLifeValue, this.expiredByLifeValue, "Invalid LifeValue")
      Logger.debug("CoinService", "CoinStatistics are OK")
    },
  }

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
      coin.freeReason = "collected"
      controller.coinService.statistics.freeCoin(coin, coin.freeReason)
    } else {
      var length = Math.fetchLength(coin.x, coin.y, view.x + (view.width / 2.0), view.y + (view.height / 2.0))
      if (length > GRID_ITEM_FRUSTUM_RANGE) {
        coins.addToGC(index)
        coin.freeReason = "expired"
        controller.coinService.statistics.freeCoin(coin, coin.freeReason)
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
    this.statistics.factoryCoin(coin)
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
    this.coins.forEach(this.updateCoin, Beans.get(BeanVisuController)).runGC(true)
    return this
  }

  this.send(new Event("reset-templates"))
}