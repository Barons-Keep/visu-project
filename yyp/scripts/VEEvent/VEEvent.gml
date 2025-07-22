///@package io.alkapivo.visu.editor.service.event

///@param {UIItem} _context
///@param {?Struct} [json]
function VEEvent(_context, json = null) constructor {
  
  ///@type {UIItem}
  context = _context//Assert.isType(_context, UIItem)

  ///@type {String}
  type = Assert.isType(json.type, String) 

  ///@type {Store}
  store = new Store({
    "event-timestamp": {
      type: Number,
      value: Struct.get(json, "event-timestamp"),
      passthrough: function(value) {
        return clamp(value, 0.0, NumberUtil.parse(Beans
          .get(BeanVisuController).trackService.duration))
      }
    },
    "event-channel": {
      type: String,
      value: Struct.get(json, "event-channel"),
      passthrough: function(value) {
        var track = Beans.get(BeanVisuController).trackService.track
        return Core.isType(track, Track) && track.channels.contains(value)
          ? value
          : this.value
      }
    },
    "event-color": {
      type: Color,
      value: ColorUtil.fromHex(Struct.get(json, "event-color"), new Color(1.0, 1.0, 1.0, 1.0)),
      validate: function(value) {
        Assert.isType(ColorUtil.fromHex(value), Color)
      },
    },
    "event-texture": {
      type: String,
      value: Struct.getIfType(json, "event-texture", String, "texture_missing"),
      passthrough: function(value) {
        return Core.isType(TextureUtil.parse(value), Texture)
            && GMArray.contains(BRUSH_TEXTURES, value)
              ? value
              : this.value
      },
      data: new Array(String, BRUSH_TEXTURES),
    },
    "event-hidden": {
      type: Boolean,
      value: Struct.getIfType(json, "event-hidden", Boolean, false)
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
        label: { text: $"{Struct.get(BrushTypeNames, json.type)}" },
        checkbox: { 
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "event-hidden" },
        },
      },
    },
    {
      name: "event-timestamp",  
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { 
          type: UILayoutType.VERTICAL,
          margin: { top: 4, bottom: 4 },
        },
        label: {
          text: "Timestamp",
          hidden: { key: "event-hidden" },
        },
        field: {
          store: { key: "event-timestamp" },
          hidden: { key: "event-hidden" },
        },
      },
    },
    {
      name: "event-channel",  
      template: VEComponents.get("text-field"),
      layout: VELayouts.get("text-field"),
      config: { 
        layout: { 
          type: UILayoutType.VERTICAL,
          margin: { bottom: 4 },
        },
        label: {
          text: "Channel",
          hidden: { key: "event-hidden" }
        },
        field: {
          store: { key: "event-channel" },
          hidden: { key: "event-hidden" }
        },
      },
    },
    {
      name: "event-texture",
      template: VEComponents.get("spin-select"),
      layout: VELayouts.get("spin-select"),
      config: {
        layout: { 
          type: UILayoutType.VERTICAL,
          height: function() { return 32 },
          margin: { top: 4, bottom: 4 },
        },
        label: {
          text: "Icon",
          hidden: { key: "event-hidden" },
        },
        previous: {
          store: { key: "event-texture" },
          hidden: { key: "event-hidden" },
        },
        preview: Struct.appendRecursive({ 
          store: { key: "event-texture" },
          hidden: { key: "event-hidden" },
          imageBlendStoreKey: "event-color",
          updateCustom: function() {
            var key = Struct.get(this, "imageBlendStoreKey")
            if (!Optional.is(this.store)
              || !Core.isType(key, String) 
              || !Core.isType(this.image, Sprite)) {
              return
            }

            if (!Optional.is(this.store)) {
              return
            }
            
            var store = this.store.getStore()
            if (!Optional.is(store)) {
              return
            }

            var item = store.get("event-color")
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
          store: { key: "event-texture" },
          hidden: { key: "event-hidden" },
        },
      }
    },
    {
      name: "event-color",
      template: VEComponents.get("color-picker"),
      layout: VELayouts.get("color-picker"),
      config: {
        layout: { 
          type: UILayoutType.VERTICAL,
          hex: { margin: { top: 4 } },
        },
        red: {
          label: {
            text: "Red",
            hidden: { key: "event-hidden" },
          },
          field: {
            store: { key: "event-color" },
            hidden: { key: "event-hidden" },
          },
          slider: {
            store: { key: "event-color" },
            hidden: { key: "event-hidden" },
          },
        },
        green: {
          label: {
            text: "Green",
            hidden: { key: "event-hidden" },
          },
          field: {
            store: { key: "event-color" },
            hidden: { key: "event-hidden" },
          },
          slider: {
            store: { key: "event-color" },
            hidden: { key: "event-hidden" },
          },
        },
        blue: {
          label: {
            text: "Blue",
            hidden: { key: "event-hidden" },
          },
          field: {
            store: { key: "event-color" },
            hidden: { key: "event-hidden" },
          },
          slider: {
            store: { key: "event-color" },
            hidden: { key: "event-hidden" },
          },
        },
        hex: { 
          label: {
            text: "Hex",
            hidden: { key: "event-hidden" },
          },
          field: {
            store: { key: "event-color" },
            hidden: { key: "event-hidden" },
          },
          button: {
            hidden: { key: "event-hidden" },
          },
        },
      },
    },
    {
      name: "event_start-properties-line-h",
      template: VEComponents.get("line-h"),
      layout: VELayouts.get("line-h"),
      config: { layout: { type: UILayoutType.VERTICAL } },
    }
  ])

  var eventHandler = Assert.isType(Beans.get(BeanVisuController).trackService.handlers.get(this.type), Struct)
  
  ///@type {Callable}
  serializeData = Assert.isType(Struct.get(eventHandler, "serialize"), Callable)

  ///@return {Struct}
  toTemplate = function() {
    var event = this
    return {
      channel: Assert.isType(event.store.getValue("event-channel"), String),
      event: {
        callable: Assert.isType(event.type, String),
        timestamp: Assert.isType(event.store.getValue("event-timestamp"), Number),
        data: Struct.appendUnique(
          {
            icon: {
              name: Assert.isType(event.store.getValue("event-texture"), String),
              blend: Assert.isType(event.store.getValue("event-color").toHex(), String),
            },
            hidden: Assert.isType(event.store.getValue("event-hidden"), Boolean),
          },
          event.serializeData(event.store.container
            .filter(function(item) {
              return item.name != "event-timestamp"
                  && item.name != "event-channel"
                  && item.name != "event-color"
                  && item.name != "event-texture"
                  && item.name != "event-hidden"
            })
            .toStruct(function(item) { 
              return item.serialize()
            })
          )
        ),
      }
    }
  }

  ///@description append data
  var uiHandler = Assert.isType(Callable.get(this.type), Callable)
  var eventParser = Assert.isType(Struct.get(eventHandler, "parse"), Callable)
  var data = Assert.isType(eventParser(Struct.getIfType(json, "properties", Struct, { })), Struct)
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
    name: "event_finish-properties-line-h",
    template: VEComponents.get("line-h"),
    layout: VELayouts.get("line-h"),
    config: { layout: { type: UILayoutType.VERTICAL } },
  })
}
