///@package io.alkapivo.visu.editor.service.brush.entity

///@param {?Struct} [json]
///@return {Struct}
function brush_entity_config(json = null) {
  return {
    name: "brush_entity_config",
    store: new Map(String, Struct, {
      "en-cfg_use-render-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-shr"),
      },
      "en-cfg_render-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-shr"),
      },
      "en-cfg_use-render-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-player"),
      },
      "en-cfg_render-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-player"),
      },
      "en-cfg_use-render-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-coin"),
      },
      "en-cfg_render-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-coin"),
      },
      "en-cfg_use-render-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-bullet"),
      },
      "en-cfg_render-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_render-bullet"),
      },
      "en-cfg_cls-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-shr"),
      },
      "en-cfg_cls-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-player"),
      },
      "en-cfg_cls-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-coin"),
      },
      "en-cfg_cls-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_cls-bullet"),
      },
      "en-cfg_use-z-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-shr"),
      },
      "en-cfg_z-shr": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-shr"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-shr": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_change-z-shr"),
      },
      "en-cfg_use-z-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-player"),
      },
      "en-cfg_z-player": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-player"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_change-z-player"),
      },
      "en-cfg_use-z-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-coin"),
      },
      "en-cfg_z-coin": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-coin", Struct),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_change-z-coin"),
      },
      "en-cfg_use-z-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-z-bullet"),
      },
      "en-cfg_z-bullet": {
        type: NumberTransformer,
        value: Struct.get(json, "en-cfg_z-bullet"),
        passthrough: UIUtil.passthrough.getClampedNumberTransformer(),
        data: new Vector2(0.0, 99999.9),
      },
      "en-cfg_change-z-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_use-render-shr"),
      },
      "en-cfg_hide-render": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_hide-render"),
      },
      "en-cfg_hide-cls": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_hide-cls"),
      },
      "en-cfg_hide-cfg": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_hide-cfg"),
      },
      "en-cfg_hide-shroom": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_hide-shroom"),
      },
      "en-cfg_hide-player": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_hide-player"),
      },
      "en-cfg_hide-coin": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_hide-coin"),
      },
      "en-cfg_hide-bullet": {
        type: Boolean,
        value: Struct.get(json, "en-cfg_hide-bullet"),
      }
    }),
    components: new Array(Struct, [
      {
        name: "en-cfg_render",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Render",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-cfg_hide-render" },
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-cfg_render-shr",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Shrooms",
            enable: { key: "en-cfg_use-render-shr" },
            hidden: { key: "en-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_use-render-shr" },
            hidden: { key: "en-cfg_hide-render" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-cfg_render-shr" },
            enable: { key: "en-cfg_use-render-shr" },
            hidden: { key: "en-cfg_hide-render" },
          },
        },
      },
      {
        name: "en-cfg_render-player",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Player",
            enable: { key: "en-cfg_use-render-player" },
            hidden: { key: "en-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_use-render-player" },
            hidden: { key: "en-cfg_hide-render" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-cfg_render-player" },
            enable: { key: "en-cfg_use-render-player" },
            hidden: { key: "en-cfg_hide-render" },
          },
        },
      },
      {
        name: "en-cfg_render-coin",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Coins",
            enable: { key: "en-cfg_use-render-coin" },
            hidden: { key: "en-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_use-render-coin" },
            hidden: { key: "en-cfg_hide-render" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-cfg_render-coin" },
            enable: { key: "en-cfg_use-render-coin" },
            hidden: { key: "en-cfg_hide-render" },
          },
        },
      },
      {
        name: "en-cfg_render-bullet",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Bullets",
            enable: { key: "en-cfg_use-render-bullet" },
            hidden: { key: "en-cfg_hide-render" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_use-render-bullet" },
            hidden: { key: "en-cfg_hide-render" },
          },
          input: {
            spriteOn: { name: "visu_texture_checkbox_switch_on" },
            spriteOff: { name: "visu_texture_checkbox_switch_off" },
            store: { key: "en-cfg_render-bullet" },
            enable: { key: "en-cfg_use-render-bullet" },
            hidden: { key: "en-cfg_hide-render" },
          },
        },
      },
      {
        name: "en-cfg_cls-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-cfg_hide-render" } },
        },
      },
      {
        name: "en-cfg_cls",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Clear",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-cfg_hide-cls" },
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-cfg_cls-shr",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Shrooms",
            enable: { key: "en-cfg_cls-shr" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_cls-shr" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "en-cfg_cls-player",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Player",
            enable: { key: "en-cfg_cls-player" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_cls-player" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "en-cfg_cls-coin",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "Coins",
            enable: { key: "en-cfg_cls-coin" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_cls-coin" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "en-cfg_cls-bullet",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Bullets",
            enable: { key: "en-cfg_cls-bullet" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "en-cfg_cls-bullet" },
            hidden: { key: "en-cfg_hide-cls" },
          },
          input: { },
        },
      },
      {
        name: "en-cfg_z-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: { hidden: { key: "en-cfg_hide-cls" } }
        },
      },
      {
        name: "en-cfg_cfg",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Properties",
            backgroundColor: VETheme.color.accentShadow,
          },
          checkbox: {
            backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-cfg_hide-cfg" },
          },
          input: {
            backgroundColor: VETheme.color.accentShadow,
          },
        },
      },
      {
        name: "en-cfg_shr",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Shroom Z",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-cfg_hide-shroom" },
            hidden: { key: "en-cfg_hide-cfg" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
        },
      },
      {
        name: "en-cfg_z-shr",
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
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "en-cfg_use-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_use-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_use-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_use-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_use-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "en-cfg_use-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-shr" },
              enable: { key: "en-cfg_change-z-shr" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-shroom" }
                ]
              },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "en-cfg_z-player-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "en-cfg_hide-cfg" }, 
                { key: "en-cfg_hide-shroom" }
              ]
            },
          },
        },
      },
      {
        name: "en-cfg_player",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Player Z",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-cfg_hide-player" },
            hidden: { key: "en-cfg_hide-cfg" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
        },
      },
      {
        name: "en-cfg_z-player",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "en-cfg_use-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_use-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_use-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_use-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_use-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "en-cfg_use-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-player" },
              enable: { key: "en-cfg_change-z-player" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-player" }
                ]
              },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "en-cfg_z-coin-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "en-cfg_hide-cfg" }, 
                { key: "en-cfg_hide-player" }
              ]
            },
          },
        },
      },
      {
        name: "en-cfg_coin",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Coin Z",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-cfg_hide-coin" },
            hidden: { key: "en-cfg_hide-cfg" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
        },
      },
      {
        name: "en-cfg_z-coin",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "en-cfg_use-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_use-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_use-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_use-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_use-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "en-cfg_use-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-coin" },
              enable: { key: "en-cfg_change-z-coin" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-coin" }
                ]
              },
              factor: 1.0,
            },
          },
        },
      },
      {
        name: "en-cfg_z-bullet-line-h",
        template: VEComponents.get("line-h"),
        layout: VELayouts.get("line-h"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          image: {
            hidden: { 
              keys: [
                { key: "en-cfg_hide-cfg" }, 
                { key: "en-cfg_hide-coin" }
              ]
            },
          },
        },
      },
      {
        name: "en-cfg_bullet",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Bullet Z",
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
          checkbox: {
            //backgroundColor: VETheme.color.accentShadow,
            spriteOn: { name: "visu_texture_checkbox_show" },
            spriteOff: { name: "visu_texture_checkbox_hide" },
            store: { key: "en-cfg_hide-bullet" },
            hidden: { key: "en-cfg_hide-cfg" },
          },
          input: {
            //backgroundColor: VETheme.color.accentShadow,
            hidden: { key: "en-cfg_hide-cfg" },
          },
        },
      },
      {
        name: "en-cfg_z-bullet",
        template: VEComponents.get("number-transformer-increase-checkbox"),
        layout: VELayouts.get("number-transformer-increase-checkbox"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          value: {
            label: {
              text: "Value",
              //font: "font_inter_10_bold",
              //color: VETheme.color.textShadow,
              enable: { key: "en-cfg_use-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_use-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_use-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_use-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_use-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            title: { 
              text: "Override",
              enable: { key: "en-cfg_use-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
          },
          target: {
            label: {
              text: "Target",
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: 1.0,
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            title: { 
              text: "Change",
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
          },
          factor: {
            label: {
              text: "Factor",
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: 1.0,
            },
          },
          increase: {
            label: {
              text: "Increase",
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            field: {
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
            },
            decrease: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: -1.0,
            },
            increase: { 
              store: { key: "en-cfg_z-bullet" },
              enable: { key: "en-cfg_change-z-bullet" },
              hidden: { 
                keys: [
                  { key: "en-cfg_hide-cfg" }, 
                  { key: "en-cfg_hide-bullet" }
                ]
              },
              factor: 1.0,
            },
          },
        },
      },
    ]),
  }
}