///@package io.alkapivo.visu.service.bullet.BulletService

///@param {?Struct} [config]
function BulletService(config = null): Service(config) constructor {

  ///@type {Array<Bullet>}
  bullets = new Array(Bullet).enableGC()

  ///@type {Map<String, BulletTemplate>}
  templates = new Map(String, BulletTemplate)

  ///@type {GridItemChunkService}
  chunkService = new GridItemChunkService(GRID_ITEM_CHUNK_SERVICE_SIZE)
  
  ///@param {Boolean}
  optimalizationSortEntitiesByTxGroup = false

  ///@param {String} name
  ///@return {?BulletTemplate}
  getTemplate = function(name) {
    var template = this.templates.get(name)
    return template == null
      ? Visu.assets().bulletTemplates.get(name)
      : template
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "spawn-bullet": function(event, dispatcher) {
      var template = new BulletTemplate(event.data.template, this
        .getTemplate(event.data.template)
        .serialize())
      
      var controller = Beans.get(BeanVisuController)
      Struct.set(template, "x", event.data.x)
      Struct.set(template, "y", event.data.y)
      Struct.set(template, "angle", event.data.angle)
      Struct.set(template, "speed", event.data.speed / 1000)
      Struct.set(template, "producer", event.data.producer)
      Struct.set(template, "uid", controller.gridService.generateUID())

      if (event.data.producer == Shroom) {
        controller.sfxService.play("shroom-shoot")
      }
      
      var bullet = new Bullet(template)

      this.statistics.factoryBullet(bullet)
      this.bullets.add(bullet)
      if (event.data.producer == Player) {
        this.chunkService.add(bullet)
      }

      if (this.optimalizationSortEntitiesByTxGroup) {
        controller.gridService.textureGroups.sortItems(this.bullets)
      }
    },
    "clear-bullets": function(event) {
      static freeBullet = function(bullet, idx, bulletService) {
        if (!bullet.signals.kill) {
          bullet.signals.freeReason = "expired"
          bullet.signal("kill")
        }

        bulletService.statistics.freeBullet(bullet, bullet.signals.freeReason)
      }

      this.bullets.forEach(freeBullet, this).clear()
      this.chunkService.clear()
    },
    "reset-templates": function(event) {
      this.statistics.reset()
      this.templates.clear()
      this.dispatcher.container.clear()
    },
  }), {
    loggerPrefix: "BulletService",
    enableLogger: true,
    catchException: false,
  })

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, { 
    loggerPrefix: "BulletService",
    enableLogger: true,
    catchException: true,
    exceptionCallback: function(task, exception) {
      task.status = TaskStatus.REJECTED
      var message = $"'BulletService::executor' (task.name: {task.name}), fatal error: {exception.message}"
      Beans.get(BeanVisuController).exceptionDebugHandler(message, exception)
    },
  })

  statistics = {
    spawnedByPlayer: 0,
    spawnedByShrooms: 0,
    hitShroom: 0,
    hitPlayer: 0,
    expired: 0,
    report: function() {
      return {
        spawnedByPlayer: this.spawnedByPlayer,
        spawnedByShrooms: this.spawnedByShrooms,
        hitShroom: this.hitShroom,
        hitPlayer: this.hitPlayer,
        expired: this.expired,
      }
    },
    reset: function() {
      this.spawnedByPlayer = 0
      this.spawnedByShrooms = 0
      this.hitShroom = 0
      this.hitPlayer = 0
      this.expired = 0
      return this
    },
    factoryBullet: function(bullet) {
      if (bullet.producer == Player) {
        this.spawnedByPlayer += 1
      } else {
        this.spawnedByShrooms += 1
      }

      return this
    },
    freeBullet: function(shroom, reason) {
      switch (reason) {
        case "hitShroom":
          this.hitShroom += 1
          break
        case "hitPlayer":
          this.hitPlayer += 1
          break
        case "expired":
          this.expired += 1
          break
        default:
          Logger.warn("BulletService", $"freeBullet reason: {reason}")
          this.expired += 1
          break
      }
      return this
    },
    validate: function() {
      Assert.areEqual(this.spawnedByPlayer + this.spawnedByShrooms - this.hitShroom - this.hitPlayer - this.expired, 0.0, "Invalid BulletStatistics")
      Logger.debug("BulletService", "BulletStatistics are OK")
    },
  }

  ///@param {String} name
  ///@param {Shroom|Player} producer
  ///@param {Number} x
  ///@param {Number} y
  ///@param {Number} angle
  ///@param {Number} speed
  ///@param {?Number|?Struct} [angleOffset]
  ///@param {?Boolean} [angleOffsetRng]
  ///@param {?Boolean} [sumAngleOffset]
  ///@param {?Number|?Struct} [speedOffset]
  ///@param {?Boolean} [sumSpeedOffset]
  ///@param {?Number} [lifespan]
  ///@param {?Number} [damage]
  ///@param {Boolean} [onDeath]
  static spawnBullet = function(name, producer, x, y, angle, speed, angleOffset = null, 
      angleOffsetRng = null, sumAngleOffset = null, speedOffset = null, 
      sumSpeedOffset = null, lifespan = null, damage = null, onDeath = false) {

    var controller = Beans.get(BeanVisuController)
    var template = this.getTemplate(name).serializeSpawn(
      controller.gridService.generateUID(),
      producer,
      x,
      y,
      angle,
      speed / GRID_ITEM_SPEED_SCALE,
      angleOffset,
      angleOffsetRng,
      sumAngleOffset,
      speedOffset,
      sumSpeedOffset,
      lifespan,
      damage
    )

    if (producer == Shroom && !onDeath) {
      controller.sfxService.play("shroom-shoot")
    }
    
    var bullet = new Bullet(template)
    if (producer == Player) {
      this.chunkService.add(bullet)
    }

    this.bullets.add(bullet)
    this.statistics.factoryBullet(bullet)

    if (this.optimalizationSortEntitiesByTxGroup) {
      controller.gridService.textureGroups.sortItems(this.bullets)
    }

    if (onDeath) {
      bullet.fadeIn = 1.0
    }
  }

  ///@param {Struct} item
  ///@param {Struct} emitter
  ///@return {BulletService}
  static spawnBulletEmitter = function(item, emitter) {
    var task = new Task("bullet-emitter")
      .setTimeout(999.9)
      .setState({
        item: item,
        emitter: new GridItemEmitter(Struct.appendRecursive({
          callback: function(item, controller, emitter, idx, arrIdx, x, y, angle, speed) {
            var view = controller.gridService.view
            var locked = controller.gridService.targetLocked
            var viewX = item.snapH ? locked.snapH : view.x
            var viewY = item.snapV ? locked.snapV : view.y
            var angleOffset = item.angleOffset
            var angleOffsetRng = item.angleOffsetRng
            var sumAngleOffset = item.sumAngleOffset
            var speedOffset = item.speedOffset
            var sumSpeedOffset = item.sumSpeedOffset
            var lifespan = item.lifespan
            var damage = item.damage
            controller.bulletService.spawnBullet(
              item.name,
              Shroom,
              viewX + item.spawnX + x,
              viewY + item.spawnY + y,
              angle,
              speed,
              angleOffset,
              angleOffsetRng,
              sumAngleOffset,
              speedOffset,
              sumSpeedOffset,
              lifespan,
              damage
            )
          }
        }, emitter, false)),
      })
      .whenUpdate(function() {
        if (this.state.emitter.finished()) {
          this.fullfill()
          return
        }

        this.state.emitter.update(this.state.item, Beans.get(BeanVisuController))
      })
    this.executor.add(task)

    return this
  }

  static updateBullet = function(bullet, index, controller) {
    gml_pragma("forceinline")
    bullet.update(controller)
    if (!bullet.signals.kill) {
      return
    }

    var bulletService = controller.bulletService
    bulletService.statistics.freeBullet(bullet, bullet.signals.freeReason)
    bulletService.bullets.addToGC(index)
    if (bullet.producer == Player) {
      bulletService.chunkService.remove(bullet)
    }

    if (!Optional.is(bullet.onDeath)) {
      return
    }
    
    for (var idx = 0; idx < bullet.onDeathAmount; idx++) {
      var rngDir = bullet.onDeathAngleRng ? choose(1, -1) : 1
      var rngSpd = random(bullet.onDeathRngSpeed)
      var dir = bullet.angle + (rngDir * bullet.onDeathAngle) 
        + (rngDir * idx * bullet.onDeathAngleStep * Math.pow(bullet.onDeathAngleIncrease, clamp(idx - 1, 1, bullet.onDeathAmount))) 
        + (rngDir * (random(2.0 * bullet.onDeathRngStep) - bullet.onDeathRngStep))
      var spd = clamp(abs(bullet.onDeathSpeedMerge 
        ? (rngSpd + (bullet.speed * GRID_ITEM_SPEED_SCALE) + bullet.onDeathSpeed) 
        : (rngSpd + bullet.onDeathSpeed)), 0.1, 99.9)

      var angleOffset = null
      var angleOffsetRng = null
      var sumAngleOffset = null
      var speedOffset = null
      var sumSpeedOffset = null
      var lifespan = null
      var damage = null
      var onDeath = true
      bulletService.spawnBullet(
        bullet.onDeath, 
        bullet.producer,
        bullet.x, 
        bullet.y,
        dir,
        spd,
        angleOffset,
        angleOffsetRng,
        sumAngleOffset,
        speedOffset,
        sumSpeedOffset,
        lifespan,
        damage,
        onDeath
      )
    }
  }

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    gml_pragma("forceinline")
    return this.dispatcher.send(event)
  }

  ///@return {BulletService}
  update = function() { 
    //this.optimalizationSortEntitiesByTxGroup = Visu.settings.getValue("visu.optimalization.sort-entities-by-txgroup")
    this.dispatcher.update()
    this.executor.update()
    this.bullets.forEach(this.updateBullet, Beans.get(BeanVisuController)).runGC(true)
    return this
  }
}
