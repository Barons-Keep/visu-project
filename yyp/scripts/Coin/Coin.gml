///@package io.alkapivo.visu.service.coin

function _CoinCategory(): Enum() constructor {
  FORCE = "force"
  POINT = "point"
  BOMB = "bomb"
  LIFE = "life"

  ///@override
  ///@return {Array<String>}
  keys = function() {
    static filterKeys = function(key) {
      return key != "_keys"
          && key != "keys"
          && key != "get"
          && key != "getKey"
          && key != "findKey"
          && key != "contains"
          && key != "containsKey"
    }

    if (this._keys == null) {
      this._keys = new Array(String, GMArray.sort(GMArray.filter(Struct.keys(this), filterKeys)))
    }

    return this._keys
  }
}
global.__CoinCategory = new _CoinCategory()
#macro CoinCategory global.__CoinCategory


///@param {String} _name
///@param {Struct} json
function CoinTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String,
    "CoinTemplate::name must be type of String")

  ///@type {CoinCategory}
  category = Assert.isEnum(json.category, CoinCategory,
    "CoinTemplate::category must be type of CoinCategory")

  ///@type {Struct}
  sprite = Assert.isType(json.sprite, Struct,
    "CoinTemplate::sprite must be type of Struct")

  ///@type {?Struct}
  mask = Struct.getIfType(json, "mask", Struct)

  ///@type {?Number}
  amount = Struct.getIfType(json, "amount", Number)

  ///@type {?Struct}
  speed = Struct.getIfType(json, "speed", Struct)

  ///@type {Boolean}
  useSpeed = Struct.getIfType(json, "useSpeed", Boolean, false)

  ///@type {Boolean}
  changeSpeed = Struct.getIfType(json, "changeSpeed", Boolean, false)

  //@return {Struct}
  serialize = function() {
    return {
      name: this.name,
      category: this.category,
      sprite: this.sprite,
      useSpeed: this.useSpeed,
      changeSpeed: this.changeSpeed,
      mask: this.mask != null ? JSON.clone(this.mask) : null,
      //mask: this.mask,
      amount: this.amount,
      speed: this.speed != null ? JSON.clone(this.speed) : null,
      //speed: this.speed,
    }
  }

  ///@param {Number} x
  ///@param {Number} y
  ///@param {?Number} [angle]
  ///@param {?Struct} [speed]
  serializeSpawn = function(x, y, angle = null, speed = null) {
    var _speed = this.speed != null ? JSON.clone(this.speed) : null
    //var _speed = this.speed
    return {
      name: this.name,
      category: this.category,
      sprite: this.sprite,
      useSpeed: this.useSpeed,
      changeSpeed: this.changeSpeed,
      mask: this.mask != null ? JSON.clone(this.mask) : null,
      //mask: this.mask,
      amount: this.amount,
      x: x,
      y: y,
      angle: angle != null ? angle : 90.0,
      speed: speed != null ? Struct.append(_speed, speed) : _speed,
    }
  }
}


///@param {Struct} config
function Coin(config) constructor {

  ///@type {Number}
  x = Struct.get(config, "x")

  ///@type {Number}
  y = Struct.get(config, "y")

  ///@type {Number}
  z = Struct.getDefault(config, "z", 0)

  ///@type {Sprite}
  sprite = SpriteUtil.parse(Struct.get(config, "sprite"), { name: "texture_missing" })

  ///@type {Rectangle}
  mask = Struct.get(config, "mask") != null
    ? new Rectangle(config.mask)
    : new Rectangle({
      x: 0,
      y: 0,
      width: this.sprite.getWidth(),
      height: this.sprite.getHeight()
  })

  ///@type {CoinCategory}
  category = Struct.get(config, "category")

  ///@type {Number}
  amount = Struct.getIfType(config, "amount", Number, 1)

  if (Struct.getIfType(config, "speed", Struct) != null) {
    if (!Struct.getIfType(config, "useSpeed", Boolean, false)) {
      Struct.set(config.speed, "value", -3.0)
    }

    if (!Struct.getIfType(config, "changeSpeed", Boolean, false)) {
      Struct.set(config.speed, "target", 1.0)
      Struct.set(config.speed, "factor", 0.1)
      Struct.set(config.speed, "increase", 0.0)
    }
  }

  ///@type {NumberTransformer}
  speed = new NumberTransformer(Struct.getIfType(config, "speed", Struct) != null
    ? config.speed
    : {
        value: -3.0,
        target: 1.0,
        duration: 0.6666667,
        ease: EaseType.LINEAR,
      })

  ///@type {Number}
  angle = Struct.getIfType(config, "angle", Number, 90.0)

  ///@private
  ///@type {Boolean}
  simpleAngle = this.angle == 90.0
  
  ///@private
  ///@type {Boolean}
  magnet = false

  ///@private
  ///@type {Number}
  magnetSpeed = 0.0

  ///@param {Player} target
  ///@return {Boolean}
  static collide = function(target) {
    gml_pragma("forceinline")
    var sourceX = this.x * GRID_SERVICE_PIXEL_WIDTH
    var sourceY = this.y * GRID_SERVICE_PIXEL_HEIGHT
    var targetX = target.x * GRID_SERVICE_PIXEL_WIDTH
    var targetY = target.y * GRID_SERVICE_PIXEL_HEIGHT
    return Math.ellipseOverlaps(
      sourceX - ((this.sprite.getWidth() * this.sprite.scaleX) / 2.0) + (this.mask.x * this.sprite.scaleX),
      sourceY - ((this.sprite.getHeight() * this.sprite.scaleY) / 2.0) + (this.mask.y * this.sprite.scaleY),
      this.mask.z * this.sprite.scaleX,
      this.mask.a * this.sprite.scaleY,
      targetX - ((target.sprite.getWidth() * target.sprite.scaleX) / 2.0) + (target.mask.x * target.sprite.scaleX),
      targetY - ((target.sprite.getHeight() * target.sprite.scaleY) / 2.0) + (target.mask.y * target.sprite.scaleY),
      target.mask.z * target.sprite.scaleX,
      target.mask.a * target.sprite.scaleY
    )
  }

  ///@param {?Player} player
  ///@return {Coin}
  static move = function(player = null) {
    gml_pragma("forceinline")
    var value = (this.speed.update().value / 100.0)
    if (player != null && Math.fetchLength(this.x, this.y, player.x, player.y) < 0.5) {
      var to = Math.fetchPointsAngle(this.x, this.y, player.x, player.y)
      this.magnet = true
      this.magnetSpeed = clamp(this.magnetSpeed + DELTA_TIME * 0.000004, 0.0, 0.008)
      //this.magnetSpeed = clamp(this.magnetSpeed + DeltaTime.apply(0.000004), 0.0, 0.008)
      this.speed.value = (abs(value) * 100.0)
      this.angle = Math.lerpAngle(this.angle, to, 0.12)
    } else {
      var dir = value < 0.0 ? 90.0 : 270.0
      this.magnetSpeed = clamp(this.magnetSpeed - DELTA_TIME * 0.0005, 0.0, 0.008)
      //this.magnetSpeed = clamp(this.magnetSpeed - DeltaTime.apply(0.0005), 0.0, 0.008)
      this.angle = this.simpleAngle && !this.magnet ? dir : Math.lerpAngle(this.angle, dir, 0.06)
    }

    value = DELTA_TIME * (abs(value) + this.magnetSpeed)
    //value = DeltaTime.apply(abs(value) + this.magnetSpeed)
    this.x += Math.fetchCircleX(value, this.angle)
    this.y += Math.fetchCircleY(value, this.angle)
    return this
  }
}