///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_bullet(json = null) {
  var template = {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "bullet_use-lifespan": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "lifespanMax"), Number),
      },
      "bullet_lifespan": {
        type: Number,
        value: Core.isType(Struct.get(json, "lifespanMax"), Number) ? json.lifespanMax : 15.0,
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 99.9)
        },
      },
      "bullet_use-damage": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "damage"), Number),
      },
      "bullet_damage": {
        type: Number,
        value: Struct.getIfType(json, "damage", Number, 1.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 999.9)
        },
      },
      "bullet_texture": {
        type: Sprite,
        value: SpriteUtil.parse(json.sprite, { name: "texture_bullet" }),
      },
      "use_bullet_mask": {
        type: Boolean,
        value: Optional.is(Struct.getIfType(json, "mask", Struct)),
      },
      "bullet_mask": {
        type: Rectangle,
        value: new Rectangle(Struct.getIfType(json, "mask", Struct)),
      },
      "bullet_use-wiggle": {
        type: Boolean,
        value: Struct.getIfType(json, "wiggle", Boolean, false),
      },
      "bullet_wiggle-time": {
        type: Number,
        value: Struct.getIfType(json, "wiggleTime", Number, 8.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 999.9)
        },
      },
      "bullet_use-wiggle-time-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "wiggleTimeRng", Boolean, false),
      },
      "bullet_wiggle-frequency": {
        type: Number,
        value: Struct.getIfType(json, "wiggleFrequency", Number, 8.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -99.9, 99.9)
        },
      },
      "bullet_use-wiggle-dir-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "wiggleDirRng", Boolean, false),
      },
      "bullet_wiggle-amplitude": {
        type: Number,
        value: Struct.getIfType(json, "wiggleAmplitude", Number, 5.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -99.9, 99.9)
        },
      },
      "bullet_use-angle-offset": {
        type: Boolean,
        value: Struct.getIfType(json, "useAngleOffset", Boolean, false),
      },
      "bullet_angle-offset": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getDefault(json, "angleOffset", {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.LINEAR,
        })),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(-360.0, 360.0),
      },
      "bullet_change-angle-offset": {
        type: Boolean,
        value: Struct.getIfType(json, "changeAngleOffset", Boolean, false),
      },
      "bullet_sum-angle-offset": {
        type: Boolean,
        value: Struct.getIfType(json, "sumAngleOffset", Boolean, false),
      },
      "bullet_use-angle-offset-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "angleOffsetRng", Boolean, false),
      },
      "bullet_use-speed-offset": {
        type: Boolean,
        value: Struct.getIfType(json, "useSpeedOffset", Boolean, false),
      },
      "bullet_speed-offset": {
        type: NumberTransformer,
        value: new NumberTransformer(Struct.getIfType(json, "speedOffset", Struct, { 
          value: 0.0, 
          target: 0.0,
          duration: 0.0,
          ease: EaseType.LINEAR,
        })),
      },
      "bullet_change-speed-offset": {
        type: Boolean,
        value: Struct.getIfType(json, "changeSpeedOffset", Boolean, false),
      },
      "bullet_sum-speed-offset": {
        type: Boolean,
        value: Struct.getIfType(json, "sumSpeedOffset", Boolean, false),
      },
      "bullet_use-on-death": {
        type: Boolean,
        value: Core.isType(Struct.get(json, "onDeath"), String),
      },
      "bullet_on-death": {
        type: String,
        value: Struct.getIfType(json, "onDeath", String, "bullet-default"),
        passthrough: function(value) {
          var bulletService = Beans.get(BeanVisuController).bulletService
          return bulletService.templates.contains(value) || Visu.assets().bulletTemplates.contains(value)
            ? value
            : (Core.isType(this.value, String) ? this.value : "bullet-default")
        },
      },
      "bullet_on-death-amount": {
        type: Number,
        value: Struct.getIfType(json, "onDeathAmount", Number, 1),
        passthrough: function(value) {
          return round(clamp(NumberUtil.parse(value, this.value), 0, 16))
        },
      },
      "bullet_on-death-angle": {
        type: Number,
        value: Struct.getIfType(json, "onDeathAngle", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -360.0, 360.0)
        },
      },
      "bullet_on-death-angle-rng": {
        type: Boolean,
        value: Struct.getIfType(json, "onDeathAngleRng", Boolean, false),
      },
      "bullet_on-death-angle-step": {
        type: Number,
        value: Struct.getIfType(json, "onDeathAngleStep", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), -360.0, 360.0)
        },
      },
      "bullet_on-death-angle-increase": {
        type: Number,
        value: Struct.getIfType(json, "onDeathAngleIncrease", Number, 1.0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(1.0, 99.9),
      },
      "bullet_on-death-rng-step": {
        type: Number,
        value: Struct.getIfType(json, "onDeathRngStep", Number, 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 360.0)
        },
      },
      "bullet_on-death-speed": {
        type: Number,
        value: Struct.getIfType(json, "onDeathSpeed", Number, 0.0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(-99.9, 99.9),
      },
      "bullet_on-death-speed-merge": {
        type: Boolean,
        value: Struct.getIfType(json, "onDeathSpeedMerge", Boolean, true),
      },
      "bullet_on-death-rng-speed": {
        type: Number,
        value: Struct.getIfType(json, "onDeathRngSpeed", Number, 0.0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 99.9),
      },
    }),
    components: new Array(Struct, [
      {
        name: "bullet_lifespan",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lifespan",
            enable: { key: "bullet_use-lifespan" },
          },  
          field: { 
            store: { key: "bullet_lifespan" },
            enable: { key: "bullet_use-lifespan" },
          },
          decrease: {
            store: { key: "bullet_lifespan" },
            enable: { key: "bullet_use-lifespan" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_lifespan" },
            enable: { key: "bullet_use-lifespan" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_lifespan" },
            enable: { key: "bullet_use-lifespan" },
            factor: 0.01,
          },
          checkbox: {
            store: { key: "bullet_use-lifespan" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
          },
          title: {
            text: "Override",
            enable: { key: "bullet_use-lifespan" },
          }
        },
      },
      {
        name: "bullet_damage",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Damage",
            enable: { key: "bullet_use-damage" },
          },  
          field: { 
            store: { key: "bullet_damage" },
            enable: { key: "bullet_use-damage" },
          },
          decrease: {
            store: { key: "bullet_damage" },
            enable: { key: "bullet_use-damage" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_damage" },
            enable: { key: "bullet_use-damage" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_damage" },
            enable: { key: "bullet_use-damage" },
            factor: 0.01,
          },
          checkbox: {
            store: { key: "bullet_use-damage" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
          },
          title: {
            text: "Override",
            enable: { key: "bullet_use-damage" },
          }
        },
      },
      {
        name: "bullet_damage-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_texture",
        template: VEComponents.get("texture-field-ext"),
        layout: VELayouts.get("texture-field-ext"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: {
              text: "Bullet texture",
              backgroundColor: VETheme.color.accentShadow,
            },
            input: { backgroundColor: VETheme.color.accentShadow },
            checkbox: { backgroundColor: VETheme.color.accentShadow },
          },
          texture: {
            label: { text: "Texture" }, 
            field: { store: { key: "bullet_texture" } },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "bullet_texture" },
          },
          resolution: {
            store: { key: "bullet_texture" },
          },
          alpha: {
            label: { text: "Alpha" },
            field: { store: { key: "bullet_texture" } },
            decrease: { store: { key: "bullet_texture" } },
            increase: { store: { key: "bullet_texture" } },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              snapValue: 0.01 / 1.0,
              store: { key: "bullet_texture" },
            },
          },
          frame: {
            label: { text: "Frame" },
            field: { store: { key: "bullet_texture" } },
            decrease: { store: { key: "bullet_texture" } },
            increase: { store: { key: "bullet_texture" } },
            checkbox: { 
              store: { key: "bullet_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Rng" }, 
            stick: { store: { key: "bullet_texture" } },
          },
          speed: {
            label: { text: "Speed" },
            field: { store: { key: "bullet_texture" } },
            decrease: { store: { key: "bullet_texture" } },
            increase: { store: { key: "bullet_texture" } },
            checkbox: { 
              store: { key: "bullet_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: { text: "Animate" }, 
            stick: { store: { key: "bullet_texture" } },
          },
          scaleX: {
            label: { text: "Scale X" },
            field: { store: { key: "bullet_texture" } },
            decrease: { store: { key: "bullet_texture" } },
            increase: { store: { key: "bullet_texture" } },
            stick: { store: { key: "bullet_texture" } },
          },
          scaleY: {
            label: { text: "Scale Y" },
            field: { store: { key: "bullet_texture" } },
            decrease: { store: { key: "bullet_texture" } },
            increase: { store: { key: "bullet_texture" } },
            stick: { store: { key: "bullet_texture" } },
          },
        },
      },
      {
        name: "bullet_texture-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_mask-property",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Collision mask",
            enable: { key: "use_bullet_mask" },
            backgroundColor: VETheme.color.side,
          },
          input: { backgroundColor: VETheme.color.side },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "use_bullet_mask" },
            backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "bullet_preview_mask",
        template: VEComponents.get("preview-image-mask"),
        layout: VELayouts.get("preview-image-mask"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          preview: {
            enable: { key: "use_bullet_mask" },
            image: { name: "texture_empty" },
            store: { key: "bullet_texture" },
            mask: "bullet_mask",
          },
          resolution: {
            enable: { key: "use_bullet_mask" },
            store: { key: "bullet_texture" },
          },
        },
      },
      {
        name: "bullet_mask",
        template: VEComponents.get("vec4-stick-increase"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          x: {
            label: {
              text: "X",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: { },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: { },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: { },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "use_bullet_mask" },
            },
            field: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "bullet_mask" },
              enable: { key: "use_bullet_mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: { },
          },
        },
      },
      {
        name: "bullet_mask-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_speed-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            enable: { key: "bullet_use-speed-offset" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "bullet_use-speed-offset" },
          },
          checkbox: { 

          },
        },
      },
      {
        name: "bullet_speed-offset",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            margin: { top: 4 },
          },
          value: {
            label: {
              text: "Value",
              enable: { key: "bullet_use-speed-offset" },
            },
            field: {
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
            },
            decrease: {
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
              factor: -1.0,
            },
            increase: {
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
              factor: 1.0,        
            },
            stick: {
              store: { key: "bullet_speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
              factor: 0.001,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "bullet_sum-speed-offset" },
              enable: { key: "bullet_use-speed-offset" },
            },
            title: { 
              text: "Sum",
              enable: { key: "bullet_sum-speed-offset" },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            field: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            decrease: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              factor: -1.0,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            increase: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              factor: 1.0,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            stick: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              factor: 0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),     
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              enable: { key: "bullet_use-speed-offset" },
              store: { key: "bullet_change-speed-offset" },
            },
            title: { 
              text: "Change",
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
          },
          duration: {
            label: {
              text: "Duration",
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            field: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            decrease: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              factor: -0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            increase: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              factor: 0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            stick: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              factor: 0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),     
            },
          },
          ease: {
            label: {
              text: "Ease",
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            previous: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            preview: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            next: {
              store: { key: "bullet_speed-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-speed-offset" },
                  { key: "bullet_change-speed-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
          },
        },
      },
      {
        name: "bullet_speed-offset-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_angle-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Angle",
            enable: { key: "bullet_use-angle-offset" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "bullet_use-angle-offset" },
          },
          checkbox: { 

          },
        },
      },
      {
        name: "bullet_angle-offset",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              enable: { key: "bullet_use-angle-offset" },
            },
            field: {
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
            },
            decrease: {
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
              factor: -0.25,
            },
            increase: {
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
              factor: 0.25,        
            },
            stick: {
              store: { key: "bullet_angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
              factor: 0.001,        
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "bullet_sum-angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
            },
            title: { 
              text: "Sum",
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_sum-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            field: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            decrease: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              factor: -0.25,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            increase: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              factor: 0.25,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            stick: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              factor: 0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),     
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "bullet_change-angle-offset" },
              enable: { key: "bullet_use-angle-offset" },
            },
            title: { 
              text: "Change",
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
          },
          duration: {
            label: {
              text: "Duration",
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            field: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            decrease: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              factor: -0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            increase: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              factor: 0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            stick: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              factor: 0.001,
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),     
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "bullet_use-angle-offset-rng" },
              enable: { key: "bullet_use-angle-offset" },
            },
            title: { 
              text: "Rand. dir.",
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_use-angle-offset-rng" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
          },
          ease: {
            label: {
              text: "Ease",
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            previous: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            preview: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
            next: {
              store: { key: "bullet_angle-offset" },
              enable: { 
                keys: [
                  { key: "bullet_use-angle-offset" },
                  { key: "bullet_change-angle-offset" }
                ],
              },
              updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
            },
          },
        },
      },
      {
        name: "bullet_angle-offset-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_angle-wiggle-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Wiggle",
            enable: { key: "bullet_use-wiggle" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "bullet_use-wiggle" },
          },
          checkbox: { 
            
          },
        },
      },
      {
        name: "bullet_wiggle-time",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Theta",
            enable: { key: "bullet_use-wiggle" },
          },  
          field: { 
            store: { key: "bullet_wiggle-time" },
            enable: { key: "bullet_use-wiggle" },
          },
          decrease: {
            store: { key: "bullet_wiggle-time" },
            enable: { key: "bullet_use-wiggle" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_wiggle-time" },
            enable: { key: "bullet_use-wiggle" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_wiggle-time" },
            enable: { key: "bullet_use-wiggle" },
            factor: 0.01,
          },
          checkbox: {
            store: { key: "bullet_use-wiggle-time-rng" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            enable: { key: "bullet_use-wiggle" },
          },
          title: {
            text: "Randomize",
            enable: { 
              keys: [
                { key: "bullet_use-wiggle" },
                { key: "bullet_use-wiggle-time-rng" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
          }
        },
      },
      {
        name: "bullet_wiggle-frequency",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Frequency",
            enable: { key: "bullet_use-wiggle" },
          },  
          field: { 
            store: { key: "bullet_wiggle-frequency" },
            enable: { key: "bullet_use-wiggle" },
          },
          decrease: {
            store: { key: "bullet_wiggle-frequency" },
            enable: { key: "bullet_use-wiggle" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_wiggle-frequency" },
            enable: { key: "bullet_use-wiggle" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_wiggle-frequency" },
            enable: { key: "bullet_use-wiggle" },
            factor: 0.01,
          },
          checkbox: {
            store: { key: "bullet_use-wiggle-dir-rng" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            enable: { key: "bullet_use-wiggle" },
          },
          title: {
            text: "Rand. dir.",
            enable: { 
              keys: [
                { key: "bullet_use-wiggle" },
                { key: "bullet_use-wiggle-dir-rng" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
          },
        },
      },
      {
        name: "bullet_wiggle-amplitude",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Amplitude",
            enable: { key: "bullet_use-wiggle" },
          },  
          field: { 
            store: { key: "bullet_wiggle-amplitude" },
            enable: { key: "bullet_use-wiggle" },
          },
          decrease: {
            store: { key: "bullet_wiggle-amplitude" },
            enable: { key: "bullet_use-wiggle" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_wiggle-amplitude" },
            enable: { key: "bullet_use-wiggle" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_wiggle-amplitude" },
            enable: { key: "bullet_use-wiggle" },
            factor: 0.01,
          },
          checkbox: { },
        },
      },
      {
        name: "bullet_wiggle-amplitude-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_use-on-death",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Spawn bullet on death",
            backgroundColor: VETheme.color.accentShadow,
            enable: { key: "bullet_use-on-death" },
          },
          input: { backgroundColor: VETheme.color.accentShadow },
          checkbox: { 
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "bullet_use-on-death" },
          },
        },
      },
      {
        name: "bullet_on-death",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 4, bottom: 2 },
          },
          label: { 
            text: "Bullet",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death" },
            enable: { key: "bullet_use-on-death" },
          },
        },
      },
      {
        name: "bullet_on-death-amount",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Amount",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-amount" },
            enable: { key: "bullet_use-on-death" },
            GMTF_DECIMAL: 0,
          },
          decrease: {
            store: { key: "bullet_on-death-amount" },
            enable: { key: "bullet_use-on-death" },
            factor: -1.0,
          },
          increase: {
            store: { key: "bullet_on-death-amount" },
            enable: { key: "bullet_use-on-death" },
            factor: 1.0,
          },
          stick: {
            store: { key: "bullet_on-death-amount" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.2,
          },
          checkbox: {
            store: { key: "bullet_on-death-angle-rng" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            enable: { key: "bullet_use-on-death" },
          },
          title: {
            text: "Rand. dir.",
            enable: { 
              keys: [
                { key: "bullet_use-on-death" },
                { key: "bullet_on-death-angle-rng" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
          },
        },
      },
      {
        name: "bullet_on-detah-amount-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_on-death-angle",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Angle",
            font: "font_inter_10_bold",
            color: VETheme.color.textShadow,
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-angle" },
            enable: { key: "bullet_use-on-death" },
          },
          decrease: {
            store: { key: "bullet_on-death-angle" },
            enable: { key: "bullet_use-on-death" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_on-death-angle" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_on-death-angle" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.66,
          },
          checkbox: { },
        },
      },
      {
        name: "bullet_on-death-angle-step",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Step",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-angle-step" },
            enable: { key: "bullet_use-on-death" },
          },
          decrease: {
            store: { key: "bullet_on-death-angle-step" },
            enable: { key: "bullet_use-on-death" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_on-death-angle-step" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_on-death-angle-step" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.1,
          },
          checkbox: { },
          title: {
            store: { key: "bullet_on-death-angle" },
            enable: { key: "bullet_use-on-death" },
            render: function() {
              if (Optional.is(this.preRender)) {
                this.preRender()
              }
              this.renderBackgroundColor()

              if (!Optional.is(this.store) || this.store.getStore() == null) {
                return
              }

              var store = this.store.getStore()
              var amount = store.getValue("bullet_on-death-amount")
              var angle = store.getValue("bullet_on-death-angle")
              var rng = store.getValue("bullet_on-death-angle-rng")
              var step = store.getValue("bullet_on-death-angle-step")
              var increase = store.getValue("bullet_on-death-angle-increase")

              var sprite = Struct.get(this, "sprite")
              if (!Core.isType(sprite, Sprite)) {
                sprite = SpriteUtil.parse({ name: "visu_texture_ui_angle_arrow" })
                Struct.set(this, "sprite", sprite)
              }

              var _alpha = sprite.getAlpha()
              var alpha = _alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0)
              var blend = sprite.getBlend()
              var blendRight = ColorUtil.parse(VETheme.color.textFocus).toGMColor()
              var blendLeft = ColorUtil.parse(VETheme.color.primaryLight).toGMColor()
              var _x = this.context.area.getX() + this.area.getX() + this.margin.left + this.margin.right + 2.0,
              var _y = this.context.area.getY() + this.area.getY() - this.margin.top

              sprite
                .setAlpha(alpha)
                .scaleToFit(this.area.getHeight() * 2, this.area.getHeight() * 2)

              for (var index = amount - 1; index > 0; index--) {
                sprite
                  .setAngle(angle - (index * step * Math.pow(increase, index - 1)))
                  .setAlpha((((amount - index) / amount) * (alpha * 0.5)) + (alpha * 0.25))
                  .setBlend(blendRight)
                  .render(_x, _y)
            
                if (!rng) {
                  continue
                }

                sprite
                  .setAngle(angle + (index * step * Math.pow(increase, index - 1)))
                  .setAlpha((((amount - index) / amount) * (alpha * 0.5)) + (alpha * 0.25))
                  .setBlend(blendLeft)
                  .render(_x, _y)
              }

              sprite.setAngle(angle).setAlpha(alpha).setBlend(blend).render(_x, _y).setAlpha(_alpha)
              return this
            },
          },
        },
      },
      {
        name: "bullet_on-death-angle-increase",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Increase",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-angle-increase" },
            enable: { key: "bullet_use-on-death" },
          },
          decrease: {
            store: { key: "bullet_on-death-angle-increase" },
            enable: { key: "bullet_use-on-death" },
            factor: -0.01,
          },
          increase: {
            store: { key: "bullet_on-death-angle-increase" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.01,
          },
          stick: {
            store: { key: "bullet_on-death-angle-increase" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.01,
            step: 10,
            treshold: 64,
          },
          checkbox: {
            store: { key: "bullet_on-death-angle-rng" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            enable: { key: "bullet_use-on-death" },
          },
          title: {
            text: "Rand. dir.",
            enable: { 
              keys: [
                { key: "bullet_use-on-death" },
                { key: "bullet_on-death-angle-rng" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
          },
        },
      },
      {
        name: "bullet_on-detah-angle-step-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { layout: { type: UILayoutType.VERTICAL } },
      },
      {
        name: "bullet_on-death-speed",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Speed",
            font: "font_inter_10_bold",
            color: VETheme.color.textShadow,
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-speed" },
            enable: { key: "bullet_use-on-death" },
          },
          decrease: {
            store: { key: "bullet_on-death-speed" },
            enable: { key: "bullet_use-on-death" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_on-death-speed" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_on-death-speed" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.01,
          },
          checkbox: {
            store: { key: "bullet_on-death-speed-merge" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            enable: { key: "bullet_use-on-death" },
          },
          title: {
            text: "Merge",
            enable: { 
              keys: [
                { key: "bullet_use-on-death" },
                { key: "bullet_on-death-speed-merge" }
              ],
            },
            updateEnable: Callable.run(UIItemUtils.templates.get("updateEnableKeys")),
          }
        },
      },
      {
        name: "bullet_on-death-rng-speed",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Randomize",
            enable: { key: "bullet_use-on-death" },
          },  
          field: { 
            store: { key: "bullet_on-death-rng-speed" },
            enable: { key: "bullet_use-on-death" },
          },
          decrease: {
            store: { key: "bullet_on-death-rng-speed" },
            enable: { key: "bullet_use-on-death" },
            factor: -0.1,
          },
          increase: {
            store: { key: "bullet_on-death-rng-speed" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.1,
          },
          stick: {
            store: { key: "bullet_on-death-rng-speed" },
            enable: { key: "bullet_use-on-death" },
            factor: 0.01,
          },
          checkbox: { },
        }
      },
    ]),
  }

  return template
}
