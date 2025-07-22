///@package io.alkapivo.visu.editor.api.template

///@param {Struct} json
///@return {Struct}
function template_shroom(json) {
  var use_shroom_lifespan = Struct.get(json, "use_shroom_lifespan")
  if (use_shroom_lifespan == null) {
    use_shroom_lifespan = Struct.getIfType(json, "lifespanMax", Number) != null
  }

  var use_shroom_healthPoints = Struct.get(json, "use_shroom_healthPoints")
  if (use_shroom_healthPoints == null) {
    use_shroom_healthPoints = Struct.getIfType(json, "use_shroom_healthPoints", Boolean) != null
  }

  var use_shroom_mask = Struct.get(json, "use_shroom_mask")
  if (use_shroom_mask == null) {
    use_shroom_mask = Struct.getIfType(json, "mask", Struct) != null
  }
  return {
    name: Assert.isType(json.name, String),
    store: new Map(String, Struct, {
      "use_shroom_lifespan": {
        type: Boolean,
        value: Struct.getIfType(json, "use_shroom_lifespan", Boolean, false),
      },
      "shroom_lifespan": {
        type: Number,
        value: Struct.getIfType(json, "lifespanMax", Number, 15.0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "use_shroom_healthPoints": {
        type: Boolean,
        value: Struct.getIfType(json, "use_shroom_healthPoints", Boolean, false),
      },
      "shroom_health-points": {
        type: Number,
        value: Struct.getIfType(json, "healthPoints", Number, 1.0),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 9999.9),
      },
      "shroom_texture": {
        type: Sprite,
        value: SpriteUtil.parse(json.sprite, { name: "texture_missing" }),
      },
      "use_shroom_mask": {
        type: Boolean,
        value: Struct.getIfType(json, "use_shroom_mask", Boolean, false),
      },
      "shroom_mask": {
        type: Rectangle,
        value: new Rectangle(Struct.getIfType(json, "mask", Struct)),
      },
      "shroom_inherit": {
        type: String,
        value: JSON.stringify(Struct.getIfType(json, "inherit", GMArray, []), { pretty: true }),
        serialize: UIUtil.serialize.getStringGMArray(),
        passthrough: UIUtil.passthrough.getStringGMArray(),
      },
      "use_shroom_inherit": {
        type: Boolean,
        value: Struct.getIfType(json, "use_shroom_inherit", Boolean, true),
      },
      "shroom_game-mode_bullet-hell_features": {
        type: String,
        value: JSON.stringify(Struct.getIfType(json.gameModes.bulletHell, "features", GMArray, []), { pretty: true }),
        serialize: UIUtil.serialize.getStringGMArray(),
        passthrough: UIUtil.passthrough.getStringGMArray(),
      },
      "use_shroom_features": {
        type: Boolean,
        value: Struct.getIfType(json, "use_shroom_features", Boolean, true),
      },
      "shroom_game-mode_platformer_features": {
        type: String,
        value: JSON.stringify(Struct.getIfType(json.gameModes.platformer, "features", GMArray, []), { pretty: true }),
        serialize: UIUtil.serialize.getStringGMArray(),
        passthrough: UIUtil.passthrough.getStringGMArray(),
      },
      "shroom_game-mode_racing_features": {
        type: String,
        value: JSON.stringify(Struct.getIfType(json.gameModes.racing, "features", GMArray, []), { pretty: true }),
        serialize: UIUtil.serialize.getStringGMArray(),
        passthrough: UIUtil.passthrough.getStringGMArray(),
      },
      "shroom_hide": {
        type: Boolean,
        value: Struct.getIfType(json, "shroom_hide", Boolean, false),
      },
      "shroom_hide_texture": {
        type: Boolean,
        value: Struct.getIfType(json, "shroom_hide_texture", Boolean, false),
      },
      "shroom_hide_mask": {
        type: Boolean,
        value: Struct.getIfType(json, "shroom_hide_mask", Boolean, false),
      },
      "shroom_hide_inherit": {
        type: Boolean,
        value: Struct.getIfType(json, "shroom_hide_inherit", Boolean, false),
      },
      "shroom_hide_features": {
        type: Boolean,
        value: Struct.getIfType(json, "shroom_hide_features", Boolean, false),
      },
    }),
    components: new Array(Struct, [
      {
        name: "shroom_hide",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "shroom_hide" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "shroom_lifespan",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Lifespan",
            enable: { key: "use_shroom_lifespan" },
            hidden: { key: "shroom_hide" },
          },  
          field: { 
            store: { key: "shroom_lifespan" },
            enable: { key: "use_shroom_lifespan" },
            hidden: { key: "shroom_hide" },
          },
          decrease: {
            store: { key: "shroom_lifespan" },
            enable: { key: "use_shroom_lifespan" },
            hidden: { key: "shroom_hide" },
            factor: -0.1,
          },
          increase: {
            store: { key: "shroom_lifespan" },
            enable: { key: "use_shroom_lifespan" },
            hidden: { key: "shroom_hide" },
            factor: 0.1,
          },
          stick: {
            store: { key: "shroom_lifespan" },
            enable: { key: "use_shroom_lifespan" },
            hidden: { key: "shroom_hide" },
            factor: 0.1,
          },
          checkbox: {
            store: { key: "use_shroom_lifespan" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            hidden: { key: "shroom_hide" },
          },
          title: {
            text: "Override",
            enable: { key: "use_shroom_lifespan" },
            hidden: { key: "shroom_hide" },
          }
        },
      },
      {
        name: "shroom_health-points",
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Health",
            enable: { key: "use_shroom_healthPoints" },
            hidden: { key: "shroom_hide" },
          },  
          field: { 
            store: { key: "shroom_health-points" },
            enable: { key: "use_shroom_healthPoints" },
            hidden: { key: "shroom_hide" },
          },
          decrease: {
            store: { key: "shroom_health-points" },
            enable: { key: "use_shroom_healthPoints" },
            hidden: { key: "shroom_hide" },
            factor: -0.1,
          },
          increase: {
            store: { key: "shroom_health-points" },
            enable: { key: "use_shroom_healthPoints" },
            hidden: { key: "shroom_hide" },
            factor: 0.1,
          },
          stick: {
            store: { key: "shroom_health-points" },
            enable: { key: "use_shroom_healthPoints" },
            hidden: { key: "shroom_hide" },
            factor: 0.1,
          },
          checkbox: {
            store: { key: "use_shroom_healthPoints" },
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            hidden: { key: "shroom_hide" },
          },
          title: {
            text: "Override",
            enable: { key: "use_shroom_healthPoints" },
            hidden: { key: "shroom_hide" },
          }
        },
      },
      {
        name: "shroom_health-points-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "shroom_hide" } },
        },
      },
      {
        name: "en-shr_texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Texture",
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "shroom_hide_texture" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "shroom_texture",
        template: VEComponents.get("texture-field-ext"),
        layout: VELayouts.get("texture-field-ext"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          texture: {
            label: {
              text: "Texture",
              hidden: { key: "shroom_hide_texture" },
            }, 
            field: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "shroom_texture" },
            hidden: { key: "shroom_hide_texture" },
          },
          resolution: {
            store: { key: "shroom_texture" },
            hidden: { key: "shroom_hide_texture" },
          },
          alpha: {
            label: {
              text: "Alpha",
              hidden: { key: "shroom_hide_texture" },
            },
            field: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            decrease: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            increase: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              snapValue: 0.01 / 1.0,
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
          },
          frame: {
            label: {
              text: "Frame",
              hidden: { key: "shroom_hide_texture" },
            },
            field: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            decrease: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            increase: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            checkbox: { 
              store: { key: "shroom_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: { key: "shroom_hide_texture" },
            },
            title: {
              text: "Rng" ,
              hidden: { key: "shroom_hide_texture" },
            }, 
            stick: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
          },
          speed: {
            label: {
              text: "Speed",
              hidden: { key: "shroom_hide_texture" },
            },
            field: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            decrease: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            increase: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            checkbox: { 
              store: { key: "shroom_texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              hidden: { key: "shroom_hide_texture" },
            },
            title: {
              text: "Animate",
              hidden: { key: "shroom_hide_texture" },
            },
            stick: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
          },
          scaleX: {
            label: {
              text: "Scale X",
              hidden: { key: "shroom_hide_texture" },
            },
            field: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            decrease: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            increase: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            stick: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            hidden: {
              key: "shroom_hide_texture",
              hidden: { key: "shroom_hide_texture" },
            },
          },
          scaleY: {
            label: {
              text: "Scale Y",
              hidden: { key: "shroom_hide_texture" },
            },
            field: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            decrease: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            increase: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            stick: {
              store: { key: "shroom_texture" },
              hidden: { key: "shroom_hide_texture" },
            },
            hidden: {
              key: "shroom_hide_texture",
              hidden: { key: "shroom_hide_texture" },
            },
          },
        },
      },
      {
        name: "shroom_texture-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "shroom_hide_texture" } },
        },
      },
      {
        name: "shroom_mask-property",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Collision mask",
            enable: { key: "use_shroom_mask" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "shroom_hide_mask" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "use_shroom_mask" },
          },
        },
      },
      {
        name: "shroom_preview_mask",
        template: VEComponents.get("preview-image-mask"),
        layout: VELayouts.get("preview-image-mask"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          preview: {
            enable: { key: "use_shroom_mask" },
            image: { name: "texture_empty" },
            store: { key: "shroom_texture" },
            hidden: { key: "shroom_hide_mask" },
            mask: "shroom_mask",
          },
          resolution: {
            enable: { key: "use_shroom_mask" },
            store: { key: "shroom_texture" },
            hidden: { key: "shroom_hide_mask" },
          },
        },
      },
      {
        name: "shroom_mask",
        template: VEComponents.get("vec4-stick-increase"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          x: {
            label: {
              text: "X",
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
              treshold: 32768,
            },
            checkbox: { hidden: { key: "shroom_hide_mask" } },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
              treshold: 32768,
            },
            checkbox: { hidden: { key: "shroom_hide_mask" } },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
              treshold: 32768,
            },
            checkbox: { hidden: { key: "shroom_hide_mask" } },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
            },
            field: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "shroom_mask" },
              enable: { key: "use_shroom_mask" },
              hidden: { key: "shroom_hide_mask" },
              factor: 1.0,
              treshold: 32768,
            },
            checkbox: { hidden: { key: "shroom_hide_mask" } },
          },
        },
      },
      {
        name: "shroom_mask-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "shroom_hide_mask" } },
        },
      },
      {
        name: "shroom_inherit-title",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Inherit",
            enable: { key: "use_shroom_inherit" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "shroom_hide_inherit" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "use_shroom_inherit" },
          },
        },
      },
      {
        name: "shroom_inherit",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            store: { key: "shroom_inherit" },
            enable: { key: "use_shroom_inherit" },
            hidden: { key: "shroom_hide_inherit" },
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
            v_grow: true,
            w_min: 570,
          },
        },
      },
      {
        name: "shroom_inherit-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "shroom_hide_inherit" } },
        },
      },
      {
        name: "shroom_game-mode_bullet-hell",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Features",
            enable: { key: "use_shroom_features" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "shroom_hide_features" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "use_shroom_features" },
          },
        },
      },
      {
        name: "shroom_game-mode_bullet-hell_features",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            store: { key: "shroom_game-mode_bullet-hell_features" },
            enable: { key: "use_shroom_features" },
            hidden: { key: "shroom_hide_features" },
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
            v_grow: true,
            w_min: 570,
          },
        },
      },
      {
        name: "shroom_game-mode_bullet-hell_features-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            //margin: { top: 0, bottom: 0 },
            //height: function() { return 0 },
          },
          image: { 
            //hidden: { key: "shroom_hide_inherit" },
            hidden: { key: "shroom_hide_features" },
            //backgroundAlpha: 0.0,
          },
        },
      },
      /*
      {
        name: "shroom_game-mode_platformer",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Platformer" },
        },
      },
      {
        name: "shroom_game-mode_platformer_features",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "shroom_game-mode_platformer_features" },
          },
        },
      },
      {
        name: "shroom_game-mode_racing",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Racing" },
        },
      },
      {
        name: "shroom_game-mode_racing_features",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "shroom_game-mode_racing_features" },
          },
        },
      },
      */
    ]),
  }
}