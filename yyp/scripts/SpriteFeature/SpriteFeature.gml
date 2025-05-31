///@package io.alkapivo.visu.service.grid.feature

///@param {Struct} json
function SpriteFeature(json): GridItemFeature(json) constructor {
  var data = Struct.get(json, "data")

  ///@override
  ///@type {String}
  type = "SpriteFeature"

  var _sprite = Struct.getIfType(data, "sprite", Struct)
  ///@type {?Sprite}
  sprite = _sprite != null
    ? Assert.isType(SpriteUtil.parse({
      name: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "name")), String, "texture_missing"),
      frame: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "frame")), Number, 0.0),
      speed: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "speed")), Number, 1.0),
      scaleX: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "scaleX")), Number, 1.0),
      scaleY: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "scaleY")), Number, 1.0),
      alpha: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "alpha")), Number, 1.0),
      angle: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "angle")), Number, 0.0),
      blend: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "blend")), String, "#ffffff"),
      animate: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "animate")), Boolean, true),
      randomFrame: Core.getIfType(GMArray.resolveRandom(Struct.get(_sprite, "randomFrame")), Boolean, false),
    }), Sprite, "sprite must be type of Struct")
    : null

  var _mask = Struct.getIfType(data, "mask", Struct)
  ///@type {?Rectangle}
  mask = _mask != null
    ? new Rectangle({
      x: Core.getIfType(GMArray.resolveRandom(Struct.get(_mask, "x")), Number, 0.0),
      y: Core.getIfType(GMArray.resolveRandom(Struct.get(_mask, "y")), Number, 0.0),
      width: Core.getIfType(GMArray.resolveRandom(Struct.get(_mask, "width")), Number, 0.0),
      height: Core.getIfType(GMArray.resolveRandom(Struct.get(_mask, "height")), Number, 0.0),
    })
    : null

  ///@type {?Struct}
  scaleX = Core.isType(Struct.get(data, "scaleX"), Struct)
    ? {
      add: (Core.isType(Struct.get(data.scaleX, "add"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.add, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.add, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.add, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.add, "increase")), Number, 0.0),
        })
        : null),
      transform: (Core.isType(Struct.get(data.scaleX, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "increase")), Number, 0.0),
        })
        : null),
      initialized: false,
    }
    : null

  ///@type {?Struct}
  scaleY = Core.isType(Struct.get(data, "scaleY"), Struct)
    ? {
      add: (Core.isType(Struct.get(data.scaleY, "add"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.add, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.add, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.add, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.add, "increase")), Number, 0.0),
        })
        : null),
      transform: (Core.isType(Struct.get(data.scaleX, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "increase")), Number, 0.0),
        })
        : null),
      initialized: false,
    }
    : null
  
  ///@type {?Struct}
  angle = Core.isType(Struct.get(data, "angle"), Struct)
    ? {
      add: (Core.isType(Struct.get(data.angle, "add"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.add, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.add, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.add, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.add, "increase")), Number, 0.0),
        })
        : null),
      transform: (Core.isType(Struct.get(data.angle, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "increase")), Number, 0.0),
        })
        : null),
      initialized: false,
    }
    : null

  ///@type {?Struct}
  alpha = Core.isType(Struct.get(data, "alpha"), Struct)
    ? {
      add: (Core.isType(Struct.get(data.alpha, "add"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.add, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.add, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.add, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.add, "increase")), Number, 0.0),
        })
        : null),
      transform: (Core.isType(Struct.get(data.alpha, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "increase")), Number, 0.0),
        })
        : null),
      initialized: false,
    }
    : null

  ///@override
  ///@param {GridItem} item
  ///@param {VisuController} controller
  static update = function(item, controller) {
    if (this.sprite != null) {
      item.setSprite(this.sprite)
    }

    if (this.mask != null) {
      item.setMask(this.mask)
    }

    if (this.scaleX != null) {
      if (this.scaleX.transform != null) {
        if (!this.scaleX.initialized) {
          this.scaleX.transform.value = item.sprite.scaleX
          this.scaleX.transform.startValue = item.sprite.scaleX
          this.scaleX.initialized = true
        }
        item.sprite.setScaleX(this.scaleX.transform.update().value)
      }
    
      if (this.scaleX.add != null) {
        item.sprite.setScaleX(item.sprite.scaleX + this.scaleX.add.update().value)
      }
    }

    if (this.scaleY != null) {
      if (this.scaleY.transform != null) {
        if (!this.scaleY.initialized) {
          this.scaleY.transform.value = item.sprite.scaleY
          this.scaleY.transform.startValue = item.sprite.scaleY 
          this.scaleY.initialized = true
        }
        item.sprite.setScaleY(this.scaleY.transform.update().value)
      }
    
      if (this.scaleY.add != null) {
        item.sprite.setScaleY(item.sprite.scaleY + this.scaleY.add.update().value)
      }
    }

    if (this.angle != null) {
      if (this.angle.transform != null) {
        if (!this.angle.initialized) {
          this.angle.initialized = true
          this.angle.transform.startValue = item.sprite.angle
          this.angle.transform.target = item.angle + ((this.angle.transform.factor >= 0 ? 1 : -1) * Math.fetchPointsAngleDiff(this.angle.transform.target, item.sprite.angle))
          this.angle.transform.startFactor = abs(this.angle.transform.factor)
          this.angle.transform.reset()
        }
        item.sprite.setAngle(this.angle.transform.update().value)
      }

      if (this.angle.add != null) {
        item.sprite.setAngle(item.sprite.angle + this.angle.add.update().value)
      }
    }

    if (this.alpha != null) {
      if (this.alpha.transform != null) {
        if (!this.alpha.initialized) {
          this.alpha.transform.startValue = item.sprite.alpha
          this.alpha.transform.reset()
          this.alpha.initialized = true
        }
        item.sprite.setAlpha(this.alpha.transform.update().value)
      }
    
      if (this.alpha.add != null) {
        item.sprite.setAlpha(item.sprite.alpha + this.alpha.add.update().value)
      }
    }
  }
}


///@param {Struct} json
///@return {GridItemFeature}
function _SpriteFeature(json) {
  var data = Struct.map(Assert.isType(Struct
    .getDefault(json, "data", {}), Struct), GMArray
    .resolveRandom)

  if (Struct.contains(data, "scaleX")) {
    var scaleX = data.scaleX
    if (Struct.contains(scaleX, "transform")) {
      scaleX.transform = Struct.map(scaleX.transform, GMArray.resolveRandom)
    }
  
    if (Struct.contains(scaleX, "add")) {
      scaleX.add = Struct.map(scaleX.add, GMArray.resolveRandom)
    }
  }

  if (Struct.contains(data, "scaleY")) {
    var scaleY = data.scaleY
    if (Struct.contains(scaleY, "transform")) {
      scaleY.transform = Struct.map(scaleY.transform, GMArray.resolveRandom)
    }
  
    if (Struct.contains(scaleY, "add")) {
      scaleY.add = Struct.map(scaleY.add, GMArray.resolveRandom)
    }
  }

  if (Struct.contains(data, "angle")) {
    var angle = data.angle
    if (Struct.contains(angle, "transform")) {
      angle.transform = Struct.map(angle.transform, GMArray.resolveRandom)
    }
  
    if (Struct.contains(angle, "add")) {
      angle.add = Struct.map(angle.add, GMArray.resolveRandom)
    }
  }

  if (Struct.contains(data, "alpha")) {
    var alpha = data.alpha
    if (Struct.contains(alpha, "transform")) {
      alpha.transform = Struct.map(alpha.transform, GMArray.resolveRandom)
    }
  
    if (Struct.contains(alpha, "add")) {
      alpha.add = Struct.map(alpha.add, GMArray.resolveRandom)
    }
  }

  var sprite = Core.isType(Struct.get(data, "sprite"), Struct) 
    ? Assert.isType(SpriteUtil.parse(data.sprite), Sprite) 
    : null
  
  return new GridItemFeature(Struct.append(json, {

    ///@param {Callable}
    type: SpriteFeature,

    ///@type {?Sprite}
    sprite: sprite,

    ///@type {?Rectangle}
    mask: Core.isType(Struct.get(data, "mask"), Struct)
      ? new Rectangle(data.mask)
      : null,

    ///@type {?Struct}
    scaleX: Core.isType(Struct.get(data, "scaleX"), Struct)
      ? {
        add: Core.isType(Struct.get(data.scaleX, "add"), Struct)
          ? new NumberTransformer({
            value: 0.0,
            factor: Struct.getDefault(data.scaleX.add, "factor", 1.0),
            target: Struct.getDefault(data.scaleX.add, "target", 1.0),
            increase: Struct.getDefault(data.scaleX.add, "increase", 0.0),
          })
          : null,
        transform: Core.isType(Struct.get(data.scaleX, "transform"), Struct)
          ? new NumberTransformer(data.scaleX.transform)
          : null,
        initialized: false,
      }
      : null,

    ///@type {?Struct}
    scaleY: Core.isType(Struct.get(data, "scaleY"), Struct)
      ? {
        add: Core.isType(Struct.get(data.scaleY, "add"), Struct)
          ? new NumberTransformer({
            value: 0.0,
            factor: Struct.getDefault(data.scaleY.add, "factor", 1.0),
            target: Struct.getDefault(data.scaleY.add, "target", 1.0),
            increase: Struct.getDefault(data.scaleY.add, "increase", 0.0),
          })
          : null,
        transform: Core.isType(Struct.get(data.scaleY, "transform"), Struct)
          ? new NumberTransformer(data.scaleY.transform)
          : null,
        initialized: false,
      }
      : null,

      
    ///@type {?Struct}
    angle: Core.isType(Struct.get(data, "angle"), Struct)
      ? {
        add: Core.isType(Struct.get(data.angle, "add"), Struct)
          ? new NumberTransformer({
            value: 0.0,
            factor: Struct.getDefault(data.angle.add, "factor", 1.0),
            target: Struct.getDefault(data.angle.add, "target", 1.0),
            increase: Struct.getDefault(data.angle.add, "increase", 0.0),
          })
          : null,
        transform: Core.isType(Struct.get(data.angle, "transform"), Struct)
          ? new NumberTransformer(data.angle.transform)
          : null,
        initialized: false,
      }
      : null,

    ///@type {?Struct}
    alpha: Core.isType(Struct.get(data, "alpha"), Struct)
      ? {
        add: Core.isType(Struct.get(data.alpha, "add"), Struct)
          ? new NumberTransformer({
            value: 0.0,
            factor: Struct.getDefault(data.alpha.add, "factor", 1.0),
            target: Struct.getDefault(data.alpha.add, "target", 1.0),
            increase: Struct.getDefault(data.alpha.add, "increase", 0.0),
          })
          : null,
        transform: Core.isType(Struct.get(data.alpha, "transform"), Struct)
          ? new NumberTransformer(data.alpha.transform)
          : null,
        initialized: false,
      }
      : null,

    ///@override
    ///@param {GridItem} item
    ///@param {VisuController} controller
    update: function(item, controller) {
      if (this.sprite != null) {
        item.setSprite(this.sprite)
      }

      if (this.mask != null) {
        item.setMask(this.mask)
      }

      if (this.scaleX != null) {
        if (this.scaleX.transform != null) {
          if (!this.scaleX.initialized) {
            this.scaleX.transform.value = item.sprite.scaleX
            this.scaleX.transform.startValue = item.sprite.scaleX
            this.scaleX.initialized = true
          }
          item.sprite.setScaleX(this.scaleX.transform.update().value)
        }
      
        if (this.scaleX.add != null) {
          item.sprite.setScaleX(item.sprite.scaleX + this.scaleX.add.update().value)
        }
      }

      if (this.scaleY != null) {
        if (this.scaleY.transform != null) {
          if (!this.scaleY.initialized) {
            this.scaleY.transform.value = item.sprite.scaleY
            this.scaleY.transform.startValue = item.sprite.scaleY 
            this.scaleY.initialized = true
          }
          item.sprite.setScaleY(this.scaleY.transform.update().value)
        }
      
        if (this.scaleY.add != null) {
          item.sprite.setScaleY(item.sprite.scaleY + this.scaleY.add.update().value)
        }
      }

      if (this.angle != null) {
        if (this.angle.transform != null) {
          if (!this.angle.initialized) {
            this.angle.initialized = true
            this.angle.transform.startValue = item.sprite.angle
            this.angle.transform.target = item.angle + ((this.angle.transform.factor >= 0 ? 1 : -1) * Math.fetchPointsAngleDiff(this.angle.transform.target, item.sprite.angle))
            this.angle.transform.startFactor = abs(this.angle.transform.factor)
            this.angle.transform.reset()
          }
          item.sprite.setAngle(this.angle.transform.update().value)
        }
  
        if (this.angle.add != null) {
          item.sprite.setAngle(item.sprite.angle + this.angle.add.update().value)
        }
      }

      if (this.alpha != null) {
        if (this.alpha.transform != null) {
          if (!this.alpha.initialized) {
            this.alpha.transform.startValue = item.sprite.alpha
            this.alpha.transform.reset()
            this.alpha.initialized = true
          }
          item.sprite.setAlpha(this.alpha.transform.update().value)
        }
      
        if (this.alpha.add != null) {
          item.sprite.setAlpha(item.sprite.alpha + this.alpha.add.update().value)
        }
      }
    },
  }))
}