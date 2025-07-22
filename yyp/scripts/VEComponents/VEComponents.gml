///@package io.alkapivo.visu.editor.ui

///@static
///@type {Struct}
global.__VEComponentsUtil = {
  factory: {
    config: {
      ///@param {?Struct} [config]
      ///@return {Struct}
      increase: function(config = null) {
        return Struct.appendRecursive({
          factor: 1.0,
          callback: function() {
            var factor = Struct.get(this, "factor")
            if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
              return
            }

            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }

            var value = item.get()
            if (!Core.isType(value, Number)) {
              return
            }

            item.set(value + factor)
          },
          store: {
            callback: Lambda.passthrough,
            set: Lambda.passthrough,
          },
        }, config, false)
      },

      ///@param {?Struct} [config]
      ///@return {Struct}
      decrease: function(config = null) {
        return Struct.appendRecursive({
          factor: -1.0,
          callback: function() {
            var factor = Struct.get(this, "factor")
            if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
              return
            }

            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }

            var value = item.get()
            if (!Core.isType(value, Number)) {
              return
            }

            item.set(value + factor)
          },
          store: {
            callback: Lambda.passthrough,
            set: Lambda.passthrough,
          },
        }, config, false)
      },

      ///@param {?Struct} [config]
      ///@return {Struct}
      increaseNumericProperty: function(config = null) {
        return Struct.appendRecursive({
          factor: 1.0,
          callback: function() {
            var factor = Struct.get(this, "factor")
            if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
              return
            }
  
            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }
  
            var key = Struct.get(this, "transformNumericProperty")
            var transformer = item.get()
            if (!Core.isType(transformer, NumberTransformer) 
                || !Struct.contains(transformer, key)) {
              return 
            }
  
            Struct.set(transformer, key, Struct.get(transformer, key) + factor)
            item.set(transformer)
          },
          store: {
            callback: Lambda.passthrough,
            set: Lambda.passthrough,
          },
        }, config, false)
      },

      ///@param {?Struct} [config]
      ///@return {Struct}
      decreaseNumericProperty: function(config = null) {
        return Struct.appendRecursive({
          factor: -1.0,
          callback: function() {
            var factor = Struct.get(this, "factor")
            if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
              return
            }
  
            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }
  
            var key = Struct.get(this, "transformNumericProperty")
            var transformer = item.get()
            if (!Core.isType(transformer, NumberTransformer) 
                || !Struct.contains(transformer, key)) {
              return 
            }
  
            Struct.set(transformer, key, Struct.get(transformer, key) + factor)
            item.set(transformer)
          },
          store: {
            callback: Lambda.passthrough,
            set: Lambda.passthrough,
          },
        }, config, false)
      },

      ///@param {?Struct} [config]
      ///@return {Struct}
      increaseVecProperty: function(config = null) {
        return Struct.appendRecursive({
          factor: 1.0,
          callback: function() {
            var factor = Struct.get(this, "factor")
            if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
              return
            }

            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }

            var vec = Struct.get(this, "transformVectorProperty")
            var vecTransformer = item.get()
            if (!Optional.is(vecTransformer) 
              || !Struct.contains(vecTransformer, vec)) {
              return 
            }

            var key = Struct.get(this, "transformNumericProperty")
            var transformer = Struct.get(vecTransformer, vec)
            if (!Core.isType(transformer, NumberTransformer) 
                || !Struct.contains(transformer, key)) {
              return 
            }

            Struct.set(transformer, key, Struct.get(transformer, key) + factor)
            item.set(vecTransformer)
          },
          store: {
            callback: Lambda.passthrough,
            set: Lambda.passthrough,
          },
        }, config, false)
      },

      ///@param {?Struct} [config]
      ///@return {Struct}
      decreaseVecProperty: function(config = null){
        return Struct.appendRecursive({
          factor: -1.0,
          callback: function() {
            var factor = Struct.get(this, "factor")
            if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
              return
            }

            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }

            var vec = Struct.get(this, "transformVectorProperty")
            var vecTransformer = item.get()
            if (!Optional.is(vecTransformer) 
              || !Struct.contains(vecTransformer, vec)) {
              return 
            }

            var key = Struct.get(this, "transformNumericProperty")
            var transformer = Struct.get(vecTransformer, vec)
            if (!Core.isType(transformer, NumberTransformer) 
                || !Struct.contains(transformer, key)) {
              return 
            }

            Struct.set(transformer, key, Struct.get(transformer, key) + factor)
            item.set(vecTransformer)
          },
          store: {
            callback: Lambda.passthrough,
            set: Lambda.passthrough,
          },
        }, config, false)
      },

      ///@param {?Struct} [config]
      ///@return {Struct}
      numberStick: function(config = null) {
        return Struct.appendRecursive({
          factor: 1.0,
          step: 5,
          treshold: 32,
          value: 0.25,
          minValue: 0.0,
          maxValue: 0.5,
          deltaX: 0.0,
          deltaY: 0.0,
          base: null,
          mouseX: null,
          mouseY: null,
          tempValue: null,
          colorHoverOver: VETheme.color.textFocus,
          colorHoverOut: VETheme.color.textShadow,
          progress: {
            thickness: 1.15,
            blend: VETheme.color.stick,
            line: { name: "texture_grid_line_bold" },
          },
          pointer: {
            name: "texture_slider_pointer_border",//"texture_slider_pointer_simple",
            scaleX: 0.15,
            scaleY: 0.15,
            blend: VETheme.color.textShadow,
          },
          background: {
            thickness: 0.0000,
            blend: VETheme.color.stickBackground,
            line: { name: "texture_grid_line_bold" },
          },
          store: {
            callback: Lambda.passthrough,
            set: function(value) {
              var item = this.get()
              if (!Optional.is(item)) {
                return 
              }

              var parsedValue = NumberUtil.parse(value, null)
              if (!Optional.is(parsedValue)) {
                return
              }

              item.set(parsedValue)
            },
          },
          getValue: function(uiItem) {
            return uiItem.store.getValue()
          },
          updateValue: function(mouseX, mouseY) {
            if (!Optional.is(this.store) || !Optional.is(this.context)) {
              return
            }

            var distanceX = mouseX - this.area.getX() + (this.area.getWidth() / 2.0) + this.context.offset.x
            var distanceY = this.area.getY() + (this.area.getHeight() / 2.0) + this.context.offset.y - mouseY
            if (!Optional.is(this.mouseX) || !Optional.is(this.mouseY)) {
              this.mouseX = distanceX
              this.mouseY = distanceY
            }

            this.deltaX = distanceX - this.mouseX
            this.deltaY = distanceY - this.mouseY
            var delta = abs(this.deltaX) > abs(this.deltaY) ? this.deltaX : this.deltaY
            var distance = round(delta / this.step)
            var increase = clamp(floor(Math.pow((abs(distance) / this.treshold), 2.0)), 1.0, MAX_INT_64)

            this.base = Optional.is(this.base) ? this.base : this.getValue(this)
            this.value = this.base + (distance * increase * this.factor)
            if (this.value != this.getValue(this)) {
              this.store.set(this.value)
            }
          },
          onMouseHoverOver: function(event) {
            if (Struct.get(this.enable, "value") == false) {
              this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
              return
            }

            this.pointer.setBlend(ColorUtil.parse(this.colorHoverOver).toGMColor())
          },
          onMouseHoverOut: function(event) {
            if (Struct.get(Struct.get(this.getClipboard(), "state"), "context") == this) {
              return
            }

            this.pointer.setBlend(ColorUtil.parse(this.colorHoverOut).toGMColor())
          },
          onMousePressedLeft: function(event) {
            this.base = null
            this.mouseX = null
            this.mouseY = null

            if (Struct.get(this.enable, "value") == false || Optional.is(this.getClipboard())) {
              return
            }
      
            var context = this
            context.setClipboard(new Promise()
              .setState({
                context: context,
                callback: Struct.get(context, "callback"),
              })
              .whenSuccess(function() {
                var context = this.state.context
                context.base = null
                context.mouseX = null
                context.mouseY = null
                context.deltaX = 0.0
                context.deltaY = 0.0
                context.pointer.setBlend(ColorUtil.parse(context.colorHoverOut).toGMColor())
                Callable.run(this.state.callback, context)
              })
              .whenFailure(function() {
                var context = this.state.context
                context.base = null
                context.mouseX = null
                context.mouseY = null
                context.deltaX = 0.0
                context.deltaY = 0.0
                context.pointer.setBlend(ColorUtil.parse(context.colorHoverOut).toGMColor())
              })
            )
          },
          onMouseDragLeft: function(event) { },
          render: function() {
            var promise = this.getClipboard()
            if (Struct.get(Struct.get(promise, "state"), "context") == this) {
              var offsetX = Core.isType(Struct.get(this.context, "layout"), UILayout)
                ? this.context.layout.x() 
                : 0.0
              var offsetY = Core.isType(Struct.get(this.context, "layout"), UILayout)
                ? this.context.layout.y() 
                : 0.0
              this.updateValue(MouseUtil.getMouseX() - offsetX, MouseUtil.getMouseY() - offsetY)
            }
            
            if (Optional.is(this.preRender)) {
              this.preRender()
            }
            this.renderBackgroundColor()
            
            var areaWidth = this.area.getWidth()
            var areaHeight = this.area.getHeight()
            var maxSize = max(GuiWidth(), GuiHeight())
            var fromX = this.context.area.getX() + this.area.getX() + (areaWidth / 2.0)
            var fromY = this.context.area.getY() + this.area.getY() + (areaHeight / 2.0)
            var widthMax = this.area.getWidth()
            var distanceX = clamp((this.deltaX / maxSize) * areaWidth, -1.0 * areaWidth / 2.0, areaWidth / 2.0)
            var distanceY = clamp((-1.0 * this.deltaY / maxSize) * areaHeight , -1.0 * areaHeight / 2.0, areaHeight / 2.0)
            //this.background.render(fromX - (areaWidth / 2.0), fromY - (areaHeight / 2.0), fromX + (areaWidth / 2.0), fromY + (areaHeight / 2.0))
            this.progress.render(fromX, fromY, fromX + distanceX, fromY + distanceY)
            this.pointer.render(fromX + distanceX, fromY + distanceY)
      
            if (Optional.is(this.postRender)) {
              this.postRender()
            }
            
            return this
          },
        }, config, false)
      }
    }
  }
}
#macro VEComponentsUtil global.__VEComponentsUtil


///@static
///@type {Map<String, Callable>}
global.__VEComponents = new Map(String, Callable, {
  
  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.button,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("category-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"text_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "bar-title": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"{name}_bar-title", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("bar-title"),
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
  "template-add-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_template-add-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.button,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              onMouseHoverOver: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOverBackground")),
              onMouseHoverOut: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOutBackground")),
            }, 
            VEStyles.get("template-add-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "collection-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_type-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
              onMouseHoverOver: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOverBackground")),
              onMouseHoverOut: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOutBackground")),
            }, 
            VEStyles.get("collection-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "context-menu-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_type-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
              onMouseHoverOver: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOverBackground")),
              onMouseHoverOut: Callable.run(UIUtil.mouseEventTemplates.get("onMouseHoverOutBackground")),
              shortcut: null,
              //render: Callable.run(UIUtil.renderTemplates.get("renderContextMenuButton")),
              render: function() {
                if (Optional.is(this.preRender)) {
                  this.preRender()
                }

                if (Optional.is(Struct.get(this, "shortcut")) && !Core.isType(this.shortcut, UILabel)) {
                  this.shortcut = new UILabel(this.shortcut)
                }

                var enableFactor = (Struct.get(this.enable, "value") == false ? 0.5 : 1.0)
                var _backgroundAlpha = this.backgroundAlpha
                this.backgroundAlpha *= enableFactor
                this.renderBackgroundColor()
                this.backgroundAlpha = _backgroundAlpha

                if (this.sprite != null) {
                  var spriteAlpha = this.sprite.getAlpha()
                  this.sprite
                    .setAlpha(spriteAlpha * enableFactor)
                    .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                    .render(
                      this.context.area.getX() + this.area.getX(),
                      this.context.area.getY() + this.area.getY())
                    .setAlpha(spriteAlpha)
                }

                if (this.label != null) {
                  var labelAlpha = this.label.alpha
                  this.label.alpha *= enableFactor
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + 14,
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2),
                    this.area.getWidth(),
                    this.area.getHeight()
                  )
                  this.label.alpha = labelAlpha
                }

                if (this.shortcut != null) {
                  var shortcutAlpha = this.shortcut.alpha
                  this.shortcut.alpha *= enableFactor
                  this.shortcut.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + this.area.getWidth() - 14,
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2),
                    this.area.getWidth(),
                    this.area.getHeight()
                  )
                  this.shortcut.alpha = shortcutAlpha
                }

                if (this.postRender != null) {
                  this.postRender()
                }
                
                return this
              },
            }, 
            VEStyles.get("context-menu-button"),
            true
          ),
          config,
          true
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field-intent": function(name, layout, config = null) {
    var items = new Array(UIItem, [
      UIImage(
        $"{name}_preview",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.preview,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "preview"),
          false
        )
      )
    ])

    if (Struct.contains(config, "resolution")) {
      items.add(UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout.nodes.resolution,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          Struct.appendRecursive(
            Struct.appendRecursive(
              { 
                store: { 
                  callback: function(value, data) {
                    if (!Core.isType(value, Sprite)) {
                      return
                    }
  
                    data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                  },
                  set: function(value) { },
                }
              },
              VEStyles.get("texture-field-ext").resolution,
              false
            ),
            Struct.get(config, "resolution"),
            false
          ),
          false
        )
      ))
    }

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "line-h": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIImage(
        $"{name}_line-h",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.image,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.appendRecursiveUnique(
            Struct.get(config, "image"),
            VEStyles.get("line-h").image,
            false
          ),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "line-w": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIImage(
        $"{name}_line-w",
        Struct.appendRecursive(
          { 
            layout: layout.nodes.image,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.appendRecursive(
            Struct.get(config, "image"),
            VEStyles.get("line-w").image,
            false
          ),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {Struct} config
  ///@return {Array<UIItem>}
  "label": function(name, layout, config) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("label").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {Struct} config
  ///@return {Array<UIItem>}
  "checkbox": function(name, layout, config) {
    return new Array(UIItem, [
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("checkbox"),
            false
          ),
          Struct.get(config, "checkbox"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "category-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_category-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              notify: true,
              layout: layout,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("category-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },


  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "type-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_type-button", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              notify: true,
              layout: layout,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("type-button"),
            false
          ),
          config,
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "channel-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_channel-entry_settings", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.settings,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").settings,
            false
          ),
          Struct.get(config, "settings"),
          false
        )
      ),
      UIButton(
        $"{name}_channel-entry_remove", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.remove,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").remove,
            false
          ),
          Struct.get(config, "remove"),
          false
        )
      ),
      UIText(
        $"{name}_channel-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"{name}_channel-entry_mute", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.mute,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("channel-entry").mute,
            false
          ),
          Struct.get(config, "mute"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "brush-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIImage(
        $"{name}_brush-entry_image",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.image,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("brush-entry").image,
            false
          ),
          Struct.get(config, "image"),
          false
        )
      ),
      UIText(
        $"{name}_brush-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("brush-entry").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UIButton(
        $"{name}_brush-entry_select", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.select,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("brush-entry").select,
            false
          ),
          Struct.get(config, "select"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "template-entry": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_template-entry_settings", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.settings,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry").settings,
            false
          ),
          Struct.get(config, "settings"),
          false
        )
      ),
      UIButton(
        $"{name}_template-entry_remove", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.remove,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry").remove,
            false
          ),
          Struct.get(config, "remove"),
          false
        )
      ),
      UIText(
        $"{name}_template-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry").label,
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
  "template-entry-lock": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIButton(
        $"{name}_template-entry-lock-entry_settings", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.settings,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry-lock").settings,
            false
          ),
          Struct.get(config, "settings"),
          false
        )
      ),
      UIButton(
        $"{name}_template-entry-lock-entry_remove", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.remove,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry-lock").remove,
            false
          ),
          Struct.get(config, "remove"),
          false
        )
      ),
      UIText(
        $"{name}_template-entry-lock-entry_label",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyCollectionLayout")),
            }, 
            VEStyles.get("template-entry-lock").label,
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
  "property": function(name, layout, config = null) {
    var style = VEStyles.get("property")
    return new Array(UIItem, [
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "checkbox"),
            false
          ),
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_text", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            Struct.get(style, "label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"{name}_input", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.input,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "input"),
            false
          ),
          Struct.get(config, "input"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "property-bar": function(name, layout, config = null) {
    var style = VEStyles.get("property-bar")
    return new Array(UIItem, [
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "checkbox"),
            false
          ),
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_text", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            Struct.get(style, "label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"{name}_input", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.input,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            Struct.get(style, "input"),
            false
          ),
          Struct.get(config, "input"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-simple": function(name, layout, config = null) {
    return new Array(UIItem, [
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-simple").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-area": function(name, layout, config = null) {
    return new Array(UIItem, [
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-area").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      )
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-button": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"button_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.button,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field-button").button,
            false
          ),
          Struct.get(config, "button"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-increase-checkbox": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UIButton(
        $"{name}_increase", 
        Struct.appendRecursive(
          { 
            factor: 1.0,
            label: { 
              text: "+",
              font: "font_inter_10_regular",
              useScale: false,
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.increase,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "increase"),
          false
        )
      ),
      UIButton(
        $"{name}_decrease", 
        Struct.appendRecursive(
          { 
            factor: -1.0,
            label: {
              text: "-",
              font: "font_inter_10_regular",
              useScale: false,
              color: VETheme.color.textFocus,
              align: { v: VAlign.CENTER, h: HAlign.CENTER },
            },
            backgroundColor: VETheme.color.button,
            backgroundColorSelected: VETheme.color.buttonHover,
            backgroundColorOut: VETheme.color.button,
            layout: layout.nodes.decrease,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }
              item.set(item.get() + factor)
            },
            onMouseHoverOver: function(event) {
              
              if (Struct.get(this.enable, "value") == false) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                return
              }
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
          },
          Struct.get(config, "decrease"),
          false
        )
      ),
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.checkbox,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_title", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.title,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-checkbox").title,
            false
          ),
          Struct.get(config, "title"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "text-field-increase-stick-checkbox": function(name, layout, config = null) {
    var items = new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-button").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field-button").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.checkbox,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "checkbox"),
          false
        )
      ),
      UIText(
        $"{name}_title", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.title,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field-checkbox").title,
            false
          ),
          Struct.get(config, "title"),
          false
        )
      ),
    ])

    if (Core.getProperty("visu.editor.ui.components.numeric-button")) {
      items
        .add(UIButton(
          $"{name}_increase", 
          Struct.appendRecursive(
            { 
              factor: 1.0,
              label: { 
                text: "+",
                font: "font_inter_10_regular",
                useScale: false,
                color: VETheme.color.textFocus,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
              },
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              layout: layout.nodes.increase,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                item.set(item.get() + factor)
              },
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
            },
            Struct.get(config, "increase"),
            false
          )
        ))
        .add(UIButton(
          $"{name}_decrease", 
          Struct.appendRecursive(
            { 
              factor: -1.0,
              label: {
                text: "-",
                font: "font_inter_10_regular",
                useScale: false,
                color: VETheme.color.textFocus,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
              },
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              layout: layout.nodes.decrease,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }
                item.set(item.get() + factor)
              },
              onMouseHoverOver: function(event) {
                
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
            },
            Struct.get(config, "decrease"),
            false
          )
        ))
    }

    if (Core.getProperty("visu.editor.ui.components.numeric-stick")) {
      items.add(UISliderHorizontal(
        $"stick_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.stick,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "stick"),
          false
        )
      ))
    }
    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "double-checkbox": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").label,
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"checkbox1_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox1,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").checkbox1,
            false
          ),
          Struct.get(config, "checkbox1"),
          false
        )
      ),
      UIText(
        $"label1_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label1,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").label1,
            false
          ),
          Struct.get(config, "label1"),
          false
        )
      ),
      UICheckbox(
        $"checkbox2_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.checkbox2,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").checkbox2,
            false
          ),
          Struct.get(config, "checkbox2"),
          false
        )
      ),
      UIText(
        $"label2_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label2,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("double-checkbox").label2,
            false
          ),
          Struct.get(config, "label2"),
          false
        )
      ),
    ])
  },
  
  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-slider-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UISliderHorizontal(
        $"slider_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.slider,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "slider"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-slider-increase-field": function(name, layout, config = null) {
    var items = new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UITextField(
        $"field_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.field,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            },
            VEStyles.get("text-field").field,
            false
          ),
          Struct.get(config, "field"),
          false
        )
      ),
      UISliderHorizontal(
        $"slider_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: Assert.isType(Struct.get(layout.nodes, "slider"), Struct),
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "slider"),
          false
        )
      ),
    ])

    if (Core.getProperty("visu.editor.ui.components.numeric-button")) {
      items
        .add(UIButton(
          $"{name}_increase", 
          Struct.appendRecursive(
            { 
              factor: 1.0,
              label: { 
                text: "+",
                font: "font_inter_10_regular",
                useScale: false,
                color: VETheme.color.textFocus,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
              },
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              layout: layout.nodes.increase,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                item.set(item.get() + factor)
              },
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
            },
            Struct.get(config, "increase"),
            false
          )
        ))
        .add(UIButton(
          $"{name}_decrease", 
          Struct.appendRecursive(
            { 
              factor: -1.0,
              label: {
                text: "-",
                font: "font_inter_10_regular",
                useScale: false,
                color: VETheme.color.textFocus,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
              },
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              layout: layout.nodes.decrease,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }
                item.set(item.get() + factor)
              },
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
            },
            Struct.get(config, "decrease"),
            false
          )
        ))
    }

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-slider": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            }, 
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UISliderHorizontal(
        $"slider_{name}",
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: Assert.isType(Struct.get(layout.nodes, "slider"), Struct),
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
            },
            VEStyles.get("slider-horizontal"),
            false
          ),
          Struct.get(config, "slider"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "boolean-field": function(name, layout, config = null) {
    return new Array(UIItem, [
      UIText(
        $"label_{name}", 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              layout: layout.nodes.label,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
            false
          ),
          Struct.get(config, "label"),
          false
        )
      ),
      UICheckbox(
        $"{name}_checkbox", 
        Struct.appendRecursive(
          { 
            layout: layout.nodes.field,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          }, 
          Struct.get(config, "field"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryTitle = function(name, layout, config) {
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
    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryTextFieldIncreaseCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-checkbox"),
        layout: VELayouts.get("text-field-increase-checkbox"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryNumericSliderIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    var items = new Array(UIItem)

    factoryTextField(
      $"{name}_texture",
      layout.nodes.texture, 
      Struct.appendRecursive(
        { 
          label: { text: "Texture" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }
                
                data.textField.setText(value.texture.name)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item) || !TextureUtil.exists(value)) {
                  return
                }

                var json = item.get().serialize()
                json.name = value
                item.set(SpriteUtil.parse(json))
              },
            }
          }
        }, 
        Struct.get(config, "texture"),
        false
      )
    ).forEach(addItem, items)
    
    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            },
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    factoryTextFieldIncreaseCheckbox(
      $"{name}_frame",
      layout.nodes.frame, 
      Struct.appendRecursive(
        { 
          label: { text: "Frame" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite) || !Core.isType(data, UIItem)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                var frame = value.getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                data.textField.setText(frame)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                var frame = sprite.setFrame(NumberUtil.parse(value, sprite.getFrame())).getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          increase: { 
            factor: 1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getRandomFrame()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                item.set(sprite.setRandomFrame(value))
              },
            }
          },
          title: { text: "Rng frame" }, 
        },
        Struct.get(config, "frame"),
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncreaseCheckbox(
      $"{name}_speed",
      layout.nodes.speed, 
      Struct.appendRecursive(
        { 
          label: { text: "Speed" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getSpeed())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setSpeed(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getAnimate()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }
                
                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                item.set(sprite.setAnimate(value))
              },
            }
          },
          title: { text: "Animate" },
        },
        Struct.get(config, "speed"),
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_alpha",
      layout.nodes.alpha, 
      Struct.appendRecursive(
        { 
          label: { text: "Alpha" },
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getAlpha())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.value = value.getAlpha()
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            },
          },
        },
        Struct.get(config, "alpha"),
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field-simple": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}}
    static factoryTitle = function(name, layout, config) {
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
    ///@return {Array<UIItem>}}
    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}}
    static factoryTextFieldIncreaseStickCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-stick-checkbox"),
        layout: VELayouts.get("text-field-increase-stick-checkbox"),
        config: Struct.appendRecursive(
          {
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
            },
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

                  var key = Struct.get(this.context, "spriteProperty")
                  var sprite = item.get()
                  if (!Core.isType(sprite, Sprite) 
                    || !Struct.contains(sprite, key)) {
                    return 
                  }
                  item.set(Struct.set(sprite, key, parsedValue))
                },
                getValue: function() {
                  var key = Struct.get(this.context, "spriteProperty")
                  if (!Optional.is(key)) {
                    return null
                  }

                  var item = this.get()
                  if (!Optional.is(item)) {
                    return null
                  }

                  var sprite = item.get()
                  if (!Optional.is(sprite)) {
                    return
                  }
                  
                  return Struct.get(sprite, key)
                },
              },
            }),
            checkbox: {
              //margin: { top: 2, bottom: 2, left: 2, right: 2 },
            },
          },
          config, 
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    factoryTitle(
      $"{name}_title", 
      layout.nodes.title, 
      Struct.get(config, "title")
    ).forEach(addItem, items)

    factoryTextField(
      $"{name}_texture",
      layout.nodes.texture, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }
                
                data.textField.setText(value.texture.name)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item) || !TextureUtil.exists(value)) {
                  return
                }

                var json = item.get().serialize()
                json.name = value
                item.set(SpriteUtil.parse(json))
              },
            }
          }
        }, 
        Struct.get(config, "texture"),
        false
      )
    ).forEach(addItem, items)
    
    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            },
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_frame",
      layout.nodes.frame, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite) || !Core.isType(data, UIItem)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                var frame = value.getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                data.textField.setText(frame)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                var frame = sprite.setFrame(NumberUtil.parse(value, sprite.getFrame())).getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          increase: { 
            factor: 1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getRandomFrame()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                item.set(sprite.setRandomFrame(value))
              },
            }
          },
          title: { text: "Rng frame" }, 
          stick: { spriteProperty: "frame" },
        },
        Struct.get(config, "frame"),
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_speed",
      layout.nodes.speed, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getSpeed())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setSpeed(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getAnimate()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }
                
                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                item.set(sprite.setAnimate(value))
              },
            }
          },
          title: { text: "Animate" },
          stick: { spriteProperty: "speed" },
        },
        Struct.get(config, "speed"),
        false
      )
    ).forEach(addItem, items)
    
    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "texture-field-ext": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}}
    static factoryTitle = function(name, layout, config) {
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
    ///@return {Array<UIItem>}}
    static factoryTextField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field"),
        layout: VELayouts.get("text-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}}
    static factoryNumericSliderIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: config,
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryTextFieldIncreaseStickCheckbox = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-increase-stick-checkbox"),
        layout: VELayouts.get("text-field-increase-stick-checkbox"),
        config: Struct.appendRecursive(
          {
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
            },
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

                  var key = Struct.get(this.context, "spriteProperty")
                  var sprite = item.get()
                  if (!Core.isType(sprite, Sprite) 
                    || !Struct.contains(sprite, key)) {
                    return 
                  }
                  item.set(Struct.set(sprite, key, parsedValue))
                },
                getValue: function() {
                  var key = Struct.get(this.context, "spriteProperty")
                  if (!Optional.is(key)) {
                    return null
                  }

                  var item = this.get()
                  if (!Optional.is(item)) {
                    return null
                  }

                  var sprite = item.get()
                  if (!Optional.is(sprite)) {
                    return
                  }
                  
                  return Struct.get(sprite, key)
                },
              },
            }),
            checkbox: {
              //margin: { top: 2, bottom: 2, left: 2, right: 2 },
            },
          },
          config, 
          false
        )
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    //factoryTitle(
    //  $"{name}_title", 
    //  layout.nodes.title, 
    //  Struct.get(config, "title")
    //).forEach(addItem, items)

    factoryTextField(
      $"{name}_texture",
      layout.nodes.texture, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }
                
                data.textField.setText(value.texture.name)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item) || !TextureUtil.exists(value)) {
                  return
                }

                var json = item.get().serialize()
                json.name = value
                item.set(SpriteUtil.parse(json))
              },
            }
          }
        }, 
        Struct.get(config, "texture"),
        false
      )
    ).forEach(addItem, items)
    
    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            },
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    factoryNumericSliderIncreaseField(
      $"{name}_alpha",
      layout.nodes.alpha, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getAlpha())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setAlpha(sprite.getAlpha() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          slider: { 
            minValue: 0.0,
            maxValue: 1.0,
            snapValue: 0.01 / 1.0,
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.value = value.getAlpha()
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                sprite.setAlpha(NumberUtil.parse(value))
                item.set(sprite)
              },
            },
          },
        },
        Struct.get(config, "alpha"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_frame",
      layout.nodes.frame, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite) || !Core.isType(data, UIItem)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                var frame = value.getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                data.textField.setText(frame)
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                var frame = sprite.setFrame(NumberUtil.parse(value, sprite.getFrame())).getFrame()
                Struct.set(value, "_restoreFrame", frame)
                Struct.set(value, "_frame", frame)
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          increase: { 
            factor: 1.0,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              var frame = sprite.setFrame(sprite.getFrame() + factor).getFrame()
              Struct.set(sprite, "_restoreFrame", frame)
              Struct.set(sprite, "_frame", frame)
              item.set(sprite)
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            },
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getRandomFrame()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }

                item.set(sprite.setRandomFrame(value))
              },
            }
          },
          title: { text: "Rng frame" },
          stick: { spriteProperty: "frame" },
        },
        Struct.get(config, "frame"),
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_speed",
      layout.nodes.speed, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getSpeed())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setSpeed(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.5,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setSpeed(sprite.getSpeed() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          checkbox: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                data.value = value.getAnimate()
              },
              set: function(value) { 
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }
                
                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                item.set(sprite.setAnimate(value))
              },
            }
          },
          title: { text: "Animate" },
          stick: { spriteProperty: "speed" },
        },
        Struct.get(config, "speed"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_scale_x",
      layout.nodes.scaleX, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                
                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getScaleX())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setScaleX(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleX(sprite.getScaleX() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleX(sprite.getScaleX() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          stick: { spriteProperty: "scaleX" },
        },
        Struct.get(config, "scaleX"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_scale_y",
      layout.nodes.scaleY, 
      Struct.appendRecursive(
        { 
          field: { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }

                if (data.textField.isFocused()) {
                  return
                }

                data.textField.setText(value.getScaleY())
              },
              set: function(value) {
                var item = this.get()
                if (!Optional.is(item)) {
                  return
                }

                var sprite = item.get()
                if (!Core.isType(sprite, Sprite)) {
                  return
                }
                
                sprite.setScaleY(NumberUtil.parse(value))
                item.set(sprite)
              },
            }
          },
          decrease: { 
            factor: -0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleY(sprite.getScaleY() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          increase: { 
            factor: 0.01,
            callback: function() {
              var factor = Struct.get(this, "factor")
              if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                return
              }

              var item = this.store.get()
              if (!Core.isType(item, StoreItem)) {
                return
              }

              var sprite = item.get()
              if (!Core.isType(sprite, Sprite)) {
                return
              }

              item.set(sprite.setScaleY(sprite.getScaleY() + factor))
            },
            store: { 
              callback: function(value, data) { },
              set: function(value) { },
            }
          },
          stick: { spriteProperty: "scaleY" },
        },
        Struct.get(config, "scaleY"),
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "preview-image-mask": function(name, layout, config = null) {
    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryImage = function(name, layout, config) {
      var uiImage = UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            preRender: function() {
              if (this.image == null) {
                return
              }

              Struct.inject(this.image, "_restoreFrame", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_frame2", this.image.getFrame()))
            },
            postRender: function() {
              if (this.image == null) {
                return
              }

              Struct.set(this.image, "_frame2", this.image.getFrame())
              this.image.setFrame(Struct.inject(this.image, "_restoreFrame", this.image.getFrame()))
            },
          },
          config,
          false
        )
      )

      Struct.set(uiImage, "_render", uiImage.render)
      uiImage.render = method(uiImage, function() {
        this._render()

        if (!Optional.is(this.mask)) {
          return
        }

        if (!Optional.is(this.store) || this.store.getStore() == null) {
          return
        }

        var mask = this.store.getStore().getValue(this.mask)
        if (!Optional.is(mask)) {
          return
        }

        //mask.setX(clamp(mask.getX(), 0, this.image.getWidth()))
        //mask.setY(clamp(mask.getY(), 0, this.image.getHeight()))
        //mask.setWidth(clamp(mask.getWidth(), 0, this.image.getWidth() - mask.getX()))
        //mask.setHeight(clamp(mask.getHeight(), 0, this.image.getHeight() - mask.getY()))

        var alpha = Struct.get(this.enable, "value") == false ? 0.25 : 0.75
        var scaleX = this.image.getScaleX()
        var scaleY = this.image.getScaleY()
        this.image.scaleToFit(this.area.getWidth(), this.area.getHeight())
        var _x = this.context.area.getX() 
          + this.area.getX()
          + (this.area.getWidth() / 2.0)
          - ((image.getWidth() * image.getScaleX()) / 2.0)
          + (mask.getX() * image.getScaleX())
        var _y = this.context.area.getY() 
          + this.area.getY()
          + (this.area.getHeight() / 2.0)
          - ((image.getHeight() * image.getScaleY()) / 2.0)
          + (mask.getY() * image.getScaleY())
        var width = mask.getWidth() * image.getScaleX()
        var height = mask.getHeight() * image.getScaleY()
        this.image.setScaleX(scaleX).setScaleY(scaleY)

        if (width < 1 || height < 1) {
          return
        }
        GPU.render.rectangle(
          _x,
          _y,
          _x + width,
          _y + height,
          false,
          c_black,
          c_black,
          c_black,
          c_black,
          alpha
        )
        GPU.render.rectangle(
          _x,
          _y,
          _x + width,
          _y + height,
          true,
          c_red,
          c_red,
          c_red,
          c_red,
          alpha
        )
      })

      return uiImage
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryLabel = function(name, layout, config) {
      return UIText(
        name,
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          },
          config,
          false
        )
      )
    }

    var items = new Array(UIItem)

    items.add(
      factoryImage(
        $"{name}_preview", 
        layout.nodes.preview, 
        Struct.appendRecursive(
          { 
            store: { 
              callback: function(value, data) {
                if (!Core.isType(value, Sprite)) {
                  return
                }
                data.image = value
              },
              set: function(value) { },
            }
          },
          Struct.get(config, "preview"),
          false
        )
      )
    )

    items.add(
      factoryLabel(
        $"{name}_resolution", 
        layout.nodes.resolution, 
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              store: { 
                callback: function(value, data) {
                  if (!Core.isType(value, Sprite)) {
                    return
                  }

                  data.label.text = $"width: {value.getWidth()} height: {value.getHeight()}"
                },
                set: function(value) { },
              }
            },
            VEStyles.get("texture-field-ext").resolution,
            false
          ),
          Struct.get(config, "resolution"),
          false
        )
      )
    )

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "color-picker": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryTitle = function(name, layout, config) {
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
    ///@return {UIItem}
    static factoryHex = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-button"),
        layout: VELayouts.get("text-field-square-center-button"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  data.textField.setText(value.toHex(value.alpha < 1.0))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var color = item.get()
                  item.set(ColorUtil.fromHex(value, color.toHex(color.alpha < 1.0)))
                },
              },
            },
            button: {
              store: {
                callback: function(value, data) { 
                  var factor = Struct.get(data.enable, "value") == false ? 0.5 : 1.0
                  data.backgroundAlpha = value.alpha * factor
                  data.backgroundColor = value.toGMColor()
                },
                set: function(value) { return },
              },
            }
          },
          false
        ),
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryColorIncreaseField = function(name, layout, config) {
      static factoryStore = {
        callbackField: function() {
          return function(value, data) { 
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.textField.setText(clamp(round(Struct.get(value, key) * 255.0), 0.0, 255.0))
          }
        },
        callbackSlider: function() {
          return function(value, data) {
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            Struct.set(data, "_color", value)            
            data.value = clamp(round(Struct.get(value, key) * 255.0), 0.0, 255.0)
            data.updateCustom()
          }
        },
        set: function() {
          return function(value) {
            var item = this.get()
            var key = Struct.get(this.context, "colorChannel")
            if (item == null || !ColorUtil.isColorProperty(key)) {
              return 
            }

            var color = item.get()
            item.set(Struct.set(color, key, clamp(NumberUtil
              .parse(value / 255.0, Struct.get(color, key)), 0.0, 1.0)))
          }
        },
      }

      static factoryIncrease = function(config, factor) {
        return {
          factor: factor,
          enable: Optional.is(Struct.getIfType(config.field, "enable", Struct)) 
            ? JSON.clone(config.field.enable) 
            : null,
          hidden: Optional.is(Struct.getIfType(config.field, "hidden", Struct)) 
            ? JSON.clone(config.field.hidden) 
            : null,
          colorChannel: Struct.get(config.field, "colorChannel" ),
          callback: function() {
            var factor = Struct.get(this, "factor")
            var key = Struct.get(this, "colorChannel")
            if (!Core.isType(factor, Number) 
                || !Core.isType(this.store, UIStore)
                || !ColorUtil.isColorProperty(key)) {
              return
            }
  
            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }
            
            var color = item.get()
            if (!Core.isType(color, Color)) {
              return 
            }
  
            Struct.set(color, key, clamp(Struct.get(color, key) + (factor / 255.0), 0.0, 1.0))
            item.set(color)
          },
          store: Struct.appendRecursive({ callback: function(value, data) { }, set: function(value) { } },
            Optional.is(Struct.get(config.field, "store")) ? JSON.clone(config.field.store) : null,
            false
          ),
        }
      }

      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: factoryStore.callbackField(),
                set: factoryStore.set(),
              },
              GMTF_DECIMAL: 0,
            },
            slider: {
              minValue: 0.0,
              maxValue: 255.0,
              snapValue: 1.0 / 255.0,
              store: {
                callback: factoryStore.callbackSlider(),
                set: factoryStore.set()
              },
              backgroundMargin: new Margin({ top: 2, bottom: 3, left: 0, right: 1 }),
              postRender: function() {
                var fromX = this.context.area.getX() + this.area.getX()
                var fromY = this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
                var widthMax = this.area.getWidth()
                var width = ((this.value - this.minValue) / abs(this.minValue - this.maxValue)) * widthMax
                var pointerBorder = Struct.get(this, "pointerBorder")
                if (!Core.isType(pointerBorder, Sprite)) {
                  pointerBorder = SpriteUtil.parse({ name: "texture_slider_pointer_border" })
                  Struct.set(this, "pointerBorder", pointerBorder)
                }
                
                var factor = Struct.get(this.enable, "value") == false ? 0.5 : 1.0    
                var alpha = pointerBorder.getAlpha()
                pointerBorder
                  .setAlpha(alpha * factor)
                  .setScaleX(this.pointer.getScaleX())
                  .setScaleY(this.pointer.getScaleY())
                  .render(fromX + width, fromY)
                  .setAlpha(alpha)
              },
              updateCustom: function() {
                var color = Struct.getIfType(this, "_color", Color)
                if (!Optional.is(color)) {
                  return
                }
                
                this.progress.blend = c_white
                this.progress.thickness = 0.0
                this.background.thickness = (this.area.getHeight() - 4.0) / 4.0
                //this.backgroundMargin = new Margin({ top: 2, bottom: 3, left: 0, right: 1})
                this.pointer.setBlend(color.toGMColor())
                this.backgroundAlpha = Struct.get(this.enable, "value") == false ? 0.5 : 1.0
                switch (Struct.get(this, "colorChannel")) {
                  case "red":
                    this.background.blend = make_color_rgb(255, color.green * 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(0, color.green * 255, color.blue * 255)
                    break
                  case "green": 
                    this.background.blend = make_color_rgb(color.red * 255, 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, 0, color.blue * 255)
                    break
                  case "blue": 
                    this.background.blend = make_color_rgb(color.red * 255, color.green * 255, 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, color.green * 255, 0)
                    break
                }
              },
              progress: {
                line: { name: "texture_empty" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
              background: {
                line: { name: "texture_slider_color_picker" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
            },
            increase: factoryIncrease(config, 1.0),
            decrease: factoryIncrease(config, -1.0),
          },
          false
        ),
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryAlphaIncreaseField = function(name, layout, config) {
      static factoryStore = {
        callbackField: function() {
          return function(value, data) { 
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.textField.setText(clamp(round(Struct.get(value, key) * 255), 0.0, 255.0))
          }
        },
        callbackSlider: function() {
          return function(value, data) {
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }
            data.value = clamp(round(Struct.get(value, key) * 255), 0.0, 255.0)
          }
        },
        set: function() {
          return function(value) {
            var item = this.get()
            var key = Struct.get(this.context, "colorChannel")
            if (item == null || !ColorUtil.isColorProperty(key)) {
              return 
            }

            var color = item.get()
            item.set(Struct.set(color, key, clamp(NumberUtil
              .parse(value / 255, Struct.get(color, key)), 0.0, 1.0)))
          }
        },
      }

      static factoryIncrease = function(config, factor) {
        return {
          factor: factor,
          enable: Optional.is(Struct.getIfType(config.field, "enable", Struct)) 
            ? JSON.clone(config.field.enable) 
            : null,
          hidden: Optional.is(Struct.getIfType(config.field, "hidden", Struct)) 
            ? JSON.clone(config.field.hidden) 
            : null,
          colorChannel: Struct.get(config.field, "colorChannel" ),
          callback: function() {
            var factor = Struct.get(this, "factor")
            var key = Struct.get(this, "colorChannel")
            if (!Core.isType(factor, Number) 
                || !Core.isType(this.store, UIStore)
                || !ColorUtil.isColorProperty(key)) {
              return
            }
  
            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }
            
            var color = item.get()
            if (!Core.isType(color, Color)) {
              return 
            }
  
            Struct.set(color, key, clamp(Struct.get(color, key) + (factor / 255.0), 0.0, 1.0))
            item.set(color)
          },
          store: Struct.appendRecursive({ callback: function(value, data) { }, set: function(value) { } },
            Optional.is(Struct.get(config.field, "store")) ? JSON.clone(config.field.store) : null,
            false
          ),
        }
      }
      
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: factoryStore.callbackField(),
                set: factoryStore.set(),
              },
              GMTF_DECIMAL: 0,
            },
            slider: {
              minValue: 0,
              maxValue: 255,
              store: {
                callback: factoryStore.callbackSlider(),
                set: factoryStore.set()
              },
            },
            increase: factoryIncrease(config, 1.0),
            decrease: factoryIncrease(config, -1.0),
          },
          false
        ),
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)
    var button = {}
    if (Struct.contains(config, "title")) {
      button = {
        layout: { 
          type: layout.type,
          propagateHidden: true,
        },
        button: Struct.appendRecursive(
          config.title.input,
          {
            enable: Optional.is(Struct.getIfType(config.hex.field, "enable", Struct)) 
              ? JSON.clone(config.hex.field.enable) 
              : null,
            store: Optional.is(Struct.get(config.hex.field, "store")) 
              ? JSON.clone(config.hex.field.store) 
              : { },
            hidden: Optional.is(Struct.getIfType(config.hex.field, "hidden", Struct)) 
              ? JSON.clone(config.hex.field.hidden) 
              : null,
          },
          false
        ),
      }

      var __input = Struct.get(config.title, "input")
      Struct.remove(config.title, "input")
      Struct.set(config.title, "layout", { type: layout.type })
      if (Struct.contains(button.button, "backgroundColor")) {
        Struct.set(config.title, "input", { backgroundColor: button.button.backgroundColor })
      }

      factoryTitle(
        $"{name}_title",
        layout.nodes.title,
        config.title
      ).forEach(addItem, items)
      Struct.set(config.title, "input", __input)
    } else {
      button = {
        layout: { 
          //type: layout.type,
          propagateHidden: true,
        },
        button: {
          enable: Optional.is(Struct.getIfType(config.hex.field, "enable", Struct)) 
            ? JSON.clone(config.hex.field.enable) 
            : null,
          store: Optional.is(Struct.get(config.hex.field, "store")) 
            ? JSON.clone(config.hex.field.store) 
            : { },
          hidden: Optional.is(Struct.getIfType(config.hex.field, "hidden", Struct)) 
            ? JSON.clone(config.hex.field.hidden) 
            : null,
        }
      }
      Struct.set(layout.nodes.title, "height", method(layout.nodes.title, function() { return 0 }))
      Struct.set(layout.nodes.title, "marginRef", new Margin())
      //Struct.set(layout.nodes.hex, function() { return this.context.y() + this.__margin.top })
    }

    factoryHex(
      $"{name}_hex",
      layout.nodes.hex,
      Struct.appendRecursive(
        button,
        Struct.get(config, "hex"),
        false
      )
      
    ).forEach(addItem, items)
        
    factoryColorIncreaseField(
      $"{name}_red",
      layout.nodes.red,
      Struct.appendRecursive(
        Struct.get(config, "red"), 
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { colorChannel: "red" }, 
          slider: { colorChannel: "red" },
          decrease: { colorChannel: "red" },
          increase: { colorChannel: "red" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColorIncreaseField (
      $"{name}_green",
      layout.nodes.green,
      Struct.appendRecursive(
        Struct.get(config, "green"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { colorChannel: "green" }, 
          slider: { colorChannel: "green" },
          decrease: { colorChannel: "green" },
          increase: { colorChannel: "green" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColorIncreaseField (
      $"{name}_blue",
      layout.nodes.blue,
      Struct.appendRecursive(
        Struct.get(config, "blue"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { colorChannel: "blue" }, 
          slider: { colorChannel: "blue" },
          decrease: { colorChannel: "blue" },
          increase: { colorChannel: "blue" },
        },
        false
      )
    ).forEach(addItem, items)

    if (Struct.contains(config, "alpha")) {
      factoryAlphaIncreaseField (
        $"{name}_alpha",
        layout.nodes.alpha,
        Struct.appendRecursive(
          Struct.get(config, "alpha"),
          {
            layout: { 
              //type: layout.type,
              propagateHidden: true,
            },
            field: { colorChannel: "alpha" }, 
            slider: { colorChannel: "alpha" },
            decrease: { colorChannel: "alpha" },
            increase: { colorChannel: "alpha" },
          },
          false
        )
      ).forEach(addItem, items)
    }

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "color-picker-transformer": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryHex = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("text-field-button"),
        layout: VELayouts.get("text-field-square-center-button"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var colorKey = Struct.get(data, "colorKey", "value")
                  var color = Struct.get(value, colorKey)
                  data.textField.setText(color.toHex(color.alpha < 1.0))
                },
                set: function(value) {
                  var item = this.get()
                  if (item == null) {
                    return 
                  }

                  var transformer = item.get()
                  var colorKey = Struct.get(this.context, "colorKey", "value")
                  var color = Struct.get(transformer, colorKey)
                  var parsedColor = ColorUtil.parse(value)
                  color.red = parsedColor.red
                  color.green = parsedColor.green
                  color.blue = parsedColor.blue
                  color.alpha = parsedColor.alpha

                  item.set(transformer)
                },
              },
            },
            button: {
              colorKey: config.field.colorKey,
              store: {
                callback: function(value, data) { 
                  var factor = Struct.get(data.enable, "value") == false ? 0.5 : 1.0
                  var colorKey = Struct.get(data, "colorKey", "value")
                  var color = Struct.get(value, colorKey)
                  data.backgroundAlpha = color.alpha * factor
                  data.backgroundColor = color.toGMColor()
                },
                set: function(value) { return },
              },
            }
          },
          false
        ),
      }).toUIItems(layout)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryColorIncreaseField = function(name, layout, config) {
      static factoryStore = {
        callbackField: function() {
          return function(value, data) { 
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }

            var colorKey = Struct.get(data, "colorKey")
            var color = Struct.get(value, colorKey)
            if (!Core.isType(color, Color)) {
              return
            }

            data.textField.setText(clamp(round(Struct.get(color, key) * 255.0), 0.0, 255.0))
          }
        },
        callbackSlider: function() {
          return function(value, data) {
            var key = Struct.get(data, "colorChannel")
            if (!ColorUtil.isColorProperty(key)) {
              return 
            }

            var colorKey = Struct.get(data, "colorKey")
            var color = Struct.get(value, colorKey)
            if (!Core.isType(color, Color)) {
              return
            }

            Struct.set(data, "_color", color)            
            data.value = clamp(round(Struct.get(color, key) * 255.0), 0.0, 255.0)
            data.updateCustom()
          }
        },
        set: function() {
          return function(value) {
            var item = this.get()
            var key = Struct.get(this.context, "colorChannel")
            if (item == null || !ColorUtil.isColorProperty(key)) {
              return 
            }

            var transformer = item.get()
            var colorKey = Struct.get(this.context, "colorKey")
            var color = Struct.get(transformer, colorKey)
            Struct.set(color, key, clamp(NumberUtil.parse(value / 255.0, Struct.get(color, key)), 0.0, 1.0))
            item.set(transformer)
          }
        },
      }

      static factoryIncrease = function(config, factor) {
        return {
          factor: factor,
          enable: Optional.is(Struct.getIfType(config.field, "enable", Struct)) 
            ? JSON.clone(config.field.enable) 
            : null,
          hidden: Optional.is(Struct.getIfType(config.field, "hidden", Struct)) 
            ? JSON.clone(config.field.hidden) 
            : null,
          colorChannel: Struct.get(config.field, "colorChannel"),
          colorKey: Struct.get(config.field, "colorKey"),
          callback: function() {
            var factor = Struct.get(this, "factor")
            var key = Struct.get(this, "colorChannel")
            if (!Core.isType(factor, Number) 
                || !Core.isType(this.store, UIStore)
                || !ColorUtil.isColorProperty(key)) {
              return
            }
  
            var item = this.store.get()
            if (!Core.isType(item, StoreItem)) {
              return
            }

            var transformer = item.get()
            var colorKey = Struct.get(this, "colorKey")
            var color = Struct.get(transformer, colorKey)
            if (!Core.isType(color, Color)) {
              return 
            }
  
            Struct.set(color, key, clamp(Struct.get(color, key) + (factor / 255.0), 0.0, 1.0))
            item.set(transformer)
          },
          store: Struct.appendRecursive({ callback: function(value, data) { }, set: function(value) { } },
            Optional.is(Struct.get(config.field, "store")) ? JSON.clone(config.field.store) : null,
            false
          ),
        }
      }

      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: Struct.appendRecursive(
          config, 
          {
            field: {
              store: {
                callback: factoryStore.callbackField(),
                set: factoryStore.set(),
              },
              GMTF_DECIMAL: 0,
            },
            slider: {
              minValue: 0.0,
              maxValue: 255.0,
              snapValue: 1.0 / 255.0,
              store: {
                callback: factoryStore.callbackSlider(),
                set: factoryStore.set()
              },
              backgroundMargin: new Margin({ top: 2, bottom: 3, left: 0, right: 1 }),
              postRender: function() {
                var fromX = this.context.area.getX() + this.area.getX()
                var fromY = this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
                var widthMax = this.area.getWidth()
                var width = ((this.value - this.minValue) / abs(this.minValue - this.maxValue)) * widthMax
                var pointerBorder = Struct.get(this, "pointerBorder")
                if (!Core.isType(pointerBorder, Sprite)) {
                  pointerBorder = SpriteUtil.parse({ name: "texture_slider_pointer_border" })
                  Struct.set(this, "pointerBorder", pointerBorder)
                }
                
                var factor = Struct.get(this.enable, "value") == false ? 0.5 : 1.0    
                var alpha = pointerBorder.getAlpha()
                pointerBorder
                  .setAlpha(alpha * factor)
                  .setScaleX(this.pointer.getScaleX())
                  .setScaleY(this.pointer.getScaleY())
                  .render(fromX + width, fromY)
                  .setAlpha(alpha)
              },
              updateCustom: function() {
                var color = Struct.getIfType(this, "_color", Color)
                if (!Optional.is(color)) {
                  return
                }
                
                this.progress.blend = c_white
                this.progress.thickness = 0.0
                this.background.thickness = (this.area.getHeight() - 4.0) / 4.0
                //this.backgroundMargin = new Margin({ top: 2, bottom: 3, left: 0, right: 1})
                this.pointer.setBlend(color.toGMColor())
                this.backgroundAlpha = Struct.get(this.enable, "value") == false ? 0.5 : 1.0
                switch (Struct.get(this, "colorChannel")) {
                  case "red":
                    this.background.blend = make_color_rgb(255, color.green * 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(0, color.green * 255, color.blue * 255)
                    break
                  case "green": 
                    this.background.blend = make_color_rgb(color.red * 255, 255, color.blue * 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, 0, color.blue * 255)
                    break
                  case "blue": 
                    this.background.blend = make_color_rgb(color.red * 255, color.green * 255, 255)
                    this.backgroundColor = make_color_rgb(color.red * 255, color.green * 255, 0)
                    break
                }
              },
              progress: {
                line: { name: "texture_empty" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
              background: {
                line: { name: "texture_slider_color_picker" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              },
            },
            increase: factoryIncrease(config, 1.0),
            decrease: factoryIncrease(config, -1.0),
          },
          false
        ),
      }).toUIItems(layout)
    }

        ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryDuration = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-input"),
        layout: VELayouts.get("div"),
        config: Struct.appendRecursive(
          config, 
          {
            layout: { type: UILayoutType.VERTICAL }, 
            field: { 
              store: {
                callback: function(value, data) {
                  if (!Core.isType(value, ColorTransformer) || !Core.isType(data, UIItem)) {
                    return
                  }
                  
                  if (data.textField.isFocused()) {
                    return
                  }

                  data.textField.setText(value.duration)
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

                  var transformer = item.get()
                  transformer.setDuration(parsedValue)
                  item.set(transformer)
                },
              },
            },
            decrease: {
              store: {
                callback: Lambda.passthrough,
                set: Lambda.passthrough,
              },
              factor: -0.1,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
      
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var transformer = item.get()
                transformer.setDuration(transformer.duration + factor)
                item.set(transformer)
              },
            },
            increase: {
              store: {
                callback: Lambda.passthrough,
                set: Lambda.passthrough,
              },
              factor: 0.1,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
      
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var transformer = item.get()
                transformer.setDuration(transformer.duration + factor)
                item.set(transformer)
              },
            },
            stick: {
              store: {
                callback: Lambda.passthrough,
                set: function(value) {
                  var item = this.get()
                  if (!Optional.is(item)) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (!Optional.is(parsedValue)) {
                    return
                  }

                  var transformer = item.get()
                  transformer.setDuration(parsedValue)
                  item.set(transformer)
                },
              },
              factor: 1.0,
              getValue: function(uiItem) {
                return uiItem.store.getValue().duration
              },
            },
            checkbox: {

            },
          },
          false
        ),
      }).toUIItems(layout)
    }

    var items = new Array(UIItem)

    Struct.set(layout.nodes.title, "height", method(layout.nodes.title, function() { return 0 }))
    Struct.set(layout.nodes.title, "marginRef", new Margin())

    factoryHex(
      $"{name}_hex",
      layout.nodes.hex,
      Struct.appendRecursive(
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          button: {
            enable: Optional.is(Struct.getIfType(config.hex.field, "enable", Struct)) 
              ? JSON.clone(config.hex.field.enable) 
              : null,
            store: Optional.is(Struct.get(config.hex.field, "store")) 
              ? JSON.clone(config.hex.field.store) 
              : { },
            hidden: Optional.is(Struct.getIfType(config.hex.field, "hidden", Struct)) 
              ? JSON.clone(config.hex.field.hidden) 
              : null,
          }
        },
        Struct.get(config, "hex"),
        false
      )  
    ).forEach(addItem, items)
        
    factoryColorIncreaseField(
      $"{name}_red",
      layout.nodes.red,
      Struct.appendRecursive(
        Struct.get(config, "red"), 
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { colorChannel: "red" }, 
          slider: { colorChannel: "red" },
          decrease: { colorChannel: "red" },
          increase: { colorChannel: "red" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColorIncreaseField (
      $"{name}_green",
      layout.nodes.green,
      Struct.appendRecursive(
        Struct.get(config, "green"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { colorChannel: "green" }, 
          slider: { colorChannel: "green" },
          decrease: { colorChannel: "green" },
          increase: { colorChannel: "green" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryColorIncreaseField (
      $"{name}_blue",
      layout.nodes.blue,
      Struct.appendRecursive(
        Struct.get(config, "blue"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { colorChannel: "blue" }, 
          slider: { colorChannel: "blue" },
          decrease: { colorChannel: "blue" },
          increase: { colorChannel: "blue" },
        },
        false
      )
    ).forEach(addItem, items)

    if (Struct.contains(config, "duration")) {
      factoryDuration(
        $"{name}_duration",
        layout.nodes.blue,
        Struct.appendRecursive(
          Struct.get(config, "duration"),
          {
            layout: { 
              //type: layout.type,
              propagateHidden: true,
            },
          },
          false
        )
      ).forEach(addItem, items)
    }

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "spin-select": function(name, layout, config = null) {

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryButton = function(name, layout, config) {
      return UIButton(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var increment = Struct.get(this, "increment")
              if (!Optional.is(this.store) || !Core.isType(increment, Number)) {
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
              index = (index == null ? 0 : index) + increment
              if (index < 0) {
                index = data.size() - 1
              } else if (index > data.size() - 1) {
                index = 0
              }
              item.set(data.get(index))
            },
          }, 
          config, 
          false
        )
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryPreview = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            notify: true,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
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
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
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
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              label: { text: "<" },
            },
            Struct.get(config, "previous"), 
            false
          ), 
          Struct.get(VEStyles.get("spin-select"), "previous"),
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
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },    
              label: { text: ">" },
            },
            Struct.get(config, "next"),
            false
          ),
          Struct.get(VEStyles.get("spin-select"), "next"),
          false
        )
      ),
      factoryPreview(
        $"{name}_preview",
        layout.nodes.preview,
        Struct.get(config, "preview")
      ),
    ])
  },
  
  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "spin-select-override": function(name, layout, config = null) {

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryButton = function(name, layout, config) {
      var _config = Struct.appendRecursive(
        config,
        {
          layout: layout,
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        }, 
        false
      )

      if (Struct.get(_config, "callback") == null) {
        Struct.set(_config, method(_config, function() {
          var increment = Struct.get(this, "increment")
          if (!Optional.is(this.store) || !Core.isType(increment, Number)) {
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
          index = (index == null ? 0 : index) + increment
          if (index < 0) {
            index = data.size() - 1
          } else if (index > data.size() - 1) {
            index = 0
          }
          item.set(data.get(index))
        }))
      }

      return UIButton(
        name, 
        _config
      )
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {UIItem}
    static factoryPreview = function(name, layout, config) {
      return UIImage(
        name, 
        Struct.appendRecursive(
          {
            layout: layout,
            notify: true,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
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
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("text-field_label"),
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
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              label: { text: "<" },        
            },
            Struct.get(config, "previous"), 
            true
          ), 
          Struct.get(VEStyles.get("spin-select"), "previous"),
          false
        )
      ),
      factoryPreview(
        $"{name}_preview",
        layout.nodes.preview,
        Struct.get(config, "preview")
      ),
      factoryButton(
        $"{name}_next",
        layout.nodes.next,
        Struct.appendRecursive(
          Struct.appendRecursive(
            { 
              increment: 1,
              backgroundColor: VETheme.color.button,
              backgroundColorSelected: VETheme.color.buttonHover,
              backgroundColorOut: VETheme.color.button,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              label: { text: ">" }, 
            },
            Struct.get(config, "next"),
            false
          ),
          Struct.get(VEStyles.get("spin-select"), "next"),
          false
        )
      ),
    ])
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "numeric-input": function(name, layout, config = null) {
    var isCheckbox = Core.isType(Struct.get(config, "checkbox"), Struct)
    return new UIComponent({
      name: name,
      template: VEComponents.get(isCheckbox
        ? "text-field-increase-stick-checkbox"
        : "numeric-slider-increase-field"),
      layout: VELayouts.get(isCheckbox
        ? "text-field-increase-stick-checkbox"
        : "text-field-increase-slider-checkbox"),
      config: Struct.appendRecursive({
        decrease: VEComponentsUtil.factory.config.decrease(-1.0),
        increase: VEComponentsUtil.factory.config.increase(1.0),
        stick: VEComponentsUtil.factory.config.numberStick({ factor: 0.001 }),
      }, config, false)
    }).toUIItems(layout)
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "number-transformer-increase-checkbox": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
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
        layout: VELayouts.get("spin-select"),
        config: Struct.appendRecursive(
          {
            label: { 
              text: "Ease"
            },
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

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_value",
      layout.nodes.value,
      Struct.appendRecursive(
        { 
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
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
        { 
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { transformNumericProperty: "target" },
          decrease: { transformNumericProperty: "target" },
          increase: { transformNumericProperty: "target" },
          stick: {
            transformNumericProperty: "target",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
        },
        Struct.get(config, "target"),
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncreaseStickCheckbox(
      $"{name}_duration",
      layout.nodes.duration,
      Struct.appendRecursive(
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          label: {
            text: "Duration",
            color: VETheme.color.textShadow,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          field: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          decrease: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          increase: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          stick: {
            transformNumericProperty: "duration",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          checkbox: { 
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          title: { 
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
        },
        Struct.get(config, "duration"),
        false
      )
    ).forEach(addItem, items)

    factorySpinSelect(
      $"{name}_ease",
      layout.nodes.duration,
      Struct.appendRecursive(
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          label: {
            text: "Ease",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          previous: { 
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          preview: { 
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
          next: { 
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "enable", Struct, { })),
            store: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "store", Struct, { })),
            hidden: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "target"), "field"), "hidden", Struct, { })),
          },
        },
        Struct.get(config, "ease"),
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "transform-numeric-uniform": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryTextFieldIncrease = function(name, layout, config) { //factoryNumericSliderIncreaseField
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-stick-increase-field"),
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
            ///@todo rename to stick
            slider: VEComponentsUtil.factory.config.numberStick({ 
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
                    return null
                  }
                  
                  return Struct.get(transformer, key)
                },
              },
            }),
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
        layout: VELayouts.get("spin-select"),
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

    factoryTextFieldIncrease(
      $"{name}_value",
      layout.nodes.value,
      Struct.appendRecursive(
        Struct.get(config, "value"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { transformNumericProperty: "value" },
          decrease: { transformNumericProperty: "value" },
          increase: { transformNumericProperty: "value" },
          slider: { transformNumericProperty: "value" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_target",
      layout.nodes.target,
      Struct.appendRecursive(
        Struct.get(config, "target"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { transformNumericProperty: "target" },
          decrease: { transformNumericProperty: "target" },
          increase: { transformNumericProperty: "target" },
          slider: { transformNumericProperty: "target" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_duration",
      layout.nodes.duration, 
      Struct.appendRecursive(
        Struct.get(config, "duration"), 
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { transformNumericProperty: "duration" },
          decrease: { transformNumericProperty: "duration" },
          increase: { transformNumericProperty: "duration" },
          slider: { transformNumericProperty: "duration" },
        },
        false
      )
    ).forEach(addItem, items)

    factorySpinSelect(
      $"{name}_ease",
      layout.nodes.duration,
      Struct.appendRecursive(
        Struct.get(config, $"ease"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          label: {
            text: "Ease",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "label"), "enable", Struct, { })),
          },
          previous: {
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "previous"), "enable", Struct, { })),
          },
          preview: {
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "preview"), "enable", Struct, { })),
          },
          next: {
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "next"), "enable", Struct, { })),
          },
        }
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "transform-vec-property-uniform": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryTextFieldIncrease = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-stick-increase-field"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (!Optional.is(item)) {
                    return 
                  }

                  var vec = Struct.get(data, "transformVectorProperty")
                  var vecTransformer = item.get()
                  if (!Optional.is(vecTransformer) 
                    || !Struct.contains(vecTransformer, vec)) {
                    return 
                  }

                  var key = Struct.get(data, "transformNumericProperty")
                  var transformer = Struct.get(vecTransformer, vec)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }

                  data.textField.setText(Struct.get(transformer, key))
                },
                set: function(value) {
                  var item = this.get()
                  if (!Optional.is(item)) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (parsedValue == null) {
                    return
                  }

                  var vec = Struct.get(this.context, "transformVectorProperty")
                  var vecTransformer = item.get()
                  if (!Optional.is(vecTransformer) 
                    || !Struct.contains(vecTransformer, vec)) {
                    return 
                  }

                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vecTransformer, vec)
                  if (!Core.isType(transformer, NumberTransformer) 
                    || !Struct.contains(transformer, key)) {
                    return 
                  }

                  Struct.set(transformer, key, parsedValue)
                  item.set(vecTransformer)
                },
              },
            },
            decrease: VEComponentsUtil.factory.config.decreaseVecProperty(),
            increase: VEComponentsUtil.factory.config.increaseVecProperty(),
            ///@todo rename to stick
            slider: VEComponentsUtil.factory.config.numberStick({ 
              store: {
                callback: Lambda.passthrough,
                set: function(value) {
                  var item = this.get()
                  if (!Optional.is(item)) {
                    return 
                  }

                  var parsedValue = NumberUtil.parse(value, null)
                  if (!Optional.is(parsedValue)) {
                    return
                  }

                  var vec = Struct.get(this.context, "transformVectorProperty")
                  var vecTransformer = item.get()
                  if (!Optional.is(vecTransformer) 
                    || !Struct.contains(vecTransformer, vec)) {
                    return 
                  }
  
                  var key = Struct.get(this.context, "transformNumericProperty")
                  var transformer = Struct.get(vecTransformer, vec)
                  if (!Core.isType(transformer, NumberTransformer) 
                      || !Struct.contains(transformer, key)) {
                    return 
                  }
                  
                  Struct.set(transformer, key, parsedValue)
                  item.set(vecTransformer)
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

                  var vec = Struct.get(this.context, "transformVectorProperty")
                  var vecTransformer = item.get()
                  if (!Optional.is(vecTransformer)) {
                    return null
                  }

                  var transformer = Struct.get(vecTransformer, vec)
                  if (!Optional.is(transformer)) {
                    return null
                  }
                  
                  return Struct.get(transformer, key)
                },
              },
            }),
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
        layout: VELayouts.get("spin-select"),
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

                var vec = Struct.get(this, "transformVectorProperty")
                var vecTransformer = item.get()
                if (!Optional.is(vecTransformer) 
                  || !Struct.contains(vecTransformer, vec)) {
                  return 
                }

                var transformer = Struct.get(vecTransformer, vec)
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
                item.set(vecTransformer)
              },
              store: { 
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            preview: { 
              image: { name: "texture_empty" },
              store: {
                callback: function(vecTransformer, data) { 
                  var vec = Struct.get(data, "transformVectorProperty")
                  if (!Optional.is(vecTransformer) 
                    || !Struct.contains(vecTransformer, vec)) {
                    return 
                  }

                  var transformer = Struct.get(vecTransformer, vec)
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

                var vec = Struct.get(this, "transformVectorProperty")
                var vecTransformer = item.get()
                if (!Optional.is(vecTransformer) 
                  || !Struct.contains(vecTransformer, vec)) {
                  return 
                }

                var transformer = Struct.get(vecTransformer, vec)
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

                var vec = Struct.get(this, "transformVectorProperty")
                var vecTransformer = item.get()
                if (!Optional.is(vecTransformer) 
                  || !Struct.contains(vecTransformer, vec)) {
                  return 
                }

                var transformer = Struct.get(vecTransformer, vec)
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

                var vec = Struct.get(this, "transformVectorProperty")
                var vecTransformer = item.get()
                if (!Optional.is(vecTransformer) 
                  || !Struct.contains(vecTransformer, vec)) {
                  return 
                }

                var transformer = Struct.get(vecTransformer, vec)
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
                  item.set(vecTransformer)
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

                var vec = Struct.get(this, "transformVectorProperty")
                var vecTransformer = item.get()
                if (!Optional.is(vecTransformer) 
                  || !Struct.contains(vecTransformer, vec)) {
                  return 
                }

                var transformer = Struct.get(vecTransformer, vec)
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
                item.set(vecTransformer)
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
    var vectorProperty = String.toLowerCase(Struct.getIfType(config, "vectorProperty", String, "x"))

    factoryTextFieldIncrease(
      $"{name}_value-{vectorProperty}",
      layout.nodes.value,
      Struct.appendRecursive(
        Struct.get(config, $"value"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: {
            transformNumericProperty: "value",
            transformVectorProperty: vectorProperty,
          },
          decrease: {
            transformNumericProperty: "value",
            transformVectorProperty: vectorProperty,
          },
          increase: {
            transformNumericProperty: "value",
            transformVectorProperty: vectorProperty,
          },
          slider: {
            transformNumericProperty: "value",
            transformVectorProperty: vectorProperty,
          },
        },
        false
      )
    ).forEach(addItem, items)
    
    factoryTextFieldIncrease(
      $"{name}_target-{vectorProperty}",
      layout.nodes.target,
      Struct.appendRecursive(
        Struct.get(config, $"target"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: {
            transformNumericProperty: "target",
            transformVectorProperty: vectorProperty,
          },
          decrease: {
            transformNumericProperty: "target",
            transformVectorProperty: vectorProperty,
          },
          increase: {
            transformNumericProperty: "target",
            transformVectorProperty: vectorProperty,
          },
          slider: {
            transformNumericProperty: "target",
            transformVectorProperty: vectorProperty,
          },
        },
        false
      )
    ).forEach(addItem, items)

    factoryTextFieldIncrease(
      $"{name}_duration-{vectorProperty}",
      layout.nodes.duration,
      Struct.appendRecursive(
        Struct.get(config, $"duration"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: {
            transformNumericProperty: "duration",
            transformVectorProperty: vectorProperty,
          },
          decrease: {
            transformNumericProperty: "duration",
            transformVectorProperty: vectorProperty,
          },
          increase: {
            transformNumericProperty: "duration",
            transformVectorProperty: vectorProperty,
          },
          slider: {
            transformNumericProperty: "duration",
            transformVectorProperty: vectorProperty,
          },
        },
        false
      )
    ).forEach(addItem, items)

    factorySpinSelect(
      $"{name}_ease",
      layout.nodes.duration,
      Struct.appendRecursive(
        Struct.get(config, $"ease"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          label: {
            text: "Ease",
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "label"), "enable", Struct, { })),
          },
          previous: {
            transformVectorProperty: vectorProperty,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "previous"), "enable", Struct, { })),
          },
          preview: {
            transformVectorProperty: vectorProperty,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "preview"), "enable", Struct, { })),
          },
          next: {
            transformVectorProperty: vectorProperty,
            enable: JSON.clone(Struct.getIfType(Struct.get(Struct.get(config, "ease"), "next"), "enable", Struct, { })),
          },
        }
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "vec4-slider-increase": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryNumericSliderIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-slider-increase-field"),
        layout: VELayouts.get("numeric-slider-increase-field"),
        config: Struct.appendRecursive(
          {
            field: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
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

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
            slider: {
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)) {
                    return 
                  }
                  data.value = Struct.get(vec4, key)
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

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
            decrease: {
              factor: -0.01,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
  
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Struct.contains(vec4, key)) {
                  return 
                }
                
                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            increase: {
              factor: 0.01,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
  
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Struct.contains(vec4, key)) {
                  return 
                }
                
                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
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

    factoryNumericSliderIncreaseField(
      $"{name}_x",
      layout.nodes.x,
      Struct.appendRecursive(
        Struct.get(config, "x"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "x" },
          slider: { vec4Property: "x" },
          decrease: { vec4Property: "x" },
          increase: { vec4Property: "x" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_y",
      layout.nodes.y,
      Struct.appendRecursive(
        Struct.get(config, "y"),
        { 
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "y" },
          slider: { vec4Property: "y" },
          decrease: { vec4Property: "y" },
          increase: { vec4Property: "y" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_z",
      layout.nodes.z,
      Struct.appendRecursive(
        Struct.get(config, "z"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "z" },
          slider: { vec4Property: "z" },
          decrease: { vec4Property: "z" },
          increase: { vec4Property: "z" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericSliderIncreaseField(
      $"{name}_a",
      layout.nodes.a,
      Struct.appendRecursive(
        Struct.get(config, "a"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "a" },
          slider: { vec4Property: "a" },
          decrease: { vec4Property: "a" },
          increase: { vec4Property: "a" },
        },
        false
      )
    ).forEach(addItem, items)

    return items
  },

  ///@param {String} name
  ///@param {UILayout} layout
  ///@param {?Struct} [config]
  ///@return {Array<UIItem>}
  "vec4-stick-increase": function(name, layout, config = null) {
    ///@todo move to Lambda util
    static addItem = function(item, index, items) {
      items.add(item)
    }

    ///@param {String} name
    ///@param {UILayout} layout
    ///@param {?Struct} [config]
    ///@return {Array<UIItem>}
    static factoryNumericStickIncreaseField = function(name, layout, config) {
      return new UIComponent({
        name: name,
        template: VEComponents.get("numeric-input"),
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

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)
                    || GMTFContext.get() == data.textField) {
                    return 
                  }
                  data.textField.setText(Struct.get(vec4, key))
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

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
            },
            stick: {
              factor: -0.01,
              store: {
                callback: function(value, data) { 
                  var item = data.store.get()
                  if (item == null) {
                    return 
                  }

                  var key = Struct.get(data, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)) {
                    return 
                  }
                  data.value = Struct.get(vec4, key)
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

                  var key = Struct.get(this.context, "vec4Property")
                  var vec4 = item.get()
                  if (!Struct.contains(vec4, key)) {
                    return 
                  }
                  item.set(Struct.set(vec4, key, parsedValue))
                },
              },
              getValue: function(uiItem) {
                return Struct.get(uiItem.store.getValue(), Struct.get(uiItem, "vec4Property"))
              },
            },
            decrease: {
              factor: -0.01,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
  
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Struct.contains(vec4, key)) {
                  return 
                }
                
                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
              },
              store: {
                callback: function(value, data) { },
                set: function(value) { },
              },
            },
            increase: {
              factor: 0.01,
              callback: function() {
                var factor = Struct.get(this, "factor")
                if (!Core.isType(factor, Number) || !Core.isType(this.store, UIStore)) {
                  return
                }
  
                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var key = Struct.get(this, "vec4Property")
                var vec4 = item.get()
                if (!Struct.contains(vec4, key)) {
                  return 
                }
                
                Struct.set(vec4, key, Struct.get(vec4, key) + factor)
                item.set(vec4)
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

    factoryNumericStickIncreaseField(
      $"{name}_x",
      layout.nodes.x,
      Struct.appendRecursive(
        Struct.get(config, "x"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "x" },
          stick: { vec4Property: "x" },
          decrease: { vec4Property: "x" },
          increase: { vec4Property: "x" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericStickIncreaseField(
      $"{name}_y",
      layout.nodes.y,
      Struct.appendRecursive(
        Struct.get(config, "y"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "y" },
          stick: { vec4Property: "y" },
          decrease: { vec4Property: "y" },
          increase: { vec4Property: "y" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericStickIncreaseField(
      $"{name}_z",
      layout.nodes.z,
      Struct.appendRecursive(
        Struct.get(config, "z"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "z" },
          stick: { vec4Property: "z" },
          decrease: { vec4Property: "z" },
          increase: { vec4Property: "z" },
        },
        false
      )
    ).forEach(addItem, items)

    factoryNumericStickIncreaseField(
      $"{name}_a",
      layout.nodes.a,
      Struct.appendRecursive(
        Struct.get(config, "a"),
        {
          layout: { 
            //type: layout.type,
            propagateHidden: true,
          },
          field: { vec4Property: "a" },
          stick: { vec4Property: "a" },
          decrease: { vec4Property: "a" },
          increase: { vec4Property: "a" },
        },
        false
      )
    ).forEach(addItem, items)

    return items
  },
})
#macro VEComponents global.__VEComponents


///@static
///@type {Struct}
global.__EaseTypeMap = {
  "LEGACY": "texture_empty",
  "LINEAR": "texture_icon_ease_linear",
  "IN_SINE": "texture_icon_ease_in_sine",
  "OUT_SINE": "texture_icon_ease_out_sine",
  "IN_OUT_SINE": "texture_icon_ease_in_out_sine",
  "IN_QUAD": "texture_icon_ease_in_quad",
  "OUT_QUAD": "texture_icon_ease_out_quad",
  "IN_OUT_QUAD": "texture_icon_ease_in_out_quad",
  "IN_CUBIC": "texture_icon_ease_in_cubic",
  "OUT_CUBIC": "texture_icon_ease_out_cubic",
  "IN_OUT_CUBIC": "texture_icon_ease_in_out_cubic",
  "IN_QUART": "texture_icon_ease_in_quart",
  "OUT_QUART": "texture_icon_ease_out_quart",
  "IN_OUT_QUART": "texture_icon_ease_in_out_quart",
  "IN_QUINT": "texture_icon_ease_in_quint",
  "OUT_QUINT": "texture_icon_ease_out_quint",
  "IN_OUT_QUINT": "texture_icon_ease_in_out_quint",
  "IN_EXPO": "texture_icon_ease_in_expo",
  "OUT_EXPO": "texture_icon_ease_out_expo",
  "IN_OUT_EXPO": "texture_icon_ease_in_out_expo",
  "IN_CIRC": "texture_icon_ease_in_circ",
  "OUT_CIRC": "texture_icon_ease_out_circ",
  "IN_OUT_CIRC": "texture_icon_ease_in_out_circ",
  "IN_BACK": "texture_icon_ease_in_back",
  "OUT_BACK": "texture_icon_ease_out_back",
  "IN_OUT_BACK": "texture_icon_ease_in_out_back",
  "IN_ELASTIC": "texture_icon_ease_in_elastic",
  "OUT_ELASTIC": "texture_icon_ease_out_elastic",
  "IN_OUT_ELASTIC": "texture_icon_ease_in_out_elastic",
  "IN_BOUNCE": "texture_icon_ease_in_bounce",
  "OUT_BOUNCE": "texture_icon_ease_out_bounce",
  "IN_OUT_BOUNCE": "texture_icon_ease_in_out_bounce",
}
#macro EASE_TYPE_MAP global.__EaseTypeMap