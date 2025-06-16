///@package io.alkapivo.visu.service.grid.feature

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
function _BulletFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")

  ///@type {String}
  bullet = Struct.getIfType(data, "bullet", String, "bullet-default")

  ///@type {Number}
  angle = Struct.getIfType(data, "angle", Number, 0.0)
  
  ///@type {Number}
  angleRandom = Struct.getIfType(data, "angleRandom", Number, 0.0)
  
  ///@type {Number}
  angleStep = Struct.getIfType(data, "angleStep", Number, 0.0)

  ///@type {Number}
  bullets = Struct.getIfType(data, "bullets", Number, 1.0)
  
  ///@type {Number}
  bulletArrays = Struct.getIfType(data, "bulletArrays", Number, 1.0)

  ///@type {Number}
  anglePerArray = Struct.getIfType(data, "anglePerArray", Number, 0.0)

  ///@type {Number}
  anglePerArrayRandom = Struct.getIfType(data, "anglePerArrayRandom", Number, 0.0)

  ///@type {Number}
  anglePerArrayStep = Struct.getIfType(data, "anglePerArrayStep", Number, 0.0)

  ///@type {Number}
  bulletsPerArray = Struct.getIfType(data, "bulletsPerArray", Number, 1.0)

  ///@type {NumberTransformer}
  spin = new NumberTransformer(Struct.getDefault(data, "spin", 0.0))

  ///@type {Number}
  interval = Struct.getIfType(data, "interval", Number, FRAME_MS)

  ///@type {NumberTransformer}
  offsetX = new NumberTransformer(Struct.getDefault(data, "offsetX", 0.0))

  ///@type {NumberTransformer}
  offsetY = new NumberTransformer(Struct.getDefault(data, "offsetY", 0.0))
  
  ///@type {NumberTransformer}
  bulletSpeed = new NumberTransformer(Struct.getDefault(data, "bulletSpeed", 0.0))

  ///@type {Number}
  bulletSpeedRandom = Struct.getIfType(data, "bulletSpeedRandom", Number, 0.0)

  ///@type {Number}
  aimPlayer = Struct.getIfType(data, "aimPlayer", Number, 0.0)

  ///@type {Number}
  spinValueMax = Struct.getIfType(data, "spinValueMax", Number, 0.0)

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

  ///@private
  ///@type {Number}
  time = 0.0

  ///@private
  ///@type {Number}
  shoots = 0.0

  ///@private
  ///@type {Number}
  spinValue = 0.0

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {

    var angle = item.angle + this.angle + this.spinValue
    var playerAngle = angle
    if (abs(this.aimPlayer) > 0) {
      var player = controller.playerService.player
      if (Optional.is(player)) {
        playerAngle = Math.fetchPointsAngle(item.x, item.y, player.x, player.y)
      }
    }

    var offsetLength = Math.fetchLength(0.0, 0.0, this.offsetX.value, this.offsetY.value)
    var offsetAngle = Math.fetchPointsAngle(0.0, 0.0, this.offsetX.value, this.offsetY.value)
    var bulletArrayAngle = angle
    for (var idx = 0; idx < this.bulletArrays; idx++) {
      bulletArrayAngle += (idx * this.angleStep) + random(this.angleRandom)
      for (var arrIdx = 0; arrIdx < this.bulletsPerArray; arrIdx++) {
        var bulletX = item.x + Math.fetchCircleX(offsetLength, offsetAngle)
        var bulletY = item.y + Math.fetchCircleY(offsetLength, offsetAngle)
        var bulletAngle = bulletArrayAngle + this.anglePerArray + (arrIdx * this.anglePerArrayStep) + random(this.anglePerArrayRandom)
        var bulletSpeed = this.bulletSpeed.value + random(this.bulletSpeedRandom)
        if (abs(this.aimPlayer) > 0) {
          bulletAngle = Math.lerpAngle(bulletAngle, playerAngle, this.aimPlayer)
        }

        controller.bulletService.spawnBullet(
          this.bullet,
          Shroom,
          bulletX,
          bulletY,
          bulletAngle,
          bulletSpeed,
          this.angleOffset,
          this.angleOffsetRng,
          this.sumAngleOffset,
          this.speedOffset,
          this.sumSpeedOffset
        )
      }
    }

    this.shoots += 1
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


///@param {Struct} json
///@return {GridItemFeature}
function _ShootFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)

  var amount = Core.isType(Struct.get(data, "amount"), Number) ? data.amount : 1.0,
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: ShootFeature,

    ///@type {String}
    bullet: Assert.isType(data.bullet, String),

    ///@type {?Number}
    bullets: Core.isType(Struct.get(data, "bullets"), Number) ? data.bullets : null,

    ///@type {Number}
    speed: Core.isType(Struct.get(data, "speed"), Number) ? data.speed : 20.0,

    ///@private
    ///@type {Timer}
    cooldown: new Timer(
      Core.isType(Struct.get(data, "interval"), Number) ? data.interval : 0.0,
      { loop: Core.isType(Struct.get(data, "bullets"), Number) ? data.bullets + 1 : Infinity }
    ),

    ///@private
    ///@type {Number}
    amount: amount,

    ///@private
    ///@type {Number}
    angle: Core.isType(Struct.get(data, "angle"), Number) ? data.angle : 0.0,

    ///@private
    ///@type {Number}
    angleStep: Core.isType(Struct.get(data, "angleStep"), Number) ? data.angleStep : (360.0 / amount),

    ///@type {Boolean}
    targetPlayer: Core.isType(Struct.get(data, "targetPlayer"), Boolean) ? data.targetPlayer : false,

    ///@type {Number}
    randomAngle: Core.isType(Struct.get(data, "randomRange"), Number) ? data.randomRange : 0.0,

    ///@type {Number}
    randomSpeed: Core.isType(Struct.get(data, "randomSpeed"), Number) ? data.randomSpeed : 0.0,

    ///@type {Number}
    offsetX: Struct.getIfType(data, "offsetX", Number, 0.0),

    ///@type {Number}
    offsetY: Struct.getIfType(data, "offsetY", Number, 0.0),

    ///@type {Number}
    offsetAngleStep: Struct.getIfType(data, "offsetAngleStep", Number, 0.0),

    ///@type {Number}
    randomOffsetAngle: Struct.getIfType(data, "randomOffsetAngle", Number, 0.0),

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
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
    },
  }))
}