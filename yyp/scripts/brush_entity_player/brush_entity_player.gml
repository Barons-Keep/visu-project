///@package io.alkapivo.visu.editor.service.brush.entity

///@param {?Struct} [json]
///@return {Struct}
function brush_entity_player(json = null) {
  return {
    name: "brush_entity_player",
    store: new Map(String, Struct, {
      "en-pl_texture": {
        type: Sprite,
        value: Struct.get(json, "en-pl_texture"),
      },
      "en-pl_use-mask": {
        type: Boolean,
        value: Struct.get(json, "en-pl_use-mask"),
      },
      "en-pl_mask": {
        type: Rectangle,
        value: Struct.get(json, "en-pl_mask"),
      },
      "en-pl_reset-pos": {
        type: Boolean,
        value: Struct.get(json, "en-pl_reset-pos"),
      },
      "en-pl_use-stats": {
        type: Boolean,
        value: Struct.get(json, "en-pl_use-stats"),
      },
      "en-pl_stats": {
        type: String,
        value: JSON.stringify(Struct.get(json, "en-pl_stats"), { pretty: true }),
        serialize: UIUtil.serialize.getStringStruct(),
        passthrough: UIUtil.passthrough.getStringStruct(),
      },
      "en-pl_use-bullethell": {
        type: Boolean,
        value: Struct.get(json, "en-pl_use-bullethell"),
      },
      "en-pl_bullethell": {
        type: String,
        value: JSON.stringify(Struct.get(json, "en-pl_bullethell"), { pretty: true }),
        serialize: UIUtil.serialize.getStringStruct(),
        passthrough: UIUtil.passthrough.getStringStruct(),
      },
      "en-pl_use-platformer": {
        type: Boolean,
        value: Struct.get(json, "en-pl_use-platformer"),
      },
      "en-pl_platformer": {
        type: String,
        value: JSON.stringify(Struct.get(json, "en-pl_platformer"), { pretty: true }),
        serialize: UIUtil.serialize.getStringStruct(),
        passthrough: UIUtil.passthrough.getStringStruct(),
      },
      "en-pl_use-racing": {
        type: Boolean,
        value: Struct.get(json, "en-pl_use-racing"),
      },
      "en-pl_racing": {
        type: String,
        value: JSON.stringify(Struct.get(json, "en-pl_racing"), { pretty: true }),
        serialize: UIUtil.serialize.getStringStruct(),
        passthrough: UIUtil.passthrough.getStringStruct(),
      },
      "en-pl_hide": {
        type: Boolean,
        value: Struct.get(json, "en-pl_hide"),
      },
      "en-pl_hide-texture": {
        type: Boolean,
        value: Struct.get(json, "en-pl_hide-texture"),
      },
      "en-pl_hide-mask": {
        type: Boolean,
        value: Struct.get(json, "en-pl_hide-mask"),
      },
      "en-pl_hide-stats": {
        type: Boolean,
        value: Struct.get(json, "en-pl_hide-stats"),
      },
      "en-pl_hide-cfg": {
        type: Boolean,
        value: Struct.get(json, "en-pl_hide-cfg"),
      },
    }),
    components: new Array(Struct, [
      {
        name: "en-pl_hide",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Properties",
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            store: { key: "en-pl_hide" },
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
          },
        },
      },
      {
        name: "en-pl_reset-pos",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Reset spawn point",
            enable: { key: "en-pl_reset-pos" },
            hidden: { key: "en-pl_hide" },
            backgroundColor: VETheme.color.side,
          },
          input: {
            backgroundColor: VETheme.color.side,
            hidden: { key: "en-pl_hide" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_reset-pos" },
            hidden: { key: "en-pl_hide" },
            backgroundColor: VETheme.color.side,
          },
        },
      },
      {
        name: "en-pl_reset-pos-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-pl_hide" } },
        },
      },
      {
        name: "en-pl_hide-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Texture",
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            store: { key: "en-pl_hide-texture" },
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
          },
        },
      },
      {
        name: "en-pl_texture",
        template: VEComponents.get("texture-field-ext"),
        layout: VELayouts.get("texture-field-ext"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          texture: {
            label: {
              text: "Name",
              hidden: { key: "en-pl_hide-texture" },
           }, 
            field: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
           },
          },
          preview: {
            image: { name: "texture_empty" },
            store: { key: "en-pl_texture" },
            hidden: { key: "en-pl_hide-texture" },
          },
          resolution: {
            store: { key: "en-pl_texture" },
            hidden: { key: "en-pl_hide-texture" },
          },
          alpha: {
            label: {
              text: "Alpha",
              hidden: { key: "en-pl_hide-texture" },
            },
            field: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            decrease: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            increase: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              snapValue: 0.01 / 1.0,
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
          },
          frame: {
            label: {
              text: "Frame",
              hidden: { key: "en-pl_hide-texture" },
            },
            field: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            decrease: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            increase: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            checkbox: { 
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            title: {
              text: "Random",
              hidden: { key: "en-pl_hide-texture" },
            }, 
            stick: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
          },
          speed: {
            label: {
              text: "Speed",
              hidden: { key: "en-pl_hide-texture" },
            },
            field: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            decrease: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            increase: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            checkbox: { 
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
            },
            stick: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
          },
          scaleX: {
            label: {
              text: "Scale X",
              hidden: { key: "en-pl_hide-texture" },
            },
            field: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            decrease: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            increase: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            stick: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
          },
          scaleY: {
            label: {
              text: "Scale Y",
              hidden: { key: "en-pl_hide-texture" },
            },
            field: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            decrease: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            increase: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
            stick: {
              store: { key: "en-pl_texture" },
              hidden: { key: "en-pl_hide-texture" },
            },
          },
        },
      },
      {
        name: "en-pl-texture-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-pl_hide-texture" } },
        },
      },
      {
        name: "en-pl_hide-mask",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Collision",
            enable: { key: "en-pl_use-mask" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-pl_use-mask" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            store: { key: "en-pl_hide-mask" },
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
          },
        },
      },
      {
        name: "en-pl_preview_mask",
        template: VEComponents.get("preview-image-mask"),
        layout: VELayouts.get("preview-image-mask"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          preview: {
            enable: { key: "en-pl_use-mask" },
            image: { name: "texture_empty" },
            store: { key: "en-pl_texture" },
            mask: "en-pl_mask",
            hidden: { key: "en-pl_hide-mask" },
          },
          resolution: {
            enable: { key: "en-pl_use-mask" },
            store: { key: "en-pl_texture" },
            hidden: { key: "en-pl_hide-mask" },
          },
        },
      },
      {
        name: "en-pl_mask",
        template: VEComponents.get("vec4-stick-increase"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: {
            type: UILayoutType.VERTICAL
          },
          x: {
            label: {
              text: "X",
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: {
              hidden: { key: "en-pl_hide-mask" },
            },
          },
          y: {
            label: {
              text: "Y",
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: {
              hidden: { key: "en-pl_hide-mask" },
            },
          },
          z: {
            label: {
              text: "Width",
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: {
              hidden: { key: "en-pl_hide-mask" },
            },
          },
          a: {
            label: {
              text: "Height",
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
            },
            field: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              GMTF_DECIMAL: 0,
            },
            decrease: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: -1.0,
            },
            increase: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
            },
            stick: {
              store: { key: "en-pl_mask" },
              enable: { key: "en-pl_use-mask" },
              hidden: { key: "en-pl_hide-mask" },
              factor: 1.0,
              treshold: 1024,
            },
            checkbox: {
              hidden: { key: "en-pl_hide-mask" },
            },
          },
        },
      },
      {
        name: "en-pl_mask-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-pl_hide-mask" } },
        },
      },
      {
        name: "en-pl_hide-stats",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "State",
            enable: { key: "en-pl_use-stats" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-pl_use-stats" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            store: { key: "en-pl_hide-stats" },
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
          },
        },
      },
      {
        name: "en-pl_stats",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_stats" },
            enable: { key: "en-pl_use-stats" },
            hidden: { key: "en-pl_hide-stats" },
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
          },
        },
      },
      {
        name: "en-pl_stats-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-pl_hide-stats" } },
        },
      },
      {
        name: "en-pl_hide-cfg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Config",
            enable: { key: "en-pl_use-bullethell" },
            //backgroundColor: VETheme.color.accentShadow,
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-pl_use-bullethell" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            store: { key: "en-pl_hide-cfg" },
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
          },
        },
      },
      {
        name: "en-pl_bullethell",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_bullethell" },
            enable: { key: "en-pl_use-bullethell" },
            hidden: { key: "en-pl_hide-cfg" },
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
          },
        },
      },
      {
        name: "en-pl_bullethell-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: {
            type: UILayoutType.VERTICAL,
            margin: { top: 0, bottom: 0 },
            height: function() { return 0 },
          },
          image: { 
            hidden: { key: "en-pl_hide-cfg" },
            backgroundAlpha: 0.0,
          },
        },
      },
      /* 
      {
        name: "grid-player_mode_platformer",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Platformer",
            enable: { key: "en-pl_use-platformer" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_use-platformer" },
          },
        },
      },
      {
        name: "en-pl_platformer",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_platformer" },
            enable: { key: "en-pl_use-platformer" },
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
          },
        },
      },
      {
        name: "en-pl_racing",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Racing",
            enable: { key: "en-pl_use-racing" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-pl_use-racing" },
          },
        },
      },
      {
        name: "en-pl_racing",
        template: VEComponents.get("text-area"),
        layout: VELayouts.get("text-area"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          field: { 
            v_grow: true,
            w_min: 570,
            store: { key: "en-pl_racing" },
            enable: { key: "en-pl_use-racing" },
            updateCustom: UIItemUtils.textField.getUpdateJSONTextArea(),
          },
        },
      },
      */
    ]),
  }
}