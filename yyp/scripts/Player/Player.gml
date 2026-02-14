///@package io.alkapivo.visu.service.player

///@param {Struct} json
function PlayerTemplate(json) constructor {

  ///@type {String}
  name = Assert.isType(json.name, String)

  ///@type {Struct}
  sprite = Assert.isType(json.sprite, Struct)

  ///@type {?Struct}
  mask = Core.isType(Struct.get(json, "mask"), Struct) ? json.mask : null

  ///@type {Keyboard}
  keyboard = Assert.isType(json.keyboard, Keyboard)

  ///@type {Keyboard}
  mouse = Assert.isType(json.mouse, Mouse)

  ///@type {?Struct}
  stats = Core.isType(Struct.get(json, "stats"), Struct) ? json.stats : null

  ///@type {Struct}
  handler = Struct.getIfType(json, "handler", Struct, {})

  ///@return {Struct}
  serialize = function() {
    var json = {
      sprite: this.sprite,
      handler: this.handler,
      keyboard: this.keyboard,
      mouse: this.mouse,
    }

    if (Core.isType(this.mask, Struct)) {
      Struct.set(json, "mask", this.mask)
    }

    if (Core.isType(this.stats, Struct)) {
      Struct.set(json, "stats", this.stats)
    }

    //return json
    return JSON.clone(json)
  }
}


///@param {PlayerStats} _stats
///@param {Struct} json
function PlayerStat(_stats, json) constructor {
  
  ///@type {PlayerStats}
  stats = Assert.isType(_stats, PlayerStats)

  ///@private
  ///@type {Number}
  value = Assert.isType(json.value, Number)

  ///@private
  ///@final
  ///@type {Number}
  minValue = Assert.isType(json.minValue, Number)

  ///@private
  ///@final
  ///@type {Number}
  maxValue = Assert.isType(json.maxValue, Number)

  ///@private
  ///@param {Number} previous
  ///@return {VisuPlayerStat}
  onValueUpdate = method(this, Core.isType(Struct
    .get(json, "onValueUpdate"), Callable) 
      ? json.onValueUpdate : function(previous) { return this })

  ///@private
  ///@return {VisuPlayerStat}
  onMinValueExceed = method(this, Core.isType(Struct
    .get(json, "onMinValueExceed"), Callable) 
      ? json.onMinValueExceed : function() { return this })
  
  ///@private
  ///@return {VisuPlayerStat}
  onMaxValueExceed = method(this, Core.isType(Struct
    .get(json, "onMaxValueExceed"), Callable) 
      ? json.onMaxValueExceed : function() { return this })

  ///@return {Number}
  get = function() { 
    return this.value
  }

  ///@return {Number}
  getMin = function() { 
    return this.minValue
  }

  ///@return {Number}
  getMax = function() { 
    return this.maxValue
  }

  ///@param {Number} value
  ///@return {VisuPlayerStat}
  set = function(value) {
    this.value = clamp(value, this.minValue, this.maxValue)
    return this
  }

  ///@param {Number} value
  ///@return {VisuPlayerStat}
  apply = function(value) {
    var previous = this.value
    var next = this.value + value
    this.set(next).onValueUpdate(previous)

    if (next < this.minValue) {
      this.onMinValueExceed()
    } else if (next > this.maxValue) {
      this.onMaxValueExceed()
    }

    return this
  }
}


///@param {PlayerStats} _stats
///@param {Struct} json
function PlayerStatLevel(_stats, json) constructor {

  ///@type {PlayerStats}
  stats = Assert.isType(_stats, PlayerStats)

  ///@type {Number}
  level = Core.isType(Struct.get(json, "level"), Number) ? json.level : 0

  ///@type {Array<Number>}
  tresholds = new Array(Number, Core.isType(Struct.get(json, "tresholds"), Array) 
    ? json.tresholds.getContainer() 
    : [ 0 ])

  ///@private
  ///@return {Number}
  getStat = method(this, Core.isType(Struct.get(json, "getStat"), Callable) 
    ? json.getStat 
    : function() { return 0 })

  ///@private
  ///@return {PlayerStatLevel}
  onLevelUp = method(this, Core.isType(Struct
    .get(json, "onLevelUp"), Callable) 
      ? json.onLevelUp : function() { return this })

  ///@return {Number}
  get = function() {
    return this.level
  }

  ///@param {Number} level
  ///@return {PlayerStatLevel}
  set = function(level) {
    this.level = level
    return this
  }

  ///@return {PlayerStatLevel}
  update = function() {
    this.tresholds.forEach(function(required, level, statLevel) {
      if (statLevel.getStat() < required) {
        return
      }
    
      if (level - 1 == statLevel.level) {
        this.set(level).onLevelUp()
      }
    }, this)

    return this
  }
}


///@param {Player} _player
///@param {Struct} json
function PlayerStats(_player, json) constructor {

  ///@type {Player}
  player = Assert.isType(_player, Player)

  ///@type {Number}
  force = new PlayerStat(this, Struct.appendUnique(Struct.get(json, "force"), {
    value: 0,
    minValue: 0,
    maxValue: 250,
    onValueUpdate: function(previous) { 
      var controller = Beans.get(BeanVisuController)
      var value = this.get()
      if (previous < value) {
        controller.sfxService.play("player-collect-point-or-force")
        //Core.print("Force incremented from", previous, "to", value)
      } else if (previous > value) {
        //Core.print("Force decremented from", previous, "to", value)
      }
      controller.playerService.statistics.freePlayer(this.stats.player, "force")
      return this
    },
    onMinValueExceed: function() { 
      //Core.print("Force already reached minimum")
      return this
    },
    onMaxValueExceed: function() { 
      //Core.print("Force alread reached maximum")
      return this
    },
  }))

  ///@type {PlayerStatLevel}
  forceLevel = new PlayerStatLevel(this, Struct.appendUnique(Struct.get(json, "forceLevel"), {
    tresholds: Core.getProperty("visu.player.force.tresholds", new Array(Number, [ 0 ]))
      .map(function(treshold) { return treshold }),
    getStat: function() {
      return this.stats.force.get()
    },
    onLevelUp: function() {
      var to = this.stats.force.get()
      var from = to - 1
      /*//@log.level*/ Logger.debug("Player", $"Player force advanced from level {from} to level {to}")
      Beans.get(BeanVisuController).sfxService.play("player-force-level-up")
      return this
    }
  }))

  ///@type {Number}
  point = new PlayerStat(this, Struct.appendUnique(Struct.get(json, "point"), {
    value: 0,
    minValue: 0,
    maxValue: 9999999,
    onValueUpdate: function(previous) { 
      var controller = Beans.get(BeanVisuController)
      var value = this.get()
      if (previous < value) {
        controller.sfxService.play("player-collect-point-or-force")
        //Core.print("Points incremented from", previous, "to", value)
      } else if (previous > value) {
        //Core.print("Points decremented from", previous, "to", value)
      }
      return this
    },
    onMinValueExceed: function() { 
      //Core.print("Points already reached minimum")
      return this
    },
    onMaxValueExceed: function() { 
      //Core.print("Points already reached maximum")
      return this
    },
  }))

  ///@type {PlayerStatLevel}
  pointLevel = new PlayerStatLevel(this, Struct.appendUnique(Struct.get(json, "pointLevel"), {
    tresholds: Core.getProperty("visu.player.point.tresholds", new Array(Number, [ 0 ]))
      .map(function(treshold) { return treshold }),
    getStat: function() {
      return this.stats.point.get()
    },
    onLevelUp: function() {
      var to = this.stats.point.get()
      var from = to - 1
      /*//@log.level*/ Logger.debug("Player", $"Player point advanced from level {from} to level {to}")
      this.stats.life.apply(1)
      return this
    }
  }))

  ///@type {Number}
  bomb = new PlayerStat(this, Struct.appendUnique(Struct.get(json, "bomb"), {
    value: 5,
    minValue: 0,
    maxValue: 10,
    onValueUpdate: function(previous) { 
      var controller = Beans.get(BeanVisuController)
      var value = this.get()
      if (previous < value) {
        /*//@log.level*/ Logger.debug("Player", $"Bombs increased from {previous} to {value}")
        controller.visuRenderer.hudRenderer.sendGlitchEvent()
        controller.sfxService.play("player-collect-bomb")
        //Core.print("Bomb added from", previous, "to", value)
      } else if (previous > value) {
        /*//@log.level*/ Logger.debug("Player", $"Bomb decreased from {previous} to {value}")
        this.stats.setBombCooldown(5.0)
        this.stats.setGodModeCooldown(5.0)

        var view = controller.gridService.view
        var player = this.stats.player

        controller.particleService.spawnParticleEmitter(
          "main",
          "particle-player-bomb-start",
          (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          0.0,
          3
        )
        
        /*
        controller.particleService.send(controller.particleService
          .factoryEventSpawnParticleEmitter({
            particleName: "particle-player-bomb-start",
            beginX: (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
            beginY: (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
            endX: (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
            endY: (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
            duration: 0.0,
            amount: 3,
          }))
        */
          
        var task = new Task("spawn-particle-player-bomb")
          .setTimeout(10.0)
          .setState({
            timer: new Timer(5.0),
            cooldown: new Timer(1.0, { loop: Infinity }),
          })
          .whenUpdate(function() {
            if (this.state.timer.update().finished) {
              this.fullfill()
            }

            var controller = Beans.get(BeanVisuController)
            var view = controller.gridService.view
            var player = controller.playerService.player
            if (!Core.isType(player, Player)) {
              return
            }

            if (!this.state.cooldown.update().finished) {
              return
            }

            var time = ceil(this.state.timer.finished ? this.state.timer.duration : this.state.timer.time)
            var col1 = time mod 2 != 0 ? "#371848" : "#FF00FF"
            var col2 = time mod 2 != 0 ? "#FF00FF" : "#371848"
            controller.subtitleService.send(new Event("add", {
              template: new SubtitleTemplate("sub-bomb", {
                lines: [
                  $"DROP THE BOMB"
                ],
              }),
              timeout: null,
              font: FontUtil.fetch("font_kodeo_mono_48_bold"),
              fontHeight: 96,
              color: ColorUtil.parse(col1).toGMColor(),
              outline: ColorUtil.parse(col2).toGMColor(),
              align: {
                v: VAlign.TOP,
                h: HAlign.CENTER,
              },
              area: new Rectangle({ 
                x: 0.25,
                y: 0.4,
                width: 0.5,
                height: 0.2,
              }),
              charSpeed: 0.25,
              lineDelay: new Timer(0.1),
              finishDelay: new Timer(1.0),
              angleTransformer: new NumberTransformer({
                value: 270.0,
                target: 270.0,
                duration: 0.0,
                ease: EaseType.LINEAR,
              }),
              speedTransformer: new NumberTransformer({
                value: 0.0,
                target: 128.0,
                duration: 13.88333,
                ease: EaseType.IN_SINE,
              }),
              fadeIn: 0.5,
              fadeOut: 0.5,
            }))

            controller.shroomService.shrooms.forEach(function(shroom, index, player) {
              if (!shroom.signals.kill && Math.fetchLength(shroom.x, shroom.y, player.x, player.y) <= 1.41) {
                shroom.signals.freeReason = "nuked"
                shroom.signal("kill")
              }
            }, player)

            controller.particleService.spawnParticleEmitter(
              "main",
              "particle-player-bomb",
              (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
              (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
              (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
              (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
              1.0,
              2,
              0.5
            )

            /*  
            controller.particleService.send(controller.particleService
              .factoryEventSpawnParticleEmitter({
                particleName: "particle-player-bomb",
                beginX: (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
                beginY: (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
                endX: (player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
                endY: (player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
                duration: 1.0,
                amount: 2,
                interval: 0.5,
              }))
            */

            controller.visuRenderer.hudRenderer.sendGlitchEvent()
            effect_track_event.brush_effect_glitch.run({
              "ef-glt_glitch": GlitchType.COMBINED,
              "ef-glt_shd-rng-seed":0.26406799999999998,
              "ef-glt_use-fade-out":true,
              "ef-glt_shd-intensity":0.3015499999999999,
              "ef-glt_fade-out":0.9789500000000001,
              "ef-glt_use-config":true,
              "ef-glt_line-spd":0.104141,
              "ef-glt_line-shift":0.085999999999999999,
              "ef-glt_line-res":0.253488,
              "ef-glt_line-v-shift":0.13178300000000001,
              "ef-glt_line-drift":0.1760000000000003,
              "ef-glt_jumb-spd":0.4160780000000001,
              "ef-glt_jumb-shift":0.4046299999999999,
              "ef-glt_jumb-res":0.34000000000000002,
              "ef-glt_jumb-chaos":0.82999999999999996,
              "ef-glt_shd-dispersion":0.3000000000000001,
              "ef-glt_shd-ch-shift":0.054421000000000002,
              "ef-glt_shd-noise":0.5883700000000001,
              "ef-glt_shd-shakiness":3.9549329999999996,
            })
          })
        controller.executor.add(task)

        var time = 1
        var col1 = time mod 2 != 0 ? "#371848" : "#FF00FF"
        var col2 = time mod 2 != 0 ? "#FF00FF" : "#371848"
        controller.subtitleService.send(new Event("add", {
          template: new SubtitleTemplate("sub-bomb", {
            lines: [
              $"DROP THE BOMB"
            ],
          }),
          timeout: null,
          font: FontUtil.fetch("font_kodeo_mono_48_bold"),
          fontHeight: 96,
          color: ColorUtil.parse(col1).toGMColor(),
          outline: ColorUtil.parse(col2).toGMColor(),
          align: {
            v: VAlign.TOP,
            h: HAlign.CENTER,
          },
          area: new Rectangle({ 
            x: 0.25,
            y: 0.4,
            width: 0.5,
            height: 0.2,
          }),
          charSpeed: 0.25,
          lineDelay: new Timer(0.1),
          finishDelay: new Timer(1.00),
          angleTransformer: new NumberTransformer({
            value: 270.0,
            target: 270.0,
            duration: 0.0,
            ease: EaseType.LINEAR,
          }),
          speedTransformer: new NumberTransformer({
            value: 0.0,
            target: 128.0,
            duration: 13.88333,
            ease: EaseType.IN_SINE,
          }),
          fadeIn: 0.5,
          fadeOut: 0.5,
        }))
        controller.sfxService.play("player-use-bomb")

        controller.playerService.statistics.freePlayer(this.stats.player, "bomb")
      }
      return this
    },
    onMinValueExceed: function() { 
      //Core.print("There is no bomb to be used")
      return this
    },
    onMaxValueExceed: function() { 
      //Core.print("Bombs are maxed out")
      return this
    },
  }))

  ///@type {PlayerStat}
  life = new PlayerStat(this, Struct.appendUnique(Struct.get(json, "life"), {
    value: 4,
    minValue: 0,
    maxValue: 10,
    onValueUpdate: function(previous) { 
      var controller = Beans.get(BeanVisuController)
      var value = this.get()
      if (previous < value) {
        /*//@log.level*/ Logger.debug("Player", $"Life increased from {previous} to {value}")
        controller.visuRenderer.hudRenderer.sendGlitchEvent()
        controller.sfxService.play("player-collect-life")
      } else if (previous > value) {
        /*//@log.level*/ Logger.debug("Player", $"Life decreased from {previous} to {value}")
        var view = controller.gridService.view
        this.stats.setGodModeCooldown(5.0)

        controller.visuRenderer.hudRenderer.sendGlitchEvent()

        if (!Visu.settings.getValue("visu.god-mode")) {
          controller.sfxService.play("player-die")
        }

        if (this.stats.bomb.get() < 3) {
          this.stats.bomb.set(3)
        }

        controller.particleService.spawnParticleEmitter(
          "main",
           "particle-player-death",
          (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          0.0,
          2
        )

        /*
        controller.particleService.send(controller.particleService
          .factoryEventSpawnParticleEmitter({
            particleName: "particle-player-death",
            beginX: (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
            beginY: (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
            endX: (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
            endY: (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
            duration: 0.0,
            amount: 2,
          }))
        */

        var forceValue = this.stats.force.get()
        var forceCoinAmount = ceil((forceValue / 2.0) + irandom(forceValue / 2.0))
        this.stats.force.apply(-1 * forceValue)
        this.stats.forceLevel.set(0)
        repeat (forceCoinAmount) {
          var _x = this.stats.player.x + (choose(0.33, -0.33) * (random(view.width) / view.width))
          var _y = min(view.y + (view.height / 1.5), this.stats.player.y) - 0.5 - (0.2 * (random(view.height) / view.height))
          var angle = Math.fetchPointsAngle(
            _x,
            _y,
            view.x + (view.width / 2.0),
            view.y
          )

          var speedMin = 2.0
          var speedMax = 5.0
          var speedValue = speedMin + random(speedMax - speedMin)
          var speedFactor = clamp(
            random(speedValue) / (speedMax * 10.0), 
            speedMin / (speedMax * 10.0), 
            speedMax / (speedMax * 10.0)
          )

          controller.coinService.spawnCoin("coin-force", _x, _y, angle, { 
            value: -1.0 * speedValue, 
            factor: speedFactor,
          })
          /*
          var coin = {
            template: "coin-force",
            x: _x,
            y: _y,
            angle: angle,
            speed: { 
              value: -1.0 * speedValue, 
              factor: speedFactor,
            },
          }
          controller.coinService.send(new Event("spawn-coin", coin))
          */
        }

        this.stats.player.x = view.x + (view.width / 2.0)
        this.stats.player.y = view.y + (view.height * 0.75)

        controller.particleService.spawnParticleEmitter(
          "main",
          "particle-player-respawn",
          (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          0.0,
          2
        )

        controller.playerService.statistics.freePlayer(this.stats.player, "life")

        /*
        controller.particleService.send(controller.particleService
          .factoryEventSpawnParticleEmitter({
            particleName: "particle-player-respawn",
            beginX: (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
            beginY: (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
            endX: (this.stats.player.x - view.x) * GRID_SERVICE_PIXEL_WIDTH,
            endY: (this.stats.player.y - view.y) * GRID_SERVICE_PIXEL_HEIGHT,
            duration: 0.0,
            amount: 2,
          }))
        */
      }
      return this
    },
    onMinValueExceed: function() { 

      var editor = Beans.get(Visu.modules().editor.controller)
      if (Visu.settings.getValue("visu.god-mode")
          || (editor != null && editor.renderUI)) {
        /*//@log.level*/ Logger.debug("Player", $"GOD MODE: respawn is possible")
        this.value = 3
        Beans.get(BeanVisuController)
          .send(new Event("spawn-popup", { 
            message: "GOD-MODE: respawning player"
          }))
      } else {
        /*//@log.level*/ Logger.debug("Player", $"GAME OVER: respawn is impossible")
        var controller = Beans.get(BeanVisuController)
        controller.send(new Event("game-over"))
      }
      
      //Core.print("Die!")
      //var controller = Beans.get(BeanVisuController)
      //controller.send(new Event("rewind", { timestamp: 0.0, resume: false }))
      //controller.playerService.send(new Event("clear-player"))
      return this
    },
    onMaxValueExceed: function() { 
      //Core.print("Life is maxed out")
      return this
    },
  }))

  ///@private
  ///@type {Number}
  godModeCooldown = 0.0

  ///@private
  ///@type {Number}
  bombCooldown = 0.0

  ///@param {Number} cooldown
  ///@return {PlayerStats}
  setGodModeCooldown = function(cooldown) {
    this.godModeCooldown = abs(cooldown)
    return this
  }

  ///@param {Number} cooldown
  ///@return {PlayerStats}
  setBombCooldown = function(cooldown) {
    this.bombCooldown = abs(cooldown)
    return this
  }

  ///@param {Coin} coin
  ///@throws {Exception}
  ///@return {PlayerStats}
  dispatchCoin = function(coin) {
    switch (coin.category) {
      case CoinCategory.FORCE:
        this.force.apply(coin.amount)
        break
      case CoinCategory.POINT:
        this.point.apply(coin.amount)
        break
      case CoinCategory.BOMB:
        this.bomb.apply(coin.amount)
        break
      case CoinCategory.LIFE:
        this.life.apply(coin.amount)
        break
      default:
        throw new Exception($"PlayerStats coin dispatcher for CoinCategory'{category}' wasn't found")
        break
    }

    return this
  }

  ///@return {PlayerStats}
  dispatchBomb = function() {
    if (this.bombCooldown == 0.0) {
      this.bomb.apply(-1)
    }

    return this
  }
  
  ///@return {PlayerStats}
  dispatchDeath = function() {
    if (this.godModeCooldown == 0.0) {
      this.life.apply(-1)
    }

    return this
  }

  ///@return {PlayerStats}
  update = function() {
    var step = DELTA_TIME * FRAME_MS
    //var step = DeltaTime.apply(FRAME_MS)
    this.setGodModeCooldown(this.godModeCooldown > step ? this.godModeCooldown - step : 0.0)
    this.setBombCooldown(this.bombCooldown > step ? this.bombCooldown - step : 0.0)
    this.forceLevel.update()
    this.pointLevel.update()

    return this
  }
}

///@param {Struct} json
function PlayerHandler(json) constructor {

  ///@type {GridItemMovement}
  x = new GridItemMovement(Struct.getIfType(json, "x", Struct, {}), true)
  
  ///@type {GridItemMovement}
  y = new GridItemMovement(Struct.getIfType(json, "y", Struct, {}), true)

  ///@type {Boolean}
  focus = Struct.getIfType(json, "focus", Boolean, false)

  ///@type {Struct}
  focusCooldown = {
    time: 0.0,
    duration: Struct.getIfType(json, "focusCooldown", Number, FRAME_MS * 10),
    finished: false,
    increment: function() {
      this.finished = false
      this.time += DELTA_TIME * FRAME_MS
      //this.time += DeltaTime.apply()
      if (this.time >= this.duration) {
        this.finished = true
        this.time = this.duration
      }

      return this
    },
    decrement: function() {
      this.finished = false
      this.time -= DELTA_TIME * FRAME_MS
      //this.time -= DeltaTime.apply()
      if (this.time <= 0.0) {
        this.time = 0.0
      }

      return this
    },
  }

  ///@type {Array<Struct>}
  guns = new Array(Struct, Core.isType(Struct.get(json, "guns"), GMArray)
    ? GMArray.map(json.guns, function(gun) {
      return {
        cooldown: new Timer(FRAME_MS * Struct.getIfType(gun, "cooldown", Number, 8.0), { 
          loop: Infinity,
          time: Struct.getIfType(gun, "time", Number, 0.0),
        }),
        bullet: Struct.getIfType(gun, "bullet", String, "bullet-default"),
        angle: Struct.getIfType(gun, "angle", Number, 90.0),
        speed: Struct.getIfType(gun, "speed", Number, 10.0),
        offsetX: Struct.getIfType(gun, "offsetX", Number, 0.0),
        offsetY: Struct.getIfType(gun, "offsetY", Number, 0.0),
        minForce: Struct.getIfType(gun, "minForce", Number, 0.0),
        maxForce: Struct.getIfType(gun, "maxForce", Number, null),
        focus: Struct.getIfType(gun, "focus", Boolean, null),
      }
    })
    : []
  )

  ///@override
  ///@param {GridItem} player
  ///@return {PlayerHandler}
  onStart = function(player) {
    this.x.speed = 0
    this.y.speed = 0
    this.guns.forEach(function(gun) {
      gun.cooldown.reset()
    })
    player.speed = 0
    player.angle = 90
    player.sprite.setAngle(player.angle)

    return this
  }

  ///@override
  ///@param {GridItem} player
  ///@param {VisuController} controller
  ///@return {PlayerHandler}
  update = function(player, controller) {
    static calcSpeed = function(config, player, keyA, keyB, keyFocus) {
      var spdMax = config.speedMax
      if (keyFocus) {
        var factor = DELTA_TIME * (abs(config.speedMax - config.speedMaxFocus) / 15.0)
        //var factor = DeltaTime.apply(abs(config.speedMax - config.speedMaxFocus) / 15.0)
        spdMax = clamp(abs(config.speed) - factor, config.speedMaxFocus, config.speedMax)
      }

      var spd = 0.0
      if (keyA || keyB) {
        var dir = keyA ? -1.0 : 1.0
        config.speed += dir * DELTA_TIME * config.acceleration * 0.5
        spd = DELTA_TIME * config.speed
        config.speed += dir * DELTA_TIME * config.acceleration * 0.5
        //config.speed += dir * DeltaTime.apply(config.acceleration) * 0.5
        //spd = DeltaTime.apply(config.speed)
        //config.speed += dir * DeltaTime.apply(config.acceleration) * 0.5
      } else if (abs(config.speed) - (DeltaTime.apply(config.friction) * 0.5) >= 0) {
        var dir = sign(config.speed)
        config.speed -= dir * DELTA_TIME * config.friction * 0.5
        spd = DELTA_TIME * config.speed
        config.speed -= dir * DELTA_TIME * config.friction * 0.5
        //config.speed -= dir * DeltaTime.apply(config.friction) * 0.5
        //spd = DeltaTime.apply(config.speed)
        //config.speed -= dir * DeltaTime.apply(config.friction) * 0.5
        if (sign(config.speed) != dir) {
          config.speed = 0.0
        }
      } else {
        config.speed = 0.0
      }
      config.speed = sign(config.speed) * clamp(abs(config.speed), 0.0, spdMax)
      //spd = sign(spd) * clamp(abs(spd), 0.0, spdMax)
      return spd
    }

    static updateKeyActionOnEnabled = function(gun, player, controller, focus, isMouseShoot) {
      var forceLevel = player.stats.forceLevel.get()
      if (!gun.cooldown.update().finished
          || (forceLevel < gun.minForce)
          || (gun.maxForce != null && forceLevel > gun.maxForce)
          || (gun.focus != null && gun.focus != focus)) {
        return
      }

      var angle = gun.angle
      if (isMouseShoot) {
        var gridRenderer = controller.visuRenderer.gridRenderer
        var player3DCoords = gridRenderer.player3DCoords
        var target3DCoords = gridRenderer.target3DCoords
        angle = gun.angle - 90 + Math.fetchPointsAngle(player3DCoords.x, player3DCoords.y, target3DCoords.x, target3DCoords.y)
      }
      
      controller.bulletService.spawnBullet(
        gun.bullet, 
        Player,
        player.x + (gun.offsetX / GRID_SERVICE_PIXEL_WIDTH), 
        player.y + (gun.offsetY / GRID_SERVICE_PIXEL_HEIGHT),
        angle,
        gun.speed
      )

      controller.sfxService.play("player-shoot")
    }

    static updateKeyActionOnDisabled = function(gun) {
      if (!gun.cooldown.finished && gun.cooldown.update().finished) {
        gun.cooldown.reset()
      }
    }

    static updateGMTFContextFocused = function(key) {
      key.on = false
      key.pressed = false
      key.released = false
    }

    static disableMouseButton = function(button) {
      button.on = false
      button.pressed = false
      button.released = false
    }
    
    var keys = player.keyboard.keys
    var mouseButtons = player.mouse.buttons
    this.focus = keys.focus.on || mouseButtons.focus.on
      ? this.focusCooldown.increment().finished
      : this.focusCooldown.decrement().finished

    if (GMTFContext.isFocused()) {
      Struct.forEach(keys, updateGMTFContextFocused)
    }

    var editor = Beans.get(Visu.modules().editor.controller)
    var layout = editor == null ? controller.visuRenderer.layout : editor.layout.nodes.preview
    var mouseX = MouseUtil.getMouseX() - layout.x()
    var mouseY = MouseUtil.getMouseY() - layout.y()
    var mouseShoot = (mouseX >= 0 && mouseX <= layout.width() && mouseY >= 0 && mouseY <= layout.height())
      ? (keys.action.on || mouseButtons.action.on) && Visu.settings.getValue("visu.developer.mouse-shoot", false)
      : (Struct.forEach(mouseButtons, disableMouseButton) != null && false)

    if (keys.action.on || mouseShoot) {
      var gunsSize = this.guns.size()
      for (var gunIdx = 0; gunIdx < gunsSize; gunIdx++) {
        updateKeyActionOnEnabled(this.guns.get(gunIdx), player, controller, this.focus, mouseShoot)
      }
    } else {
      this.guns.forEach(updateKeyActionOnDisabled)
    }

    if (keys.bomb.pressed || mouseButtons.bomb.pressed) {
      player.stats.dispatchBomb()
    }

    if (player.signals.shroomCollision != null || player.signals.bulletCollision != null) {
      this.x.speed = 0.0
      this.y.speed = 0.0
      player.stats.dispatchDeath()
    }

    var up = keyboard_check(vk_up)
    var down = keyboard_check(vk_down)
    var left = keyboard_check(vk_left)
    var right = keyboard_check(vk_right)
    player.x = clamp(
      player.x + calcSpeed(this.x, player, 
        left || keys.left.on || mouseButtons.left.on,
        right || keys.right.on || mouseButtons.right.on,
        keys.focus.on || mouseButtons.focus.on
      ),
      0.0,
      controller.gridService.width
    )

    player.y = clamp(
      player.y + calcSpeed(this.y, player,
        up || keys.up.on || mouseButtons.up.on,
        down || keys.down.on || mouseButtons.down.on,
        keys.focus.on || mouseButtons.focus.on
      ), 
      0.0, 
      controller.gridService.height
    )
    
    //var halfPi = pi / 2
    //global.cameraRollSpeed = sin((this.y.speed / this.y.speedMax) * halfPi) * 5.0;
    //global.cameraPitchSpeed = sin((this.x.speed / this.x.speedMax) * halfPi) * 5.0;
    //global.cameraYawSpeed = sin((this.x.speed / this.x.speedMax) * halfPi) * 5.0;
    //Core.print("this.x.speed:", this.x.speed, "this.x.speedMax:", this.x.speedMax, "this.y.speed:", this.y.speed, "this.y.speedMax:", this.y.speedMax, "global.cameraRollSpeed:", global.cameraRollSpeed, "global.cameraPitchSpeed:", global.cameraPitchSpeed, "global.cameraYawSpeed:", global.cameraYawSpeed)

    return this
  }
}

///@param {Struct} template
function Player(template): GridItem(template) constructor {

  ///@type {Keyboard}
  keyboard = Assert.isType(template.keyboard, Keyboard)

  ///@type {Keyboard}
  mouse = Assert.isType(template.mouse, Mouse)

  ///@type {PlayerStats}
  stats = new PlayerStats(this, Struct.get(template, "stats"))

  ///@type {PlayerHandler}
  handler = new PlayerHandler(Struct.getIfType(template, "handler", Struct, {})).onStart(this)
  
  ///@override
  ///@param {VisuController} controller
  ///@return {GridItem}
  static move = function(controller) {
    gml_pragma("forceinline")
    this.signals.reset()

    var _speed = DELTA_TIME * this.speed
    //var _speed = DeltaTime.apply(this.speed)
    this.x += Math.fetchCircleX(_speed, this.angle)
    this.y += Math.fetchCircleY(_speed, this.angle)
    return this
  }


  ///@override
  ///@return {GridItem}
  static update = function(controller) {
    this.keyboard.update()
    this.mouse.update()
    this.handler.update(this, controller)
    this.stats.update()

    if (this.fadeIn < 1.0) {
      this.fadeIn = clamp(this.fadeIn + VISU_FADE_FACTOR, 0.0, 1.0)
    }

    var view = controller.gridService.view
    var targetLocked = controller.gridService.targetLocked
    if (targetLocked.isLockedX && targetLocked.lockX != null) { 
      var horizontal = controller.gridService.properties.borderHorizontalLength / 2.0
      var width = (this.sprite.getWidth() / 2.0) / GRID_SERVICE_PIXEL_WIDTH
      var xMin = targetLocked.lockX + (view.width / 2.0) - horizontal + width
      var xMax = targetLocked.lockX + (view.width / 2.0) + horizontal - width
      var xMinOffset = xMin < 0 ? abs(xMin) : 0.0
      var xMaxOffset = xMax > view.worldWidth ? xMax - view.worldWidth : 0.0
      xMin = clamp(xMin - xMaxOffset, 0.0, view.worldWidth)
      xMax = clamp(xMax + xMinOffset, 0.0, view.worldWidth)
        
      this.x = clamp(this.x, xMin, xMax)
    }

    if (targetLocked.isLockedY && targetLocked.lockY != null) { 
      var vertical = controller.gridService.properties.borderVerticalLength / 2.0
      var height = (this.sprite.getHeight() / 2.0) / GRID_SERVICE_PIXEL_HEIGHT
      var yMin = targetLocked.lockY + (view.height / 2.0) - vertical + height
      var yMax = targetLocked.lockY + (view.height / 2.0) + vertical - height
      var yMinOffset = yMin < 0 ? abs(yMin) : 0.0
      var yMaxOffset = yMax > view.worldHeight ? yMax - view.worldHeight : 0.0
      yMin = clamp(yMin - yMaxOffset, 0.0, view.worldHeight)
      yMax = clamp(yMax + yMinOffset, 0.0, view.worldHeight)

      this.y = clamp(this.y, yMin, yMax)
    }

    this.x = clamp(this.x, 0.0, view.worldWidth)
    this.y = clamp(this.y, 0.0, view.worldHeight)

    controller.playerService.statistics.freePlayer(this)

    return this
  }
}
