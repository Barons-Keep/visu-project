///@package io.alkapivo.visu.ui

///@type {Map<String, Callable>}
global.__VisuComponents = new Map(String, Callable, {

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "menu-title": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}_menu-title",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable
                .run(UIUtil.updateAreaTemplates
                .get("applyLayout")),
            }, 
            VisuStyles.get("menu-title").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
    ])
  },

    ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "menu-label-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}_menu-label-entry",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable
                .run(UIUtil.updateAreaTemplates
                .get("applyCollectionLayout")),
            }, 
            VisuStyles.get("menu-label-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "menu-button-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}_menu-button-entry",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable
                .run(UIUtil.updateAreaTemplates
                .get("applyCollectionLayout")),
            }, 
            VisuStyles.get("menu-button-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "menu-button-input-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}_menu-button-input-entry",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable
                .run(UIUtil.updateAreaTemplates
                .get("applyCollectionLayout")),
            }, 
            VisuStyles.get("menu-button-input-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UIButton(
        $"checkbox_{name}_menu-button-input-entry",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.input,
              updateArea: Callable
                .run(UIUtil.updateAreaTemplates
                .get("applyCollectionLayout")),
            }, 
            VisuStyles.get("menu-button-input-entry").input,
            false
          ),
          Struct.get(config, "input"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "menu-spin-select-entry": function(name, layout, config = null) {
    static factoryButton = function(name, layout, config) {
      return UIButton(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable
              .run(UIUtil.updateAreaTemplates
              .get("applyCollectionLayout")),
          }, 
          config, 
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryPreview = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
          }, 
          config, 
          false
        )
      )
    }

    return new Array(UIItem, [
      UIText(
        $"{name}_label", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            },
            Struct.get(VisuStyles.get("menu-spin-select-entry"), "label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      factoryButton(
        $"{name}_previous",
        layout.nodes.previous,
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              increment: -1,
              onMouseHoverOver: function(event) {
                this.sprite.setBlend(ColorUtil.fromHex("#ffffff").toGMColor())
              },
              onMouseHoverOut: function(event) {
                this.sprite.setBlend(ColorUtil.fromHex(VETheme.color.textFocus).toGMColor())
              },            
            },
            Struct.get(config, "previous"), 
            false
          ), 
          Struct.get(VisuStyles.get("menu-spin-select-entry"), "previous"),
          false
        )
      ),
      factoryPreview(
        $"{name}_preview",
        layout.nodes.preview,
        Struct.appendRecursive(
          Struct.get(config, "preview"),
          Struct.get(VisuStyles.get("menu-spin-select-entry"), "preview"),
          false
        )
      ),
      factoryButton(
        $"{name}_next",
        layout.nodes.next,
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              increment: 1,
              onMouseHoverOver: function(event) {
                this.sprite.setBlend(ColorUtil.fromHex("#ffffff").toGMColor())
              },
              onMouseHoverOut: function(event) {
                this.sprite.setBlend(ColorUtil.fromHex(VETheme.color.textFocus).toGMColor())
              },            
            },
            Struct.get(config, "next"),
            false
          ),
          Struct.get(VisuStyles.get("menu-spin-select-entry"), "next"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "menu-keyboard-key-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"{name}_label", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            },
            Struct.get(VisuStyles.get("menu-keyboard-key-entry"), "label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UIText(
        $"{name}_preview", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.preview,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            },
            Struct.get(VisuStyles.get("menu-keyboard-key-entry"), "preview"),
            false
          ),
          Struct.get(config, "preview"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [_config]
  ///@return {Array<UIItem>}
  "number-property": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryHeader = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("property"),
        layout: VELayouts.get("property"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryTextFieldIncreaseStickCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-stick-checkbox"),
        layout: VELayouts.get("text-field-increase-stick-checkbox"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
              },
            },
            decrease: VEComponentsUtil.factory.config.decreaseNumericProperty(),
            increase: VEComponentsUtil.factory.config.increaseNumericProperty(),
            stick: VEComponentsUtil.factory.config.numberStick({ 
              store: {
                callback: Lambda.passthrough,
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = item.get()
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }
                  item.set(Struct.set(transformer, key, parsedValue))
                },
                getValue: function() {
                  var key = Struct.get(this.context, "transformNumericProperty")
                  if (!Optional.is(key)) {
                    return null
                  }

                  var item = this.get()
                  if (!Optional.is(item)) {
                    return null
                  }

                  var transformer = item.get()
                  if (!Optional.is(transformer)) {
                    return
                  }
                  
                  return Struct.get(transformer, key)
                },
              },
            }),
            checkbox: { },
            title: {
              store: Struct.get(Struct.get(config, "checkbox"), "store"),
              onMouseReleasedLeft: function(event) {
                if (!Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                item.set(!item.get())

                if (Optional.is(this.context)) {
                  this.context.clampUpdateTimer(0.7500)
                }
              }
            }
          },
          config, 
          false
        )
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factorySpinSelect = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("spin-select"),
        layout: VisuLayouts.get("spin-select"),
        config: Struct.appendRecursive(
          {
            label: { text: "Ease" },
            layout: { 
              type: UILayoutType.VERTICAL,
              height: function() { return 32 },
              margin: { top: 6, bottom: 12 },
            },
            previous: { 
              callback: function() {
                var increment = -1
                if (!Optional.is(this.store)) {
                  return
                }
  
                var item = this.store.get()
                if (!Optional.is(item)) {
                  return
                }

                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer)) {
                  return
                }
  
                var data = EaseType.keys()
                var index = data.findIndex(Lambda.equal, transformer.easeType)
                index = (index == null ? 0 : index) + increment
                if (index < 0) {
                  index = data.size() - 1
                } else if (index > data.size() - 1) {
                  index = 0
                }

                transformer.easeType = data.get(index)
                transformer.startValue = transformer.value
                transformer.startFactor = transformer.factor
                transformer.reset()
                item.set(transformer)
              },
              store: { 
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            preview: { 
              image: { name: "texture_empty" },
              store: {
                callback: function(transformer, data) { 
                  if (!Core.isType(transformer, NumberTransformer)) {
                    return
                  }
                  
                  var textureName = Struct.get(EASE_TYPE_MAP, transformer.easeType)
                  if (!Optional.is(textureName)) {
                    return
                  }

                  var image = SpriteUtil.parse({ name: textureName })
                  if (!Core.isType(image, Sprite)) {
                    return
                  }

                  Struct.set(data, "image", image)
                },
              },
              updateCustom: function() {
                if (!Optional.is(this.store)) {
                  return
                }
    
                var item = this.store.get()
                if (!Optional.is(item)) {
                  return
                }

                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer)) {
                  return
                }

                var texture = Struct.get(EASE_TYPE_MAP, transformer.easeType)

                Struct.set(this, "image", SpriteUtil.parse({ "name": texture }))
              },
              postRender: function() {
                if (!Optional.is(this.store)) {
                  return
                }
    
                var item = this.store.get()
                if (!Optional.is(item)) {
                  return
                }

                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer)) {
                  return
                }
    
                var data = EaseType.keys()
                var index = data.findIndex(Lambda.equal, transformer.easeType)
                if (!Optional.is(index)) {
                  return
                }
    
                var margin = 5.0
                var width = 32.0
                var spinButtonsWidth = 2.0 * (16.0 + margin)
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
                var enableFactor = Struct.get(this.enable, "value") == false ? 0.5 : 1.0
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
                      0.5
                    )
                    
                    continue
                  }
    
                  if (data.size() + idx < 0.0 || idx >= data.size()) {
                    continue
                  }
    
                  var wrappedIndex = (((index + idx) mod data.size()) + data.size()) mod data.size()
                  var easeTypeName = data.get(wrappedIndex)

                  var textureName = Struct.get(EASE_TYPE_MAP, easeTypeName)
                  
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

                var label = Struct.get(this, "_label")
                if (!Optional.is(label)) {
                  label = new UILabel({
                    text: "",
                    align: { v: VAlign.TOP, h: HAlign.CENTER },
                    color: VETheme.color.text,
                    useScale: false,
                    outline: true,
                    outlineColor: VETheme.color.sideDark,
                    font: "font_inter_8_bold",
                  })
                  Struct.set(this, "_label", label)
                }

                var labelAlpha = label.alpha
                label.alpha *= enableFactor
                label.text = String.replaceAll(transformer.easeType, "_", " ")
                if (keyboard_check(vk_control)) {
                  label.text = $"F: {String.format(transformer.factor, 8, 4)},  I: {String.format(transformer.increase, 8, 4)}"
                }

                label.render(
                  // todo VALIGN HALIGN
                  this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                  this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 1) + 2,
                  this.area.getWidth(),
                  this.area.getHeight()
                )
                label.alpha = labelAlpha
              },
              onMouseReleasedLeft: function(event) {
                var enable = Struct.get(this.enable, "value")
                if (enable == false) {
                  return
                }

                if (!Optional.is(this.store)) {
                  return
                }
    
                var item = this.store.get()
                if (!Optional.is(item)) {
                  return
                }

                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer)) {
                  return
                }
    
                var data = EaseType.keys()
                var index = data.findIndex(Lambda.equal, transformer.easeType)
                if (!Optional.is(index)) {
                  return
                }
    
                var margin = 5.0
                var width = 32.0
                var spinButtonsWidth = 2.0 * (16.0 + margin)
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
                  var easeTypeName = data.get(wrappedIndex)

                  if (!Optional.is(easeTypeName)) {
                    continue
                  }

                  var textureX = beginX + (idx * (width + margin)) 
                  if (mouseX < textureX || mouseX > textureX + width) {
                    continue
                  }
    
                  transformer.easeType = easeTypeName
                  transformer.startValue = transformer.value
                  transformer.startFactor = transformer.factor
                  transformer.reset()
                  item.set(transformer)
                }
              },
            },
            next: { 
              callback: function() {
                var increment = 1
                if (!Optional.is(this.store)) {
                  return
                }
  
                var item = this.store.get()
                if (!Optional.is(item)) {
                  return
                }

                var transformer = item.get()
                if (!Core.isType(transformer, NumberTransformer)) {
                  return
                }
  
                var data = EaseType.keys()
                var index = data.findIndex(Lambda.equal, transformer.easeType)
                index = (index == null ? 0 : index) + increment
                if (index < 0) {
                  index = data.size() - 1
                } else if (index > data.size() - 1) {
                  index = 0
                }

                transformer.easeType = data.get(index)
                transformer.startValue = transformer.value
                transformer.startFactor = transformer.factor
                transformer.reset()
                item.set(transformer)
              },
              store: { 
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
          },
          config,
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryHeader(
      $"{name}_header",
      layout.nodes.header,
      Struct.get(config, "header"),
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_value",
      layout.nodes.value,
      Struct.appendRecursive(
        { 
          field: { transformNumericProperty: "value" },
          decrease: { transformNumericProperty: "value" },
          increase: { transformNumericProperty: "value" },
          stick: {
            transformNumericProperty: "value",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "value"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "value"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "value"), "field"), "hidden", Struct, { })),
          },
        },
        Struct.get(config, "value"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_target",
      layout.nodes.target,
      Struct.appendRecursive(
        Struct.get(config, "target"),
        { 
          field: { transformNumericProperty: "target" },
          decrease: { transformNumericProperty: "target" },
          increase: { transformNumericProperty: "target" },
          stick: {
            transformNumericProperty: "target",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_duration",
      layout.nodes.duration,
      Struct.appendRecursive(
        Struct.get(config, "duration"),
        {
          label: {
            text: "Duration",
            color: VETheme.color.textShadow,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
          },
          field: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
          },
          decrease: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
          },
          increase: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
          },
          stick: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
          },
        },
        false
      )
    ).forEach(addItem, items)

    factorySpinSelect(
      $"{name}_ease",
      layout.nodes.ease,
      {
        label: {
          text: "Ease",
          enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
        },
        previous: { 
          enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
          store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
        },
        preview: { 
          enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
          store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
        },
        next: { 
          enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
          store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
        },
      },
    ).forEach(addItem, items)

    return items
  },
})
#macro VisuComponents global.__VisuComponents