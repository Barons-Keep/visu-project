///@package io.alkapivo.visu.editor.service.template

///@static
///@type {Map<String, Callable>}
global.__ShaderUniformTemplates = new Map(String, Callable)
  .set(ShaderUniformType.findKey(ShaderUniformType.COLOR), function(uniform, json, config = null) {
    var store = {}
    var storeConfig = Struct.get(config, "store")
    var componentsConfig = Struct.get(config, "components")
    Struct.set(store, $"{uniform.name}", {
      type: ColorTransformer,
      value: new ColorTransformer(Struct.getIfType(json, uniform.name, Struct, !Optional.is(config) ? {
        value: "#ffffff",
        target: "#ffffff",
        duration: 0.0,
        ease: EaseType.IN_OUT_QUINT,
      } : storeConfig)),
      passthrough: Struct.get(config, "passthrough"),
      data: Struct.get(config, "data"),
    })
    
    Struct.set(store, $"{uniform.name}_hide", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide", true),
    })

    Struct.set(store, $"{uniform.name}_hide-from", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide-from", true),
    })

    Struct.set(store, $"{uniform.name}_hide-to", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide-to", true),
    })

    return {
      store: store,
      components: new Array(Struct, [
        {
          name: $"shader-uniform_{uniform.name}_title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"[COLOR]  {uniform.name}",
              //backgroundColor: VETheme.color.accentShadow,
            },
            checkbox: {
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide" },
              //backgroundColor: VETheme.color.accentShadow,
            },
            input: {
              //backgroundColor: VETheme.color.accentShadow,
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}_from-title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"From",
              hidden: { key: $"{uniform.name}_hide" },
              backgroundColor: VETheme.color.side,
            },
            checkbox: {
              hidden: { key: $"{uniform.name}_hide" },
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide-from" },
              backgroundColor: VETheme.color.side,
            },
            input: {
              hidden: { key: $"{uniform.name}_hide" },
              backgroundColor: VETheme.color.side,
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}_from",
          template: VEComponents.get("color-picker-transformer"),
          layout: VELayouts.get("color-picker"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            hex: { 
              label: {
                text: "Hex",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
                colorKey: "value",
              },
              hidden: {
                keys: [
                  { key: $"{uniform.name}_hide" },
                  { key: $"{uniform.name}_hide-from" }
                ]
              },
            },
            red: {
              label: {
                text: "Red",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
                colorKey: "value",
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
                colorKey: "value",
              },
            },
            green: {
              label: {
                text: "Green",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
                colorKey: "value",
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
                colorKey: "value",
              },
            },
            blue: {
              label: {
                text: "Blue",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
                colorKey: "value",
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-from" }
                  ]
                },
                colorKey: "value",
              },
            },
          }
        },
        {
          name: $"shader-uniform_{uniform.name}-from-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: {
              hidden: {
                keys: [
                  { key: $"{uniform.name}_hide" },
                  { key: $"{uniform.name}_hide-from" }
                ]
              },
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}_to-title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"To",
              hidden: { key: $"{uniform.name}_hide" },
              backgroundColor: VETheme.color.side,
            },
            checkbox: {
              hidden: { key: $"{uniform.name}_hide" },
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide-to" },
              backgroundColor: VETheme.color.side,
            },
            input: {
              hidden: { key: $"{uniform.name}_hide" },
              backgroundColor: VETheme.color.side,
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}_to",
          template: VEComponents.get("color-picker-transformer"),
          layout: VELayouts.get("color-picker-alpha"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            hex: { 
              label: {
                text: "Hex",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
                colorKey: "target",
              },
              hidden: {
                keys: [
                  { key: $"{uniform.name}_hide" },
                  { key: $"{uniform.name}_hide-to" }
                ]
              },
            },
            red: {
              label: {
                text: "Red",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
                colorKey: "target",
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
                colorKey: "target",
              },
            },
            green: {
              label: {
                text: "Green",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
                colorKey: "target",
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
                colorKey: "target",
              },
            },
            blue: {
              label: {
                text: "Blue",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
                colorKey: "target",
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
                colorKey: "target",
              },
            },
            duration: {
              label: { 
                text: "Duration",
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },  
              field: { 
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
              increase: { 
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
              decrease: { 
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
              stick: { 
                store: { key: $"{uniform.name}" },
                hidden: {
                  keys: [
                    { key: $"{uniform.name}_hide" },
                    { key: $"{uniform.name}_hide-to" }
                  ]
                },
              },
            },
          }
        },
        {
          name: $"shader-uniform_{uniform.name}-to-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: {
              hidden: {
                keys: [
                  { key: $"{uniform.name}_hide" },
                  { key: $"{uniform.name}_hide-to" }
                ]
              },
            },
          },
        },
      ]),
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.FLOAT), function(uniform, json, config = null) {
    var store = {}
    var storeConfig = Struct.get(config, "store")
    var componentsConfig = Struct.get(config, "components")
    Struct.set(store, $"{uniform.name}_hide", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide", true),
    })

    Struct.set(store, uniform.name, {
      type: NumberTransformer,
      value: new NumberTransformer(Struct.getIfType(json, uniform.name, Struct, !Optional.is(storeConfig) ? {
        value: 0.0,
        target: 0.0,
        duration: 0.0,
        ease: EaseType.LINEAR,
      } : storeConfig)),
      passthrough: Struct.get(config, "passthrough"),
      data: Struct.get(config, "data"),
    })

    return {
      store: store,
      components: new Array(Struct, [
        {
          name: $"shader-uniform_{uniform.name}_title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"[FLOAT]  {uniform.name}",
              //backgroundColor: VETheme.color.accentShadow,
            },
            checkbox: {
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide" },
              //backgroundColor: VETheme.color.accentShadow
            },
            input: {
              //backgroundColor: VETheme.color.accentShadow,
            },
          },
        },
        VENumberTransformerComponent($"shader-uniform_{uniform.name}", Struct.appendRecursive({
          hidden: { key: $"{uniform.name}_hide" },
          store: {
            value: { key: $"{uniform.name}" },
          },
          value: {
            text: "Value",
            factor: 0.1,
            stick: { factor: 0.1 },
          },
          duration: {
            factor: 0.1,
            stick: { factor: 0.1 },
          },
        }, componentsConfig, false)),
        {
          name: $"shader-uniform_{uniform.name}-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        }
      ]),
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.CONST_FLOAT), function(uniform, json, config = null) {
    var store = {}
    var storeConfig = Struct.get(config, "store")
    var componentsConfig = Struct.get(config, "components")
    Struct.set(store, $"{uniform.name}_hide", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide", true),
    })

    Struct.set(store, uniform.name, {
      type: NumberTransformer,
      value: new NumberTransformer(Struct.getIfType(json, uniform.name, Struct, !Optional.is(storeConfig) ? {
        value: 0.0,
        target: 0.0,
        duration: 0.0,
        ease: EaseType.LINEAR,
      } : storeConfig)),
      passthrough: Struct.get(config, "passthrough"),
      data: Struct.get(config, "data"),
    })

    return {
      store: store,
      components: new Array(Struct, [
        {
          name: $"shader-uniform_{uniform.name}_title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"[FLOAT]  {uniform.name}",
              //backgroundColor: VETheme.color.accentShadow,
            },
            checkbox: {
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide" },
              //backgroundColor: VETheme.color.accentShadow
            },
            input: {
              //backgroundColor: VETheme.color.accentShadow,
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}",
          template: VEComponents.get("transform-numeric-uniform-simple"),
          layout: VELayouts.get("transform-numeric-uniform-simple"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            value: {
              label: { 
                text: "Value",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
          }, componentsConfig, false),
        },
        {
          name: $"shader-uniform_{uniform.name}-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        }
      ]),
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.VECTOR2), function(uniform, json, config = null) {
    var store = {}
    var storeConfig = Struct.get(config, "store")
    var componentsConfig = Struct.get(config, "components")
    Struct.set(store, $"{uniform.name}_hide", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide", true),
    })

    Struct.set(store, uniform.name, {
      type: Vector2Transformer,
      value: new Vector2Transformer(Struct.getIfType(json, uniform.name, Struct, !Optional.is(storeConfig) ? {
        x: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        }, 
        y: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        },
      } : storeConfig)),
      passthrough: Struct.get(config, "passthrough"),
      data: Struct.get(config, "data"),
    })

    return {
      store: store,
      components: new Array(Struct, [
        {
          name: $"shader-uniform_{uniform.name}_title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"[VEC2]  {uniform.name}",
              //backgroundColor: VETheme.color.accentShadow,
            },
            checkbox: {
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide" },
              //backgroundColor: VETheme.color.accentShadow
            },
            input: {
              //backgroundColor: VETheme.color.accentShadow,
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-x",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "x",
            value: {
              label: {
                text: "X",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec2x"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-x-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-y",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "y",
            value: {
              label: {
                text: "Y",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: { 
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec2y"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-y-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
      ]),
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.VECTOR3), function(uniform, json, config = null) {
    var store = {}
    var storeConfig = Struct.get(config, "store")
    var componentsConfig = Struct.get(config, "components")
    Struct.set(store, $"{uniform.name}_hide", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide", true),
    })

    Struct.set(store, uniform.name, {
      type: Vector3Transformer,
      value: new Vector3Transformer(Struct.getIfType(json, uniform.name, Struct, !Optional.is(storeConfig) ? {
        x: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        }, 
        y: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        },
        z: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        },
      } : storeConfig)),
      passthrough: Struct.get(config, "passthrough"),
      data: Struct.get(config, "data"),
    })

    return {
      store: store,
      components: new Array(Struct, [
        {
          name: $"shader-uniform_{uniform.name}_title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"[VEC3]  {uniform.name}",
              //backgroundColor: VETheme.color.accentShadow,
            },
            checkbox: {
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide" },
              //backgroundColor: VETheme.color.accentShadow
            },
            input: {
              //backgroundColor: VETheme.color.accentShadow,
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-x",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "x",
            value: {
              label: {
                text: "X",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec3x"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-x-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-y",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "y",
            value: {
              label: {
                text: "Y",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec3y"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-y-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-z",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "z",
            value: {
              label: {
                text: "Z",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec3z"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-z-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
      ]),
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.VECTOR4), function(uniform, json, config = null) {
    var store = {}
    var storeConfig = Struct.get(config, "store")
    var componentsConfig = Struct.get(config, "components")
    Struct.set(store, $"{uniform.name}_hide", {
      type: Boolean,
      value: Struct.parse.boolean(json, $"{uniform.name}_hide", true),
    })

    Struct.set(store, uniform.name, {
      type: Vector4Transformer,
      value: new Vector4Transformer(Struct.getIfType(json, uniform.name, Struct, !Optional.is(storeConfig) ? {
        x: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        }, 
        y: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        },
        z: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        },
        a: {
          value: 0.0,
          target: 0.0,
          duration: 0.0,
          ease: EaseType.IN_OUT_QUINT,
        },
      } : storeConfig)),
      passthrough: Struct.get(config, "passthrough"),
      data: Struct.get(config, "data"),
    })

    return {
      store: store,
      components: new Array(Struct, [
        {
          name: $"shader-uniform_{uniform.name}_title",
          template: VEComponents.get("property"),
          layout: VELayouts.get("property"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: $"[VEC4]  {uniform.name}",
              //backgroundColor: VETheme.color.accentShadow,
            },
            checkbox: {
              spriteOn: { name: "visu_texture_checkbox_show" },
              spriteOff: { name: "visu_texture_checkbox_hide" },
              store: { key: $"{uniform.name}_hide" },
              //backgroundColor: VETheme.color.accentShadow
            },
            input: {
              //backgroundColor: VETheme.color.accentShadow,
            },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-x",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "x",
            value: {
              label: {
                text: "X",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec4x"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-x-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-y",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "y",
            value: {
              label: {
                text: "Y",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec4y"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-y-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-z",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "z",
            value: {
              label: {
                text: "Z",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec4z"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-z-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        },
        {
          name: $"shader-uniform_{uniform.name}-a",
          template: VEComponents.get("transform-vec-property-uniform"),
          layout: VELayouts.get("transform-vec-property-uniform"),
          config: Struct.appendRecursive({
            layout: { type: UILayoutType.VERTICAL },
            vectorProperty: "a",
            value: {
              label: {
                text: "A",
                font: "font_inter_10_bold",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            target: {
              label: {
                text: "Target",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            factor: {
              label: {
                text: "Factor",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.001,
              },
            },
            increase: {
              label: {
                text: "Increase",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.0001,
              },
            },
            duration: {
              label: {
                text: "Duration",
                hidden: { key: $"{uniform.name}_hide" },
              },
              field: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              increase: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              decrease: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              slider: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
                factor: 0.01,
              },
            },
            ease: {
              label: {
                text: "Ease",
                hidden: { key: $"{uniform.name}_hide" },
              },
              previous: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              preview: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
              next: {
                store: { key: $"{uniform.name}" },
                hidden: { key: $"{uniform.name}_hide" },
              },
            },
          }, Struct.get(componentsConfig, "vec4a"), false),
        },
        {
          name: $"shader-uniform_{uniform.name}-a-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{uniform.name}_hide" }, },
          },
        }
      ]),
    }
  })
  .set(ShaderUniformType.findKey(ShaderUniformType.RESOLUTION), function(uniform, json, config = null) {
    var store = {}
    var storeConfig = Struct.get(config, "store")
    var componentsConfig = Struct.get(config, "components")
    Struct.set(store, uniform.name, {
      type: ResolutionTransformer,
      value: new ResolutionTransformer(Struct.getIfType(json, uniform.name, Struct, !Optional.is(storeConfig) ? {
        
      } : storeConfig)),
      passthrough: Struct.get(config, "passthrough"),
      data: Struct.get(config, "data"),
    })

    return {
      store: store,
    }
  })
#macro ShaderUniformTemplates global.__ShaderUniformTemplates


///@param {Struct} json
///@return {Struct}
function template_shader(json) {
  var shader = Assert.isType(ShaderUtil.fetch(json.shader), Shader)
  var template = {
    name: Assert.isType(json.name, String),
    shader: Assert.isType(shader.name, String),
    store: new Map(String, Struct),
    components: new Array(Struct),
    json: json,
  }

  var inherit = Struct.getDefault(json, "inherit", null)
  if (Core.isType(inherit, String)) {
    Struct.set(template, "inherit", inherit)
  }

  GMArray.forEach(GMArray.sort(shader.uniforms.keys().getContainer()), function(key, index, acc) {
    var uniform = acc.uniforms.get(key)
    var template = acc.template
    var type = ShaderUniformType.findKey(Callable.get(Core.getTypeName(uniform)))
    var properties = Struct.getDefault(template.json, "properties", {})
    var config = Struct.get(Struct.get(SHADER_CONFIGS, template.shader), key)
    var property = Callable.run(ShaderUniformTemplates.get(type), uniform, properties, config)
    if (!Optional.is(property)) {
      Logger.warn("VEShader", $"Found unsupported property '{key}' in template '{template.name}' of shader '{template.shader}")
      return
    }

    if (Optional.is(Struct.get(property, "store"))) {
      Struct.forEach(property.store, function(item, key, store) {
        store.add(item, key)
      }, template.store)
      //template.store.add(property.store.item, property.store.key)
    }
    
    if (Optional.is(Struct.get(property, "components"))) {
      property.components.forEach(function(component, index, components) {
        components.add(component)
      }, template.components)

      /*
      if (type != ShaderUniformType.findKey(ShaderUniformType.RESOLUTION)
          && type != ShaderUniformType.findKey(ShaderUniformType.VECTOR2) 
          && type != ShaderUniformType.findKey(ShaderUniformType.VECTOR3) 
          && type != ShaderUniformType.findKey(ShaderUniformType.VECTOR4)) {
        template.components.add({
          name: $"{template.name}_{key}-line-h",
          template: VEComponents.get("line-h"),
          layout: VELayouts.get("line-h"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            image: { hidden: { key: $"{template.name}_hide" } },
          },
        })
      }
      */
    }
  }, {
    uniforms: shader.uniforms,
    template: template,
  })

  Struct.remove(template, "json") ///@todo investigate
  
  return template
}
