///@package io.alkapivo.visu.service.grid.feature
  
///@description Example usage
/**
[
  {
    "type": "MisterDominoBulletSpawner",
    "conditions": [],
    "data": {
      "interval": 0.5,
      "useCallback": true
    }
  } 
]
 */
///@param {Struct} json
function MisterDominoBulletSpawner(json): GridItemFeature(json) constructor { 
  var data = Struct.get(json, "data")

  ///@type {Number}
  interval = Struct.getIfType(data, "interval", "Number", 1.0)

  ///@type {Boolean}
  useCallback = Struct.getIfType(data, "useCallback", "Boolean", true)

  ///@private
  ///@type {Timer}
  customTimer = new Timer(this.interval, {
    loop: Infinity,
    callback: (this.useCallback
      ? function(context) {
          Core.print("use callback in customTimer",
            "\n - interval:", context.interval,
            "\n - useCallback:", context.useCallback,
            "\n - loopCounter:", this.loopCounter
          )
        }
      : null),
  })

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    this.customTimer.update(this)
    if (!this.useCallback && this.customTimer.finished) {
      Core.print("use if statement in customTimer",
        "\n - interval:", this.interval,
        "\n - useCallback:", this.useCallback,
        "\n - loopCounter:", this.customTimer.loopCounter
      )
    }
  }
}


///@param {Struct} json
function BulletFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")

  ///@type {String}
  bullet = Struct.getIfType(data, "bullet", String, "bullet-default")

  ///@type {Number}
  aimPlayer = Struct.getIfType(data, "aimPlayer", Number, 0.0)

  ///@type {?Struct|?Number}
  angleOffset = Struct.get(data, "angleOffset")

  ///@type {?Boolean}
  angleOffsetRng = Struct.get(data, "angleOffsetRng")

  ///@type {?Boolean}
  sumAngleOffset = Struct.get(data, "sumAngleOffset")

  ///@type {?Struct|?Number}
  speedOffset = Struct.get(data, "speedOffset")

  ///@type {?Boolean}
  sumSpeedOffset = Struct.get(data, "sumSpeedOffset")

  var context = this
  ///@type {GridItemEmitter}
  emitter = new GridItemEmitter(Struct.appendUnique({
    state: { 
      playerAngle: 0.0,
      context: context,
    },
    preCallback: function(item, controller, emitter) {
      emitter.state.playerAngle = item.angle + emitter.angle.value
      if (abs(emitter.state.context.aimPlayer) > 0.0) {
        var player = controller.playerService.player
        if (player != null) {
          emitter.state.playerAngle = Math.fetchPointsAngle(item.x, item.y, player.x, player.y)
        }
      }
    },
    callback: function(item, controller, emitter, idx, arrIdx, x, y, _angle, speed) {
      var angle = _angle
      if (abs(emitter.state.context.aimPlayer) > 0) {
        angle = Math.lerpAngle(angle, emitter.state.playerAngle, emitter.state.context.aimPlayer)
      }

      controller.bulletService.spawnBullet(
        emitter.state.context.bullet,
        Shroom,
        item.x + x,
        item.y + y,
        angle,
        speed,
        emitter.state.context.angleOffset,
        emitter.state.context.angleOffsetRng,
        emitter.state.context.sumAngleOffset,
        emitter.state.context.speedOffset,
        emitter.state.context.sumSpeedOffset
      )
    }
  }, Struct.get(data, "emitter"), false))
  
  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    this.emitter.update(item, controller)
  }
}


///@param {Struct} json 
function ShootFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")
  
  ///@override
  ///@type {String}
  type = "ShootFeature"

  ///@type {String}
  bullet = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "bullet")), String, "bullet-default")

  ///@type {?Number}
  bullets = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "bullets")), Number)

  ///@type {Number}
  amount = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "amount")), Number, 1.0)
  
  ///@type {Number}
  speed = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "speed")), Number, 20.0)

  ///@type {Timer}
  cooldown = new Timer(
    Core.getIfType(GMArray.resolveRandom(Struct.get(data, "interval")), Number, 0.0),
    { loop: this.bullets != null ? this.bullets + 1 : Infinity }
  )

  ///@type {Number}
  angle = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "angle")), Number, 0.0)

  ///@type {Number}
  angleStep = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "angleStep")), Number, 360.0 / this.amount)

  ///@type {Boolean}
  targetPlayer = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "targetPlayer")), Boolean, false)

  ///@type {Number}
  randomAngle = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "randomRange")), Number, 0.0)

  ///@type {Number}
  randomSpeed = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "randomSpeed")), Number, 0.0)

  ///@type {Number}
  offsetX = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "offsetX")), Number, 0.0) / GRID_SERVICE_PIXEL_WIDTH

  ///@type {Number}
  offsetY = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "offsetY")), Number, 0.0) / GRID_SERVICE_PIXEL_HEIGHT

  ///@type {Number}
  offsetAngleStep = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "offsetAngleStep")), Number, 0.0)

  ///@type {Number}
  randomOffsetAngle = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "randomOffsetAngle")), Number, 0.0)
  
  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    if (!this.cooldown.update().finished 
        || this.cooldown.loop == this.cooldown.loopCounter) {
      return
    }

    var angle = item.angle + this.angle
    if (this.targetPlayer) {
      var player = Beans.get(BeanVisuController).playerService.player
      if (Core.isType(player, Player)) {
        angle = Math.fetchPointsAngle(item.x, item.y, player.x, player.y) 
          + this.angle
      }
    }

    var offsetLength = Math.fetchLength(0.0, 0.0, this.offsetX, this.offsetY)
    var offsetAngle = Math.fetchPointsAngle(0.0, 0.0, this.offsetX, this.offsetY)
    for (var index = 0; index < amount; index++) {
      controller.bulletService.spawnBullet(
        this.bullet,
        Shroom,
        item.x + Math.fetchCircleX(offsetLength, offsetAngle
          + (index * this.offsetAngleStep)
          + (random(this.randomOffsetAngle) * choose(1, -1))), 
        item.y + Math.fetchCircleY(offsetLength, offsetAngle
          + (index * this.offsetAngleStep)
          + (random(this.randomOffsetAngle) * choose(1, -1))),
        angle + (index * this.angleStep)
          + (random(this.randomAngle) * choose(1, -1)),
        this.speed + (random(this.randomSpeed) * choose(1, -1))
      )

      //controller.bulletService.send(new Event("spawn-bullet", {
      //  template: this.bullet,
      //  producer: Shroom,
      //  x: item.x,
      //  y: item.y,
      //  angle: angle 
      //    + (index * this.angleStep) 
      //    + (random(this.randomAngle) * choose(1, -1)),
      //  speed: this.speed
      //    + (random(this.randomSpeed) * choose(1, -1)),
      //}))
    }
  }
}
