///@package io.alkapivo.visu.service.grid.feature

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
  offsetX = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "offsetX")), Number, 0.0)

  ///@type {Number}
  offsetY = Core.getIfType(GMArray.resolveRandom(Struct.get(data, "offsetY")), Number, 0.0)

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
        item.x + Math.fetchCircleX(offsetLength, offsetAngle
          + (index * this.offsetAngleStep)
          + (random(this.randomOffsetAngle) * choose(1, -1))), 
        item.y + Math.fetchCircleY(offsetLength, offsetAngle
          + (index * this.offsetAngleStep)
          + (random(this.randomOffsetAngle) * choose(1, -1))),
        angle + (index * this.angleStep)
          + (random(this.randomAngle) * choose(1, -1)),
        this.speed + (random(this.randomSpeed) * choose(1, -1)),
        Shroom
      )

      //controller.bulletService.send(new Event("spawn-bullet", {
      //  x: item.x,
      //  y: item.y,
      //  angle: angle 
      //    + (index * this.angleStep) 
      //    + (random(this.randomAngle) * choose(1, -1)),
      //  speed: this.speed
      //    + (random(this.randomSpeed) * choose(1, -1)),
      //  producer: Shroom,
      //  template: this.bullet,
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
          item.x + Math.fetchCircleX(offsetLength, offsetAngle
            + (index * this.offsetAngleStep)
            + (random(this.randomOffsetAngle) * choose(1, -1))), 
          item.y + Math.fetchCircleY(offsetLength, offsetAngle
            + (index * this.offsetAngleStep)
            + (random(this.randomOffsetAngle) * choose(1, -1))),
          angle + (index * this.angleStep)
            + (random(this.randomAngle) * choose(1, -1)),
          this.speed + (random(this.randomSpeed) * choose(1, -1)),
          Shroom
        )

        //controller.bulletService.send(new Event("spawn-bullet", {
        //  x: item.x,
        //  y: item.y,
        //  angle: angle 
        //    + (index * this.angleStep) 
        //    + (random(this.randomAngle) * choose(1, -1)),
        //  speed: this.speed
        //    + (random(this.randomSpeed) * choose(1, -1)),
        //  producer: Shroom,
        //  template: this.bullet,
        //}))
      }
    },
  }))
}