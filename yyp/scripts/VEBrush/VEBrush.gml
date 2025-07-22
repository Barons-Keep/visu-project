///@package io.alkapivo.visu.editor.service.brush

///@param {VEBrushTemplate} template
function VEBrush(template) constructor {
  
  ///@type {BrushType}
  type = Assert.isEnum(template.type, BrushType)
   
  ///@type {Store}
  store = new Store({
    "brush-name": {
      type: String,
      value: template.name,
    },
    "brush-color": {
      type: Color,
      value: ColorUtil.fromHex(Struct.get(template, "color"), ColorUtil.fromHex("#FFFFFF")),
      passthrough: function(value) {
        return Core.isType(value, Color) ? value : this.value
      },
    },
    "brush-texture": {
      type: String,
      value: Struct.getIfType(template, "texture", String, "texture_missing"),
      passthrough: function(value) {
        return Core.isType(TextureUtil.parse(value), Texture)
            && GMArray.contains(BRUSH_TEXTURES, value)
              ? value
              : this.value
      },
      data: new Array(String, BRUSH_TEXTURES),
    },
    "brush-hidden": {
      type: Boolean,
      value: Struct.getIfType(template, "hidden", Boolean, false)
    }
  })

  ///@type {Array<Struct>}
  components = new Array(Struct, [
    {
      name: "event-type",
      template: VEComponents.get("property"),
      layout: VELayouts.get("property"),
      config: { 
        layout: { type: UILayoutType.VERTICAL },
        //label: { text: $"{Struct.get(BrushTypeNames, template.type)}" },
        label: { text: $"Brush" },
        checkbox: { 
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "brush-hidden" },
        },
      },
    },
    {
      name: "brush-name",
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { 
          type: UILayoutType.VERTICAL,
        },
        label: {
          text: "Name",
          hidden: { key: "brush-hidden" },
        },
        field: {
          store: { key: "brush-name" },
          hidden: { key: "brush-hidden" },
        },
      },
    },
    {
      name: "brush-color",
      template: VEComponents.get("color-picker"),
      layout: VELayouts.get("color-picker"),
      config: {
        layout: { 
          type: UILayoutType.VERTICAL,
        },
        //title: { 
        //  label: { text: "Icon" },
        //  input: { store: { key: "brush-color" } },
        //  hidden: { key: "brush-hidden" },
        //},
        red: {
          label: {
            text: "Red",
            hidden: { key: "brush-hidden" },
          },
          field: {
            store: { key: "brush-color" },
            hidden: { key: "brush-hidden" },
          },
          slider: {
            store: { key: "brush-color" },
            hidden: { key: "brush-hidden" },
          },
        },
        green: {
          label: {
            text: "Green",
            hidden: { key: "brush-hidden" },
          },
          field: {
            store: { key: "brush-color" },
            hidden: { key: "brush-hidden" },
          },
          slider: {
            store: { key: "brush-color" },
            hidden: { key: "brush-hidden" },
          },
        },
        blue: {
          label: {
            text: "Blue",
            hidden: { key: "brush-hidden" },
          },
          field: {
            store: { key: "brush-color" },
            hidden: { key: "brush-hidden" },
          },
          slider: {
            store: { key: "brush-color" },
            hidden: { key: "brush-hidden" },
          },
        },
        hex: { 
          label: {
            text: "Hex",
            hidden: { key: "brush-hidden" },
          },
          field: {
            store: { key: "brush-color" },
            hidden: { key: "brush-hidden" },
          },
          button: {
            hidden: { key: "brush-hidden" },
          }
        },
      },
    },
    {
      name: "brush-texture",
      template: VEComponents.get("spin-select"),
      layout: VELayouts.get("spin-select"),
      config: {
        layout: { 
          type: UILayoutType.VERTICAL,
          height: function() { return 32 },
          margin: { top: 4, bottom: 4 },
        },
        label: {
          text: "Texture",
          hidden: { key: "brush-hidden" },
        },
        previous: {
          store: { key: "brush-texture" },
          hidden: { key: "brush-hidden" },
        },
        preview: Struct.appendRecursive({ 
          store: { key: "brush-texture" },
          hidden: { key: "brush-hidden" },
          imageBlendStoreKey: "brush-color",
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

            var item = store.get("brush-color")
            if (!Optional.is(item)) {
              return
            }
            this.image.blend = item.get().toGMColor()
          },
          postRender: function() {
            if (!Optional.is(this.store)) {
              return
            }

            var item = this.store.get()
            if (!Optional.is(item)) {
              return
            }

            var data = item.data
            if (!Core.isType(data, Collection)) {
              return
            }

            var index = data.findIndex(Lambda.equal, item.get())
            if (!Optional.is(index)) {
              return
            }

            var margin = 5.0
            var width = 32.0
            var spinButtonsWidth = 2.0 * (16.0 + 5.0)
            var size = floor((this.area.getWidth() - spinButtonsWidth) / (width + margin))
            if (size <= 3.0) {
              return
            }

            if (size mod 2.0 == 0.0) {
              size -= 1.0
            }

            var from = -1.0 * floor(size / 2.0)
            var to = abs(from)
            var beginX = round(this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2.0) - (width / 2.0))
            var beginY = this.context.area.getY() + this.area.getY(),
            var color = ColorUtil.parse(VETheme.color.primaryLight).toGMColor()
            var color2 = ColorUtil.parse("#d1a1ff").toGMColor()
            var enableFactor = Struct.get(this.enable, "value") == true ? 1.0 : 0.5
            for (var idx = from; idx <= to; idx += 1.0) {
              if (idx == 0.0) {
                GPU.render.rectangle(
                  beginX - 1,
                  beginY - 1,
                  beginX + width + 0,
                  beginY + width + 0,
                  true,
                  color,
                  color,
                  color,
                  color,
                  0.75
                )
                GPU.render.rectangle(
                  beginX - 2,
                  beginY - 2,
                  beginX + width + 1,
                  beginY + width + 1,
                  true,
                  color,
                  color,
                  color,
                  color,
                  0.50
                )
                continue
              }

              if (data.size() + idx < 0.0 || idx >= data.size()) {
                continue
              }

              var wrappedIndex = (((index + idx) mod data.size()) + data.size()) mod data.size()
              var textureName = data.get(wrappedIndex)
              
              if (!Optional.is(textureName)) {
                continue
              }

              var texture = TextureUtil.parse(textureName)
              if (!Optional.is(texture)) {
                continue
              }

              var scale = width / texture.width
              texture.render(
                beginX + (idx * (width + margin)) + (texture.offsetX * scale),
                beginY + (texture.offsetY * scale),
                0.0, scale, scale, 1.6*enableFactor, 0.0, color2
              )
            }
          },
          onMouseReleasedLeft: function(event) {
            if (!Optional.is(this.store)) {
              return
            }

            var item = this.store.get()
            if (!Optional.is(item)) {
              return
            }

            var data = item.data
            if (!Core.isType(data, Collection)) {
              return
            }

            var index = data.findIndex(Lambda.equal, item.get())
            if (!Optional.is(index)) {
              return
            }

            var margin = 5.0
            var width = 32.0
            var spinButtonsWidth = 2.0 * (16.0 + 5.0)
            var size = floor((this.area.getWidth() - spinButtonsWidth) / (width + margin))
            if (size <= 3.0) {
              return
            }

            if (size mod 2.0 == 0.0) {
              size -= 1.0
            }

            var from = -1.0 * floor(size / 2.0)
            var to = abs(from)
            var mouseX = event.data.x - this.context.area.getX() - this.context.offset.x
            var beginX = this.area.getX() + (this.area.getWidth() / 2.0) - (width / 2.0)
            for (var idx = from; idx <= to; idx += 1.0) {
              if (idx == 0.0 || data.size() + idx < 0.0 || idx >= data.size()) {
                continue
              }

              var wrappedIndex = (((index + idx) mod data.size()) + data.size()) mod data.size()
              var textureName = data.get(wrappedIndex)
              
              if (!Optional.is(textureName)) {
                continue
              }

              var textureX = beginX + (idx * (width + margin)) 
              if (mouseX < textureX || mouseX > textureX + width) {
                continue
              }

              item.set(textureName)
            }
          },
        }, Struct.get(VEStyles.get("spin-select-image"), "preview"), false),
        next: {
          store: { key: "brush-texture" },
          hidden: { key: "brush-hidden" },
        },
      }
    },
    {
      name: "brush-properties-line-h",
      template: VEComponents.get("line-h"),
      layout: VELayouts.get("line-h"),
      config: {
        layout: { type: UILayoutType.VERTICAL },
        image: { hidden: { key: "brush-hidden" } },
      },
    }
  ])

  var eventHandler = Assert.isType(Beans.get(BeanVisuController).trackService.handlers.get(this.type), Struct)
  
  ///@type {Callable}
  serializeData = Assert.isType(Struct.get(eventHandler, "serialize"), Callable)

  ///@return {VEBrushTemplate}
  toTemplate = function() {
    var json = {
      name: Assert.isType(this.store.getValue("brush-name"), String),
      type: Assert.isEnum(this.type, BrushType),
      color: Assert.isType(this.store.getValue("brush-color"), Color).toHex(),
      texture: Assert.isType(this.store.getValue("brush-texture"), String),
      hidden: Assert.isType(this.store.getValue("brush-hidden"), Boolean),
    }

    var properties = this.serializeData(this.store.container
      .filter(function(item) {
        return item.name != "brush-name" 
            && item.name != "brush-color" 
            && item.name != "brush-texture"
            && item.name != "brush-hidden"
      })
      .toStruct(function(item) { 
        return item.serialize()
      })
    )
    
    if (Struct.size(properties) > 0) {
      Struct.set(json, "properties", properties)
    }

    return new VEBrushTemplate(json)
  }

  ///@description append data
  var uiHandler = Assert.isType(Callable.get(this.type), Callable)
  var eventParser = Assert.isType(Struct.get(eventHandler, "parse"), Callable)
  var data = Assert.isType(eventParser(Struct.getIfType(template, "properties", Struct, { })), Struct)
  var properties = Assert.isType(uiHandler(data), Struct)

  ///@description append StoreItems to default template
  properties.store.forEach(function(json, name, store) {
    store.add(new StoreItem(name, json))
  }, this.store)

  ///@description append components to default template
  properties.components.forEach(function(component, index, components) {
    components.add(component)
  }, this.components)

  ///@description append ending line
  this.components.add({
    name: "brush_finish-properties-line-h",
    template: VEComponents.get("line-h"),
    layout: VELayouts.get("line-h"),
    config: { layout: { type: UILayoutType.VERTICAL } },
  })
}
