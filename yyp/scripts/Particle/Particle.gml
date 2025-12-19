///@package io.alkapivo.core.service.particle

#macro GMParticle "GMParticle"


///@enum
function _ParticleShape(): Enum() constructor {
  PIXEL = pt_shape_pixel
  DISK = pt_shape_disk	
  SQUARE = pt_shape_square	
  LINE = pt_shape_line	
  STAR = pt_shape_star	
  CIRCLE = pt_shape_circle	
  RING = pt_shape_ring	
  SPHERE = pt_shape_sphere	
  FLARE = pt_shape_flare	
  SPARK = pt_shape_spark	
  EXPLOSION = pt_shape_explosion	
  CLOUD = pt_shape_cloud	
  SMOKE = pt_shape_smoke	
  SNOW = pt_shape_snow
}
global.__ParticleShape = new _ParticleShape()
#macro ParticleShape global.__ParticleShape


///@param {?Struct} [json]
function ParticlePropertyNumeric(json = null) constructor {

  ///@type {Number}
  minValue = Struct.getIfType(json, "minValue", Number, 0.0)

  ///@type {Number}
  maxValue = Struct.getIfType(json, "maxValue", Number, 0.0)
}


///@param {?Struct} [json]
function ParticlePropertyNumericTransform(json = null): ParticlePropertyNumeric(json) constructor {

  ///@type {Number}
  increase = Struct.getIfType(json, "increase", Number, 0.0)

  ///@type {Number}
  wiggle = Struct.getIfType(json, "wiggle", Number, 0.0)
}


///@param {?Struct} [json]
function ParticlePropertyOrientation(json = null): ParticlePropertyNumericTransform(json) constructor {

  ///@type {Boolean}
  relative = Struct.getIfType(json, "relative", Boolean, false)
}


///@param {?Struct} [json]
function ParticlePropertyColor(json = null) constructor {

  ///@type {GMColor}
  start = ColorUtil.parse(Struct.get(json, "start")).toGMColor()

  ///@type {GMColor}
  halfway = ColorUtil.parse(Struct.get(json, "halfway")).toGMColor()

  ///@type {GMColor}
  finish = ColorUtil.parse(Struct.get(json, "finish")).toGMColor()
}


///@param {?Struct} [json]
function ParticlePropertyAlpha(json = null) constructor {

  ///@type {Number}
  start = Struct.getIfType(json, "start", Number, 0.0)

  ///@type {Number}
  halfway = Struct.getIfType(json, "halfway", Number, 0.0)

  ///@type {Number}
  finish = Struct.getIfType(json, "finish", Number, 0.0)
}


///@param {?Struct} [json]
function ParticlePropertyGravity(json = null) constructor {

  ///@type {Number}
  amount = Struct.getIfType(json, "amount", Number, 0.0)

  ///@type {Number}
  angle = Struct.getIfType(json, "angle", Number, 0.0)
}


///@param {Struct} json
function ParticlePropertySprite(json) constructor {

  ///@type {Texture}
  texture = Assert.isType(TextureUtil.parse(Struct.get(json, "name")), Texture)
  
  ///@type {Boolean}
  animate = Struct.getIfType(json, "animate", Boolean, false)

  ///@type {Boolean}
  stretch = Struct.getIfType(json, "stretch", Boolean, false)

  ///@type {Boolean}
  randomValue = Struct.getIfType(json, "randomValue", Boolean, false)
}


///@param {String} _name
///@param {Struct} json
function ParticleTemplate(_name, json) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {String}
  shape = Struct.getIfType(json, "shape", String, "CIRCLE")

  ///@type {Struct}
  size = Struct.appendRecursiveUnique(
    Struct.get(json, "size"),
    {
      wiggle: 0.0,
      increase: 0.0,
      minValue: 1.0,
      maxValue: 1.0,
    },
    false
  )

  ///@type {Struct}
  scale = Struct.appendRecursiveUnique(
    Struct.get(json, "scale"),
    {
      x: 1.0,
      y: 1.0,
    },
    false
  )

  ///@type {Struct}
  orientation = Struct.appendRecursiveUnique(
    Struct.get(json, "orientation"),
    {
      relative: 0.0,
      wiggle: 0.0,
      increase: 0.0,
      minValue: 0.0,
      maxValue: 0.0,
    },
    false
  )

  ///@type {Struct}
  color = Struct.appendRecursiveUnique(
    Struct.get(json, "color"),
    {
      start: "#ffffff",
      halfway: "#ffffff",
      finish: "#ffffff",
    },
    false
  )

  ///@type {Struct}
  alpha = Struct.appendRecursiveUnique(
    Struct.get(json, "alpha"),
    {
      start: 0.0,
      halfway: 1.0,
      finish: 0.0,
    },
    false
  )

  ///@type {Boolean}
  blend = Struct.getIfType(json, "blend", Boolean, false)

  ///@type {Struct}
  life = Struct.appendRecursiveUnique(
    Struct.get(json, "life"),
    {
      minValue: 0.0,
      maxValue: 100.0,
    },
    false
  )

  ///@type {Struct}
  speed = Struct.appendRecursiveUnique(
    Struct.get(json, "speed"),
    {
      wiggle: 0.0,
      increase: 0.0,
      minValue: 0.0,
      maxValue: 0.0,
    },
    false
  )

  ///@type {Struct}
  angle = Struct.appendRecursiveUnique(
    Struct.get(json, "angle"),
    {
      wiggle: 0.0,
      increase: 0.0,
      minValue: 0.0,
      maxValue: 0.0,
    },
    false
  )

  ///@type {Struct}
  gravity = Struct.appendRecursiveUnique(
    Struct.get(json, "gravity"),
    {
      angle: 0.0,
      amount: 0.0,
    },
    false
  )

  ///@type {?Struct}
  sprite = Core.isType(Struct.get(json, "sprite"), Struct) ? json.sprite : null

  ///@type {?Particle}
  particle = null

  ///@type {?Struct}
  emitter = Struct.getIfType(json, "emitter", Struct)

  ///@return {Struct}
  serialize = function() {
    var json = {
      shape: this.shape,
      size: {
        wiggle: this.size.wiggle,
        increase: this.size.increase,
        minValue: this.size.minValue,
        maxValue: this.size.maxValue,
      },
      scale: {
        x: this.scale.x,
        y: this.scale.y,
      },
      orientation: {
        relative: this.orientation.relative,
        wiggle: this.orientation.wiggle,
        increase: this.orientation.increase,
        minValue: this.orientation.minValue,
        maxValue: this.orientation.maxValue,
      },
      color: {
        start: this.color.start,
        halfway: this.color.halfway,
        finish: this.color.finish,
      },
      alpha: {
        start: this.alpha.start,
        halfway: this.alpha.halfway,
        finish: this.alpha.finish,
      },
      blend: this.blend,
      life: {
        minValue: this.life.minValue,
        maxValue: this.life.maxValue,
      },
      speed: {
        wiggle: this.speed.wiggle,
        increase: this.speed.increase,
        minValue: this.speed.minValue,
        maxValue: this.speed.maxValue,
      },
      angle: {
        wiggle: this.angle.wiggle,
        increase: this.angle.increase,
        minValue: this.angle.minValue,
        maxValue: this.angle.maxValue,
      },
      gravity: {
        angle: this.gravity.angle,
        amount: this.gravity.amount,
      },
      particle: null,
    }

    if (this.sprite != null) {
      Struct.set(json, "sprite", this.sprite)
    }

    if (this.emitter != null) {
      Struct.set(json, "emitter", this.emitter)
    }

    return json
  }

  ///@return {ParticleTemplate}
  free = function() {
    if (this.particle != null) {
      this.particle.free()
    }

    this.particle = null
    return this
  }
}


///@param {Struct|ParticleTemplate} json
function Particle(json) constructor {

  ///@type {String}
  name = Assert.isType(Struct.get(json, "name"), String)

  ///@type {ParticleShape}
  shape = Assert.isEnum(ParticleShape.get(Struct.getIfType(json, "shape", String, "CIRCLE")), ParticleShape)

  ///@type {ParticlePropertyNumeric}
  size = new ParticlePropertyNumericTransform(Struct.get(json, "size"))

  ///@type {Vector2}
  scale = Vector.parse(Struct.get(json, "scale"), Vector2)

  ///@type {ParticlePropertyOrientation}
  orientation = new ParticlePropertyOrientation(Struct.get(json, "orientation"))

  ///@type {ParticlePropertyColor}
  color = new ParticlePropertyColor(Struct.get(json, "color"))

  ///@type {ParticlePropertyAlpha}
  alpha = new ParticlePropertyAlpha(Struct.get(json, "alpha")) 

  ///@type {Boolean}
  blend = Struct.getIfType(json, "blend", Boolean, false)

  ///@type {ParticlePropertyNumeric}
  life = new ParticlePropertyNumeric(Struct.get(json, "life"))

  ///@type {ParticlePropertyNumericTransform}
  speed = new ParticlePropertyNumericTransform(Struct.get(json, "speed"))

  ///@type {ParticlePropertyNumericTransform}
  angle = new ParticlePropertyNumericTransform(Struct.get(json, "angle"))

  ///@type {Struct}
  gravity = new ParticlePropertyGravity(Struct.get(json, "gravity"))

  ///@type {?ParticlePropertySprite}
  sprite = Core.isType(Struct.get(json, "sprite"), Struct)
    ? new ParticlePropertySprite(json.sprite)
    : null

  ///@type {?GMParticle}
  asset = part_type_create()
  
  part_type_shape(this.asset, this.shape);
	part_type_size(this.asset, this.size.minValue, this.size.maxValue, this.size.increase, this.size.wiggle)
	part_type_scale(this.asset, this.scale.x, this.scale.y)
	part_type_orientation(this.asset, this.orientation.minValue, this.orientation.maxValue, this.orientation.increase, this.orientation.wiggle, this.orientation.relative)
	part_type_color3(this.asset, this.color.start, this.color.halfway, this.color.finish)
	part_type_alpha3(this.asset, this.alpha.start, this.alpha.halfway, this.alpha.finish)
	part_type_blend(this.asset, this.blend)
	part_type_life(this.asset, this.life.minValue, this.life.maxValue)
	part_type_speed(this.asset, this.speed.minValue, this.speed.maxValue, this.speed.increase, this.speed.wiggle)
	part_type_direction(this.asset, this.angle.minValue, this.angle.maxValue, this.angle.increase, this.angle.wiggle)
	part_type_gravity(this.asset, this.gravity.amount, this.gravity.angle)
  if (Core.isType(this.sprite, ParticlePropertySprite)) {
	  part_type_sprite(this.asset, this.sprite.texture.asset, this.sprite.animate, this.sprite.stretch, this.sprite.randomValue)
  }
  
  ///@return {Particle}
  free = function() {
    if (this.asset != null && part_type_exists(this.asset)) {
      part_type_destroy(this.asset)
    }

    return this
  }
}
