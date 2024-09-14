///@package io.alkapivo.visu.editor.service.brush.view

///@static
///@type {Array<String>}
global.__WALLPAPER_TYPES = [
  "Background",
  "Foreground",
]
#macro WALLPAPER_TYPES global.__WALLPAPER_TYPES


///@param {?Struct} [json]
///@return {Struct}
function brush_view_wallpaper(json = null) {
  return {
    name: "brush_view_wallpaper",
    store: new Map(String, Struct, {
      "view-wallpaper_type": {
        type: String,
        value: Struct.getDefault(json, "view-wallpaper_type", WALLPAPER_TYPES[0]),
        validate: function(value) {
          Assert.areEqual(true, this.data.contains(value))
        },
        data: new Array(String, WALLPAPER_TYPES),
      },
      "view-wallpaper_fade-in-duration": {
        type: Number,
        value: Struct.getDefault(json, "view-wallpaper_fade-in-duration", 0.0),
        passthrough: function(value) {
          return NumberUtil.parse(value, this.value)
        },
      },
      "view-wallpaper_fade-out-duration": {
        type: Number,
        value: Struct.getDefault(json, "view-wallpaper_fade-out-duration", 0.0),
        passthrough: function(value) {
          return NumberUtil.parse(value, this.value)
        },
      },
      "view-wallpaper_use-color": {
        type: Boolean,
        value: Struct.getDefault(json, "view-wallpaper_use-color", false),
      },
      "view-wallpaper_color": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "view-wallpaper_color"), "#ffffffff"),
      },
      "view-wallpaper_clear-color": {
        type: Boolean,
        value: Struct.getDefault(json, "view-wallpaper_clear-color", false),
      },
      "view-wallpaper_use-texture": {
        type: Boolean,
        value: Struct.getDefault(json, "view-wallpaper_use-texture", true),
      },
      "view-wallpaper_texture": {
        type: Sprite,
        value: SpriteUtil.parse(Struct
          .get(json, "view-wallpaper_texture"), 
          { name: "texture_missing" }),
      },
      "view-wallpaper_use-texture-speed": {
        type: Boolean,
        value: Struct.getDefault(json, "view-wallpaper_use-texture-speed", true),
      },
      "view-wallpaper_texture-speed": {
        type: Number,
        value: Struct.getDefault(json, "view-wallpaper_texture-speed", 1),
        passthrough: function(value) {
          return NumberUtil.parse(value, this.value)
        },
      },
      "view-wallpaper_use-texture-blend": {
        type: Boolean,
        value: Struct.getDefault(json, "view-wallpaper_use-texture-blend", true),
      },
      "view-wallpaper_texture-blend": {
        type: Color,
        value: ColorUtil.fromHex(Struct.get(json, "view-wallpaper_texture-blend"), "#ffffff"),
      },
      "view-wallpaper_clear-texture": {
        type: Boolean,
        value: Struct.getDefault(json, "view-wallpaper_clear-texture", false),
      },
      "view-wallpaper_angle": {
        type: Number,
        value: Struct.getDefault(json, "view-wallpaper_angle", 0.0),
        passthrough: function(value) {
          return clamp(NumberUtil.parse(value, this.value), 0.0, 360.0) 
        },
      },
      "view-wallpaper_speed": {
        type: Number,
        value: Struct.getDefault(json, "view-wallpaper_speed", 0.0),
        passthrough: function(value) {
          return abs(NumberUtil.parse(value, this.value)) 
        },
      },
    }),
    components: new Array(Struct, [
      {
        name: "view-wallpaper_type",
        template: VEComponents.get("spin-select"),
        layout: VELayouts.get("spin-select"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Type" },
          previous: { store: { key: "view-wallpaper_type" } },
          preview: Struct.appendRecursive({ 
            store: { key: "view-wallpaper_type" },
          }, Struct.get(VEStyles.get("spin-select-label"), "preview"), false),
          next: { store: { key: "view-wallpaper_type" } },
        },
      },
      {
        name: "view-wallpaper_fade-in-duration",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Fade in" },
          field: { store: { key: "view-wallpaper_fade-in-duration" } },
        },
      },
      {
        name: "view-wallpaper_fade-out-duration",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Fade out" },
          field: { store: { key: "view-wallpaper_fade-out-duration" } },
        },
      },
      {
        name: "view-wallpaper_color",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker-alpha"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Set color",
              enable: { key: "view-wallpaper_use-color" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "view-wallpaper_use-color" },
            },
            input: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            }
          },
          red: {
            label: { 
              text: "Red",
              enable: { key: "view-wallpaper_use-color" },
            },
            field: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
            slider: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
          },
          green: {
            label: { 
              text: "Green",
              enable: { key: "view-wallpaper_use-color" },
            },
            field: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
            slider: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
          },
          blue: {
            label: { 
              text: "Blue",
              enable: { key: "view-wallpaper_use-color" },
            },
            field: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
            slider: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
          },
          alpha: {
            label: { 
              text: "Alpha",
              enable: { key: "view-wallpaper_use-color" },
            },
            field: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
            slider: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
          },
          hex: { 
            label: { 
              text: "Hex",
              enable: { key: "view-wallpaper_use-color" },
            },
            field: { 
              store: { key: "view-wallpaper_color" },
              enable: { key: "view-wallpaper_use-color" },
            },
          },
        },
      },
      {
        name: "view-wallpaper_clear-color",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Remove color" },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-wallpaper_clear-color" },
          },
        },
      },
      {
        name: "view-wallpaper_texture",
        template: VEComponents.get("texture-field"),
        layout: VELayouts.get("texture-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          title: {
            label: { 
              text: "Set texture",
              enable: { key: "view-wallpaper_use-texture" },
            },  
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "view-wallpaper_use-texture" },
            },
          },
          texture: {
            label: {
              text: "Texture",
              enable: { key: "view-wallpaper_use-texture" },
            }, 
            field: {
              store: { key: "view-wallpaper_texture" },
              enable: { key: "view-wallpaper_use-texture" },
            },
          },
          frame: {
            label: {
              text: "Frame",
              enable: { key: "view-wallpaper_use-texture" },
            },
            field: {
              store: { key: "view-wallpaper_texture" },
              enable: { key: "view-wallpaper_use-texture" },
            },
          },
          alpha: {
            label: {
              text: "Alpha",
              enable: { key: "view-wallpaper_use-texture" },
            },
            field: {
              store: { key: "view-wallpaper_texture" },
              enable: { key: "view-wallpaper_use-texture" },
            },
            slider: { 
              minValue: 0.0,
              maxValue: 1.0,
              store: { key: "view-wallpaper_texture" },
            },
          },
          preview: {
            image: { name: "texture_baron" },
            store: { key: "view-wallpaper_texture" },
            enable: { key: "view-wallpaper_use-texture" },
            imageBlendStoreKey: "view-wallpaper_texture-blend",
            useTextureSpeedStoreKey: "view-wallpaper_use-texture-speed",
            textureSpeedStoreKey: "view-wallpaper_texture-speed",
            updateCustom: function() {
              var key = Struct.get(this, "imageBlendStoreKey")
              if (!Optional.is(this.store)
                || !Core.isType(key, String) 
                || !Core.isType(this.image, Sprite)) {
                return
              }

              var store = this.store.getStore()
              if (!Optional.is(store)) {
                return
              }

              var item = store.get(key)
              if (!Optional.is(item)) {
                return
              }

              var gmColor = store.getValue("view-wallpaper_use-texture-blend")
                ? store.getValue("view-wallpaper_texture-blend").toGMColor()
                : c_white
              this.image.setBlend(gmColor)

              if (store.getValue(this.useTextureSpeedStoreKey)) {
                this.image.setAnimate(true)
                var animationSpeed = store.getValue(this.textureSpeedStoreKey)
                if (Core.isType(animationSpeed, Number)) {
                  this.image.setSpeed(animationSpeed)
                }
              } else {
                this.image.setAnimate(false)
              }
            },
          },
        },
      },
      {
        name: "view-wallpaper_use-texture-speed",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Texture speed",
            enable: { key: "view-wallpaper_use-texture-speed" },
          },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-wallpaper_use-texture-speed" },
          },
        },
      },
      {
        name: "view-wallpaper_texture-speed",
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: "FPS",
            enable: { key: "view-wallpaper_use-texture-speed" },
          },
          field: {
            store: { key: "view-wallpaper_texture-speed" },
            enable: { key: "view-wallpaper_use-texture-speed" },
          },
        },
      },
      {
        name: "view-wallpaper_texture-blend",
        template: VEComponents.get("color-picker"),
        layout: VELayouts.get("color-picker"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          title: { 
            label: { 
              text: "Texture blend",
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            checkbox: { 
              spriteOn: { name: "visu_texture_checkbox_on" },
              spriteOff: { name: "visu_texture_checkbox_off" },
              store: { key: "view-wallpaper_use-texture-blend" },
            },
            input: { 
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            }
          },
          red: {
            label: {
              text: "Red",
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            field: {
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            slider: {
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
          },
          green: {
            label: {
              text: "Green",
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            field: {
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            slider: {
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
          },
          blue: {
            label: {
              text: "Blue",
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            field: {
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            slider: {
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
          },
          hex: { 
            label: {
              text: "Hex",
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
            field: {
              store: { key: "view-wallpaper_texture-blend" },
              enable: { key: "view-wallpaper_use-texture-blend" },
            },
          },
        },
      },
      {
        name: "view-wallpaper_tiled",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Move",
          },
          input: {
            store: { 
              key: "view-wallpaper_angle",
              callback: function(value, data) { 
                var sprite = Struct.get(data, "sprite")
                if (!Core.isType(sprite, Sprite)) {
                  sprite = SpriteUtil.parse({ name: "visu_texture_ui_spawn_arrow" })
                  Struct.set(data, "sprite", sprite)
                }
                sprite.setAngle(value)
              },
              set: function(value) { return },
            },
            render: function() {
              if (this.backgroundColor != null) {
                var _x = this.context.area.getX() + this.area.getX()
                var _y = this.context.area.getY() + this.area.getY()
                var color = this.backgroundColor
                draw_rectangle_color(
                  _x, _y, 
                  _x + this.area.getWidth(), _y + this.area.getHeight(),
                  color, color, color, color,
                  false
                )
              }

              var sprite = Struct.get(this, "sprite")
              if (!Core.isType(sprite, Sprite)) {
                sprite = SpriteUtil.parse({ name: "visu_texture_ui_spawn_arrow" })
                Struct.set(this, "sprite", sprite)
              }
              sprite.scaleToFit(this.area.getWidth(), this.area.getHeight())
                .render(
                  this.context.area.getX() + this.area.getX() + sprite.texture.offsetX * sprite.getScaleX(),
                  this.context.area.getY() + this.area.getY() + sprite.texture.offsetY * sprite.getScaleY()
                )
              
              return this
            },
          }
        },
      },
      {
        name: "view-wallpaper_angle",  
        template: VEComponents.get("numeric-slider-field"),
        layout: VELayouts.get("numeric-slider-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Angle",
          },
          field: { 
            store: { key: "view-wallpaper_angle" },
          },
          slider: { 
            minValue: 0.0,
            maxValue: 360.0,
            store: { key: "view-wallpaper_angle" },
          },
        },
      },
      {
        name: "view-wallpaper_speed",  
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Speed" },
          field: { store: { key: "view-wallpaper_speed" } },
        },
      },
      {
        name: "view-wallpaper_clear-texture",
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: { 
          layout: { type: UILayoutType.VERTICAL },
          label: { text: "Remove texture" },
          checkbox: { 
            spriteOn: { name: "visu_texture_checkbox_on" },
            spriteOff: { name: "visu_texture_checkbox_off" },
            store: { key: "view-wallpaper_clear-texture" },
          },
        },
      },
    ]),
  }
}