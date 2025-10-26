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

  ///@type {?GenericTransformer}
  scaleX = Struct.get(data, "scaleX") != null
    ? new GenericTransformer({
      onValue: Struct.get(data.scaleX, "onValue"),
      onTarget: Struct.get(data.scaleX, "onTarget"),
      transform: Struct.get(data.scaleX, "transform"),
      increase: Struct.get(data.scaleX, "increase"),
      get: function(item, controller) {
        return item.sprite.scaleX
      },
      set: function(item, controller, value) {
        item.sprite.setScaleX(value)
      },
    })
    : null

  ///@type {?GenericTransformer}
  scaleY = Struct.get(data, "scaleY") != null
    ? new GenericTransformer({
      onValue: Struct.get(data.scaleY, "onValue"),
      onTarget: Struct.get(data.scaleY, "onTarget"),
      transform: Struct.get(data.scaleY, "transform"),
      increase: Struct.get(data.scaleY, "increase"),
      get: function(item, controller) {
        return item.sprite.scaleY
      },
      set: function(item, controller, value) {
        item.sprite.setScaleY(value)
      },
    })
    : null

  ///@type {?GenericTransformer}
  angle = Struct.get(data, "angle") != null
    ? new GenericTransformer({
      onValue: Struct.get(data.angle, "onValue"),
      onTarget: Struct.get(data.angle, "onTarget"),
      transform: Struct.get(data.angle, "transform"),
      increase: Struct.get(data.angle, "increase"),
      get: function(item, controller) {
        return item.sprite.angle
      },
      set: function(item, controller, value) {
        item.sprite.setAngle(value)
      },
    })
    : null
    
  ///@type {?GenericTransformer}
  alpha = Struct.get(data, "alpha") != null
    ? new GenericTransformer({
      onValue: Struct.get(data.alpha, "onValue"),
      onTarget: Struct.get(data.alpha, "onTarget"),
      transform: Struct.get(data.alpha, "transform"),
      increase: Struct.get(data.alpha, "increase"),
      get: function(item, controller) {
        return item.sprite.alpha
      },
      set: function(item, controller, value) {
        item.sprite.setAlpha(value)
      },
    })
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
      this.scaleX.update(item, controller)
    }

    if (this.scaleY != null) {
      this.scaleY.update(item, controller)
    }

    if (this.angle != null) {
      this.angle.update(item, controller)
    }

    if (this.alpha != null) {
      this.alpha.update(item, controller)
    }
  }
}


///@param {Struct} json
function DeprecatedSpriteFeature(json): GridItemFeature(json) constructor {
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
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.add, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.add, "ease")), String, EaseType.LEGACY), // todo migrate
        })
        : null),
      transform: (Core.isType(Struct.get(data.scaleX, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "increase")), Number, 0.0),
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleX.transform, "ease")), String, EaseType.LEGACY), // todo migrate
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
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.add, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.add, "ease")), String, EaseType.LEGACY), // todo migrate
        })
        : null),
      transform: (Core.isType(Struct.get(data.scaleX, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "increase")), Number, 0.0),
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.scaleY.transform, "ease")), String, EaseType.LEGACY), // todo migrate
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
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.add, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.add, "ease")), String, EaseType.LEGACY), // todo migrate
        })
        : null),
      transform: (Core.isType(Struct.get(data.angle, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "increase")), Number, 0.0),
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.angle.transform, "ease")), String, EaseType.LEGACY), // todo migrate
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
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.add, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.add, "ease")), String, EaseType.LEGACY), // todo migrate
        })
        : null),
      transform: (Core.isType(Struct.get(data.alpha, "transform"), Struct)
        ? new NumberTransformer({
          value: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "value")), Number, 0.0),
          factor: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "factor")), Number, 1.0),
          target: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "target")), Number, 1.0),
          increase: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "increase")), Number, 0.0),
          duration: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "duration")), Number, 0.0),
          ease: Core.getIfType(GMArray.resolveRandom(Struct.get(data.alpha.transform, "ease")), String, EaseType.LEGACY), // todo migrate
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
