///@package io.alkapivo.core.service.ui.item

///@static
///@type {Map<String, String>}
global.__GMTF_COLOR_DICTIONARY = new Map(String, String, {
  "colorBackgroundUnfocused": "c_bkg_unfocused",
  "colorBackgroundFocused": "c_bkg_focused",
  "colorOutlineUnfocused": "c_outline_unfocused",
  "colorOutlineFocused": "c_outline_focused",
  "colorTextUnfocused": "c_text_unfocused",
  "colorTextFocused": "c_text_focused",
  "colorSelection": "c_selection",
})
#macro GMTF_COLOR_DICTIONARY global.__GMTF_COLOR_DICTIONARY


///@param {String} name
///@param {?Struct} [json]
///@return {UIItem}
function UITextField(name, json = null) {

  ///@description parse colors parameters to match GMTF format
  GMTF_COLOR_DICTIONARY.forEach(function(gmtfKey, key, json) {
    if (Struct.contains(json, key)) {
      var color = ColorUtil.fromHex(Struct.get(json, key))
      Struct.set(json, gmtfKey, { c: color.toGMColor(), a: color.alpha })
    }
  }, json)

  ///@description append default store callback
  if (Struct.contains(json, "store")) {
    Struct.set(json, "store", Struct.append({
      callback: function(value, data) {
        if (GMTFContext.current != data.textField) {
          data.textField.setText(value)
        }
      },
    }, Struct.getDefault(json, "store", {})))
  }

  var uiTextField = new UIItem(name, Struct.append(json, {

    ///@param {Callable}
    type: UITextField,

    ///@type {any}
    value: Struct.getDefault(json, "value", ""),

    ///@type {GMTF}
    textField: Core.isType(json, Struct) ? new GMTF(json) : new GMTF(),

    ///@type {?Struct}
    enable: Struct.getIfType(json, "enable", Struct),

    ///@type {Boolean}
    enableColorWrite: Core.getProperty("core.ui-service.use-surface-optimalization", false),

    ///@type {Boolean}
    notify: Struct.getIfType(json, "notify", Boolean, true),

    ///@param {any} value
    updateValue: new BindIntent(Assert.isType(Struct.getDefault(json, "updateValue", function(value) {
      this.value = value
      if (Optional.is(this.store)) {
        this.store.set(this.value)
      }
    }), Callable)),

    updateEnable: Struct.getIfType(json, "updateEnable", Callable, Callable.run(UIItemUtils.templates.get("updateEnable"))),

    ///@override
    ///@param {Boolean} [_updateArea]
    ///@return {UIItem}
    update: Struct.getDefault(json, "update", function(_updateArea = false) {
      if (_updateArea) {
        this.updateHidden()

        if (Optional.is(this.updateArea)) {
          this.updateArea()
        }
  
        if (Optional.is(this.updateEnable)) {
          this.updateEnable()
        }
      }

      if (Optional.is(this.updateCustom)) {
        this.updateCustom()
      }

      if (!this.storeSubscribed) {
        this.storeSubscribed = true
        this.updateStore()
      }

      if (this.isHoverOver) {
        this.updateHover()
      }

      if (Optional.is(this.enable)) {
        if (Struct.get(this.enable, "value") == false) {
          if (this.textField.isFocused()) {
            this.textField.unfocus()
          }
          this.textField.style.c_text_unfocused.a = 0.5
          this.textField.style.c_text_focused.a = 0.5
          this.textField.enabled = false
        } else {
          this.textField.style.c_text_unfocused.a = 1.0
          this.textField.style.c_text_focused.a = 1.0
          this.textField.enabled = true
        }
      }

      if (this.hidden.value && this.textField.isFocused()) {
        this.textField.unfocus()
      }
      
      var _w = this.textField.style.w
      var _h = this.textField.style.h
      this.textField.style.w = this.area.getWidth();//!this.hidden.value ? this.area.getWidth() : this.textField.style.w // will not work with horizontal layout
      if (!this.hidden.value && this.textField.style.v_grow) {
        if (this.area.getHeight() != this.textField.style.h) {
          this.area.setHeight(this.textField.style.h)
          if (Optional.is(this.context)) {
            this.context.areaWatchdog.signal(1)
            this.context.clampUpdateTimer(0.9000)
          }

          var layout = Struct.get(this, "layout")
          if (Optional.is(Struct.get(layout, "setHeight"))) {
            layout.setHeight(this.textField.style.h)
          }
        }
      } else if (!this.hidden.value) {
        this.textField.style.h = this.area.getHeight()
      }

      if (this.textField.style.w != _w || this.textField.style.h != _h) {
        this.textField.updateStyle()
      }
      
      if (Optional.is(this.context.surface)) {
        this.textField.update(this.context.area.getX(), this.context.area.getY())
      } else {
        this.textField.update(0, 0)
      }
      var text = this.textField.getText()
      if (!this.textField.isFocused() && this.value != text) {
        this.updateValue(text)
      }

      return this
    }),
    
    ///@param {Event} event
    onMousePressedLeft: Assert.isType(Struct.getDefault(json, "onMousePressedLeft", function(event) {
      this.textField.focus()
      this.update(true)
    }), Callable),

    ///@override
    ///@return {UIItem}
    render: Struct.getDefault(json, "render", function() {
      if (Optional.is(this.preRender)) {
        this.preRender()
      }

      var config = gpu_get_colorwriteenable()
      if (this.enableColorWrite) {
        GPU.set.colorWrite(true, true, true, false)
      }

      this.textField.draw(
        this.context.area.getX() + this.area.getX(),
        this.context.area.getY() + this.area.getY() 
      )
      
      GPU.set.colorWrite(config[0], config[1], config[2], config[3])
      return this
    }),
  }, false))

  uiTextField.textField.uiItem = uiTextField
  return uiTextField
}