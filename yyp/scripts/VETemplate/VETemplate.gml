///@package io.alkapivo.visu.editor.api.tilemap_get_cell_x_at_pixel

///@enum
function _VETemplateType(): Enum() constructor {
  SHADER = "template_shader"
  SHROOM = "template_shroom"
  BULLET = "template_bullet"
  COIN = "template_coin"
  SUBTITLE = "template_subtitle"
  PARTICLE = "template_particle"
  TEXTURE = "template_texture"
}
global.__VETemplateType = new _VETemplateType()
#macro VETemplateType global.__VETemplateType


///@static
///@type {Map<VETemplateType, String>}
global.__VETemplateTypeNames = new Map(String, String)
  .set(VETemplateType.SHADER, "Shader template")
  .set(VETemplateType.SHROOM, "Shroom template")
  .set(VETemplateType.BULLET, "Bullet template")
  .set(VETemplateType.COIN, "Coin template")
  .set(VETemplateType.SUBTITLE, "Subtitle template")
  .set(VETemplateType.PARTICLE, "Particle template")
  .set(VETemplateType.TEXTURE, "Texture template")
#macro VETemplateTypeNames global.__VETemplateTypeNames


///@param {Struct} json
function VETemplate(json) constructor {

  ///@private
  ///@param {VETemplateType} type
  ///@param {Struct} json
  ///@throws {Exception}
  ///@return {Struct}
  static parseStoreConfig = function(type, json) {
    var storeConfig = {
      "template-name": {
        type: String,
        value: json.name,
      },
      "template-hide": {
        type: Boolean,
        value: Struct.parse.boolean(json, "hide"),
      },
    }

    if (type == VETemplateType.SHADER) {
      storeConfig = Struct.append(storeConfig, {
        "template-shader-asset": {
          type: String,
          value: json.shader,   
        },
        "template-inherit": {
          type: Optional.of(String),
          value: Struct.getDefault(json, "inherit", null),
        },
      })
    }

    return storeConfig
  }

  ///@type {VETemplateType}
  type = Assert.isEnum(json.type, VETemplateType)

  ///@type {Store}
  store = new Store(this.parseStoreConfig(this.type, json))

  ///@type {Array<Struct>}
  components = new Array(Struct, [ 
    {
      name: "template-type",
      template: VEComponents.get("property"),
      layout: VELayouts.get("property"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        label: { text: $"{VETemplateTypeNames.get(json.type)}" },
        //label: { text: "Properties" },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "template-hide" },
        },
        input: { },
      },
    },
    {
      name: "template-name",
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { 
          type: UILayoutType.VERTICAL,
          margin: { top: 2 },
        },
        label: {
          text: "Name",
          hidden: { key: "template-hide" },
        },
        field: { 
          read_only: json.type == VETemplateType.TEXTURE,
          store: { key: "template-name" },
          hidden: { key: "template-hide" },
        },
      },
    },
    {
      name: "template_start-line-h",
      template: VEComponents.get("line-h"),
      layout: VELayouts.get("line-h"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        image: { hidden: { key: "template-hide" } },
      },
    },
  ])

  ///@private
  ///@return {ShaderTemplate}
  toShaderTemplate = function() {
    var json = {
      name: Assert.isType(this.store.getValue("template-name"), String, "Store item 'template-name' must be type of String"),
      shader: Assert.isType(this.store.getValue("template-shader-asset"), String, "Store item 'template-shader' must be type of String"),
      type: Assert.isEnum(this.type, VETemplateType, "JSON template 'type' must be type of VETemplateType"),
    }

    var inherit = this.store.getValue("template-inherit")
    if (Core.isType(inherit, String)) {
      Struct.set(json, "inherit", inherit)
    }

    var properties = this.store.container
      .filter(function(item) {
        return item.name != "template-name" 
          && item.name != "template-shader-asset" 
          && item.name != "template-inherit" 
          && item.name != "template-hide"
      })
      .toStruct(function(item) { 
        return item.serialize()
      })
    
    if (Struct.size(properties) > 0) {
      Struct.set(json, "properties", properties)
    }
    return new ShaderTemplate(json.name, json)
  }

  ///@private
  ///@return {ShroomTemplate}
  toShroomTemplate = function() {
    var sprite = this.store.getValue("shroom_texture")
    var json = {
      name: Assert.isType(this.store.getValue("template-name"), String),
      sprite: sprite.serialize(),
      mask: this.store.getValue("shroom_mask").serialize(),
      lifespanMax: this.store.getValue("shroom_lifespan"),
      healthPoints: this.store.getValue("shroom_health-points"),
      inherit: JSON.parse(this.store.getValue("shroom_inherit")).getContainer(),
      onDamage: JSON.parse(this.store.getValue("shroom_on_damage")).getContainer(),
      onDeath: JSON.parse(this.store.getValue("shroom_on_death")).getContainer(),
      queue: JSON.parse(this.store.getValue("shroom_queue")).getContainer(),
      features: JSON.parse(this.store.getValue("shroom_features")).getContainer(),
      use_shroom_mask: this.store.getValue("use_shroom_mask"),
      use_shroom_lifespan: this.store.getValue("use_shroom_lifespan"),
      use_shroom_healthPoints: this.store.getValue("use_shroom_healthPoints"),
      use_shroom_inherit: this.store.getValue("use_shroom_inherit"),
      use_shroom_features: this.store.getValue("use_shroom_features"),
      use_shroom_queue: this.store.getValue("use_shroom_queue"),
      use_shroom_on_death: this.store.getValue("use_shroom_on_death"),
      use_shroom_on_damage: this.store.getValue("use_shroom_on_damage"),
      shroom_hide: this.store.getValue("shroom_hide"),
      shroom_hide_texture: this.store.getValue("shroom_hide_texture"),
      shroom_hide_mask: this.store.getValue("shroom_hide_mask"),
      shroom_hide_inherit: this.store.getValue("shroom_hide_inherit"),
      shroom_hide_features: this.store.getValue("shroom_hide_features"),
      shroom_hide_queue: this.store.getValue("shroom_hide_queue"),
      shroom_hide_on_damage: this.store.getValue("shroom_hide_on_damage"),
      shroom_hide_on_death: this.store.getValue("shroom_hide_on_death"),
    }
    return new ShroomTemplate(json.name, json)
  }

  ///@private
  ///@return {ShroomTemplate}
  toBulletTemplate = function() {
    var sprite = this.store.getValue("bullet_texture")
    var json = {
      name: Assert.isType(this.store.getValue("template-name"), String),
      lifespanMax: this.store.getValue("bullet_use-lifespan")
        ? this.store.getValue("bullet_lifespan")
        : null,
      damage: this.store.getValue("bullet_use-damage")
        ? this.store.getValue("bullet_damage")
        : null,
      sprite: sprite.serialize(),
      wiggle: this.store.getValue("bullet_use-wiggle"),
      wiggleTime: this.store.getValue("bullet_use-wiggle")
        ? this.store.getValue("bullet_wiggle-time")
        : null,
      wiggleTimeRng: this.store.getValue("bullet_use-wiggle")
        ? this.store.getValue("bullet_use-wiggle-time-rng")
        : null,
      wiggleFrequency: this.store.getValue("bullet_use-wiggle")
        ? this.store.getValue("bullet_wiggle-frequency")
        : null,
      wiggleDirRng: this.store.getValue("bullet_use-wiggle")
        ? this.store.getValue("bullet_use-wiggle-dir-rng")
        : null,
      wiggleAmplitude: this.store.getValue("bullet_use-wiggle")
        ? this.store.getValue("bullet_wiggle-amplitude")
        : null,
      useAngleOffset: this.store.getValue("bullet_use-angle-offset"),
      changeAngleOffset: this.store.getValue("bullet_change-angle-offset"),
      angleOffset: this.store.getValue("bullet_angle-offset").serialize(),
      sumAngleOffset: this.store.getValue("bullet_sum-angle-offset"),
      angleOffsetRng: this.store.getValue("bullet_use-angle-offset-rng"),
      useSpeedOffset: this.store.getValue("bullet_use-speed-offset"),
      changeSpeedOffset: this.store.getValue("bullet_change-speed-offset"),
      speedOffset: this.store.getValue("bullet_speed-offset").serialize(),
      sumSpeedOffset: this.store.getValue("bullet_sum-speed-offset"),
      onDeath: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death")
        : null,
      onDeathAmount: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-amount")
        : null,
      onDeathAngle: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-angle")
        : null,
      onDeathAngleRng: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-angle-rng")
        : null,
      onDeathAngleStep: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-angle-step")
        : null,
      onDeathAngleIncrease: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-angle-increase")
        : null,
      onDeathRngStep: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-rng-step")
        : null,
      onDeathSpeed: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-speed")
        : null,
      onDeathSpeedMerge: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-speed-merge")
        : null,
      onDeathRngSpeed: this.store.getValue("bullet_use-on-death")
        ? this.store.getValue("bullet_on-death-rng-speed")
        : null,
    }

    if (this.store.getValue("use_bullet_mask")) {
      Struct.set(json, "mask", this.store.getValue("bullet_mask").serialize())
    }

    return new BulletTemplate(json.name, json)
  }

  ///@private
  ///@return {CoinTemplate}
  toCoinTemplate = function() {
    var sprite = this.store.getValue("coin_sprite")
    var json = {
      name: Assert.isType(this.store.getValue("template-name"), String),
      category: Assert.isEnum(this.store.getValue("coin_category"), CoinCategory),
      sprite: sprite.serialize(),
      useSpeed: this.store.getValue("coin_use-speed"),
      speed: this.store.getValue("coin_speed").serialize(),
      changeSpeed: this.store.getValue("coin_change-speed"),
    }

    if (this.store.getValue("coin_use-mask")) {
      Struct.set(json, "mask", this.store
        .getValue("coin_mask").serialize())
    }

    if (this.store.getValue("coin_use-amount")) {
      Struct.set(json, "amount", Assert.isType(this.store
        .getValue("coin_amount"), Number))
    }

    return new CoinTemplate(json.name, json)
  }

  ///@private
  ///@return {SubtitleTemplate}
  toSubtitleTemplate = function() {
    var store = this.store
    return new SubtitleTemplate(
      store.getValue("template-name"), 
      { lines: String.split(store.getValue("lines"), "\n").getContainer() }
    )
  }

  ///@private
  ///@return {ParticleTemplate}
  toParticleTemplate = function() {
    var template = new ParticleTemplate(
      this.store.getValue("template-name"), 
      JSON.clone(this.store.getValue("particle-template").serialize())
    )

    template.blend = this.store.getValue("particle-blend")
    template.color.start = this.store.getValue("particle-color-start").toHex()
    template.color.halfway = this.store.getValue("particle-color-halfway").toHex()
    template.color.finish = this.store.getValue("particle-color-finish").toHex()
    if (this.store.getValue("particle-use-sprite")) {
      var sprite = this.store.getValue("particle-sprite")
      Struct.set(template, "sprite", {
        name: sprite.getName(),
        animate: sprite.getAnimate(),
        randomValue: sprite.getRandomFrame(),
        stretch: this.store.getValue("particle-sprite-stretch"),
      })
    } else {
      Struct.set(template, "sprite", null)
    }
    
    return template
  }

  ///@private
  ///@return {TextureTemplate}
  toTextureTemplate = function() {
    var template = this.store.getValue("texture-template")
    return new TextureTemplate(template.name, template)
  }

  ///@throws {Exception}
  ///@return {ShaderTemplate|ShroomTemplate|BulletTemplate|CoinTemplate|SubtitleTemplate|ParticleTemplate|TextureTemplate}
  serialize = function() {
    switch (this.type) {
      case VETemplateType.SHADER: return this.toShaderTemplate()
      case VETemplateType.SHROOM: return this.toShroomTemplate()
      case VETemplateType.BULLET: return this.toBulletTemplate()
      case VETemplateType.COIN: return this.toCoinTemplate()
      case VETemplateType.SUBTITLE: return this.toSubtitleTemplate()
      case VETemplateType.PARTICLE: return this.toParticleTemplate()
      case VETemplateType.TEXTURE: return this.toTextureTemplate()
      default: throw new Exception($"Serialize dispatcher for type '{this.type}' wasn't found")
    }
  }

  ///@description append data
  var data = Assert.isType(Callable.run(this.type, json), Struct)
  data.store.forEach(function(json, name, store) {
    store.add(new StoreItem(name, json))
  }, this.store)
  data.components.forEach(function(component, index, components) {
    components.add(component)
  }, this.components)
  //this.components.add({
  //  name: "template_end-line-h",
  //  template: VEComponents.get("line-h"),
  //  layout: VELayouts.get("line-h"),
  //  config: { layout: { type: UILayoutType.VERTICAL } },
  //})
}