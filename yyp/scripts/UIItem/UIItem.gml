///@package io.alkapivo.core.service.ui

///@interface
///@param {UI} _context
///@param {?Struct} [config]
function UIItem(_name, config = {}) constructor {

  ///@type {String}
  name = Assert.isType(_name, String)

  ///@type {?UI}
  context = null

  ///@type {any}
  type = Struct.get(config, "type")

  var _hidden = Struct.get(config, "hidden")
  ///@type {Struct}
  hidden = {
    value: Struct.getDefault(_hidden, "value", false),
    key: Struct.getDefault(_hidden, "key", null),
    keys: Struct.getDefault(_hidden, "keys", null),
    negate: Struct.getDefault(_hidden, "negate", false),
  }

  var _enable = Struct.get(config, "enable")
  ///@type {Struct}
  enable  = {
    value: Struct.getDefault(_enable, "value", true),
    key: Struct.getDefault(_enable, "key", null),
    keys: Struct.getDefault(_enable, "keys", null),
    negate: Struct.getDefault(_enable, "negate", false),
  }

  ///@type {Rectangle}
  area = new Rectangle(Struct.get(config, "area"))

  ///@type {Margin}
  margin = new Margin(Struct.get(config, "margin"))

  ///@type {Boolean}
  isHoverOver = false

  ///@type {any}
  state = Struct.get(config, "state")

  ///@type {?UIStore}
  store = Optional.is(Struct.get(config, "store"))
    ? new UIStore(config.store, this) 
    : null

  ///@type {Boolean}
  storeSubscribed = Struct.getIfType(config, "storeSubscribed", Boolean, false) 

  ///@type {?Struct}
  component = Struct.getIfType(config, "component", Struct)

  ///@type {?GMColor}
  backgroundColor = Optional.is(Struct.getIfType(config, "backgroundColor", String))
    ? ColorUtil.parse(config.backgroundColor).toGMColor()
    : null

  ///@type {Number}
  backgroundAlpha = Struct.getIfType(config, "backgroundAlpha", Number, 1.0)

  ///@type {?Margin}
  backgroundMargin = Optional.is(Struct.get(config, "backgroundMargin"))
    ? new Margin(config.backgroundMargin)
    : null
  
  ///@type {Event}
  hoverEvent = new Event("MouseHoverOut", { x: 0, y: 0 })

  ///@param {Event} event
  ///@return {Boolean}
  support = method(this, Struct.getIfType(config, "support", Callable, function(event, key, name) {
    return !this.hidden.value && Core.isType(Struct.get(this, $"on{event.name}"), Callable)
  }))

  ///@param {Event} event
  ///@return {?Callable}
  fetchEventPump = method(this, Struct.getIfType(config, "fetchEventPump", Callable, function(event) {
    return this.support(event) ? Struct.get(this, $"on{event.name}") : null
  }))

  ///@param {any} event
  ///@return {Boolean}
  collide = method(this, Struct.getIfType(config, "collide", Callable, function(event) {
    return !this.hidden.value && this.area.collide(
      Struct.get(event.data, "x") - this.context.area.getX() - this.context.offset.x, 
      Struct.get(event.data, "y") - this.context.area.getY() - this.context.offset.y
    )
  }))

  updateArea = Struct.contains(config, "updateArea")
    ? method(this, Assert.isType(Struct.get(config, "updateArea"), Callable))
    : null

  updateEnable = Struct.contains(config, "updateEnable")
    ? method(this, Assert.isType(Struct.get(config, "updateEnable"), Callable))
    : null

  updateCustom = Struct.contains(config, "updateCustom")
    ? method(this, Assert.isType(Struct.get(config, "updateCustom"), Callable))
    : null

  updateHover = Struct.contains(config, "updateHover")
    ? method(this, Assert.isType(config.updateHover, Callable))
    : function() {
      this.hoverEvent.data.x = MouseUtil.getMouseX()
      this.hoverEvent.data.y = MouseUtil.getMouseY()
      this.isHoverOver = this.collide(this.hoverEvent)
      if (!this.isHoverOver && Struct.contains(this, "onMouseHoverOut")) {
        Callable.run(this.onMouseHoverOut, this.hoverEvent)
      }
    }

  updateHidden = function() {
    if (!Core.isType(Struct.get(this.context, "state"), Map)) {
      return
    }

    var store = this.context.state.get("store")
    if (!Optional.is(store)) {
      return
    }

    if (Core.isType(this.hidden.keys, GMArray)) {
      var isValid = true
      var size = GMArray.size(this.hidden.keys)
      for (var index = 0; index < size; index++) {
        var entry = this.hidden.keys[index]
        var item = store.get(entry.key)
        if (!Optional.is(item)) {
          continue
        }

        var value = Struct.getDefault(entry, "negate", false) ? !item.get() : item.get()
        if (value) {
          isValid = false
          break
        }
      }

      if (this.hidden.value == !isValid) {
        return
      }

      this.hidden.value = !isValid
      this.context.areaWatchdog.signal(2)
      this.context.clampUpdateTimer(0.9000)
    } else {
      if (!Optional.is(this.hidden.key)) {
        return
      }

      var item = store.get(this.hidden.key)
      if (!Optional.is(item)) {
        return
      }

      var value = this.hidden.negate ? !item.get() : item.get()
      if (value == this.hidden.value) {
        return
      }
  
      this.hidden.value = value
      this.context.areaWatchdog.signal(2)
      this.context.clampUpdateTimer(0.9000)
    }
  }

  updateStore = function() {
    if (Optional.is(this.store)) {
      this.store.subscribe()
    }

    if (!Core.isType(Struct.get(this.context, "state"), Map)) {
      return
    }

    var store = this.context.state.get("store")
    if (!Optional.is(store)) {
      return
    }

    if (Core.isType(this.hidden.keys, GMArray)) {
      for (var index = 0; index < GMArray.size(this.hidden.keys); index++) {
        var entry = this.hidden.keys[index]
        var item = store.get(entry.key)
        if (Optional.is(item)) {
          item.addSubscriber({
            name: $"{this.name}",
            overrideSubscriber: true,
            callback: this.updateHidden,
            data: this
          })
        }
      }
    } else if (Core.isType(this.hidden.key, String)) {
      var item = store.get(this.hidden.key)
      if (Optional.is(item)) {
        item.addSubscriber({
          name: $"{this.name}",
          overrideSubscriber: true,
          callback: this.updateHidden,
          data: this,
        })
      }
    }

    if (this.updateEnable != null && Core.isType(this.enable.keys, GMArray)) {
      for (var index = 0; index < GMArray.size(this.enable.keys); index++) {
        var entry = this.enable.keys[index]
        var item = store.get(entry.key)
        if (Optional.is(item)) {
          item.addSubscriber({
            name: $"{this.name}",
            overrideSubscriber: true,
            callback: this.updateEnable,
            data: this,
          })
        }
      }
    } else if (this.updateEnable != null && Core.isType(this.enable.key, String)) {
      var item = store.get(this.enable.key)
      if (Optional.is(item)) {
        item.addSubscriber({
          name: $"{this.name}",
          overrideSubscriber: true,
          callback: this.updateEnable,
          data: this,
        })
      }
    }
  }

  ///@param {Boolean} [_updateArea]
  ///@return {UIItem}
  update = Struct.contains(config, "update")
    ? Assert.isType(method(this, config.update), Callable)
    : function(_updateArea = false) {
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

      if (!storeSubscribed) {
        this.storeSubscribed = true
        this.updateStore()
      }

      if (this.isHoverOver) {
        this.updateHover()
      }

      return this
    }

  free = method(this, Struct.getIfType(config, "free", Callable, function() {
    if (Optional.is(this.store)) {
      this.store.unsubscribe()
      this.storeSubscribed = false
    }
  }))

  ///@type {?Callable}
  preRender = Struct.contains(config, "preRender")
    ? method(this, Assert.isType(config.preRender, Callable))
    : null

  ///@type {?Callable}
  postRender = Struct.contains(config, "postRender")
    ? method(this, Assert.isType(config.postRender, Callable))
    : null
  
  ///@return {UIItem}
  render = method(this, Struct.getIfType(config, "render", Callable, function() {
    if (Optional.is(this.preRender)) {
      this.preRender()
    }

    if (Optional.is(this.postRender)) {
      this.postRender()
    }
    return this
  }))

  ///@description append mouse events
  Struct.forEach(config, function(value, key, button) {
    if (!String.startsWith(key, "on")) {
      return
    }
    Struct.set(button, key, method(button, Assert.isType(value, Callable)))
  }, this)
  Struct.appendUnique(this, config)
}

///@static
function _UIItemUtils() constructor {

  ///@type {Map<String, Callable>}
  templates = new Map(String, Callable, {
    "renderBackgroundColor": function() {
      return function() {
        if (this.backgroundColor == null) {
          return
        }

        var beginX = this.context.area.getX() + this.area.getX()
        var beginY = this.context.area.getY() + this.area.getY()
        var endX = beginX + this.area.getWidth()
        var endY = beginY + this.area.getHeight()
        var margin = Struct.get(this, "backgroundMargin")
        if (Core.isType(margin, Margin)) {
          GPU.render.rectangle(
            beginX + margin.left,
            beginY + margin.top,
            endX - margin.right,
            endY - margin.bottom,
            false,
            this.backgroundColor,
            this.backgroundColor,
            this.backgroundColor,
            this.backgroundColor,
            this.backgroundAlpha
          )
        } else {
          GPU.render.rectangle(
            beginX,
            beginY,
            endX,
            endY,
            false,
            this.backgroundColor,
            this.backgroundColor,
            this.backgroundColor,
            this.backgroundColor,
            this.backgroundAlpha
          )
        }
      }
    },
    "updateEnable": function() {
      return function() {
        if (!Optional.is(Struct.get(this, "enable")) 
          || !Core.isType(Struct.get(this.context, "state"), Map)) {
          return
        }

        var key = Struct.get(this.enable, "key")
        if (!Optional.is(key)) {
          return
        }

        var store = this.context.state.get("store")
        if (!Core.isType(store, Store)) {
          return
        }

        var item = store.get(key)
        if (!Core.isType(item, StoreItem)) {
          return
        }

        var value = Struct.getDefault(this.enable, "negate", false) ? !item.get() : item.get()
        if (Struct.get(this.enable, "value") != value) {
          Struct.set(this.enable, "value", value)
          this.context.areaWatchdog.signal(2)
          this.context.clampUpdateTimer(0.9000)
        }
      }
    },
    "updateEnableKeys": function() {
      return function() {
        if (!Optional.is(Struct.get(this, "enable")) 
          || !Core.isType(Struct.get(this.context, "state"), Map)) {
          return
        }

        var keys = Struct.get(this.enable, "keys")
        if (!Core.isType(keys, GMArray)) {
          return
        }

        var store = this.context.state.get("store")
        if (!Core.isType(store, Store)) {
          return
        }

        var isValid = true
        var size = GMArray.size(keys)
        for (var index = 0; index < size; index++) {
          var entry = keys[index]
          var item = store.get(entry.key)
          if (!Optional.is(item)) {
            continue
          }

          var value = Struct.getDefault(entry, "negate", false) ? !item.get() : item.get()
          if (!value) {
            isValid = false
            break
          }
        }

        if (Struct.get(this.enable, "value") != isValid) {
          Struct.set(this.enable, "value", isValid)
          this.context.areaWatchdog.signal(2)
          this.context.clampUpdateTimer(0.9000)
        }
      }
    },
  })

  ///@type {Struct}
  textField = {

    ///@return {Callable}
    getUpdateJSONTextArea: function() {
      return function() {
        var text = this.textField.getText()
        if (!Optional.is(text) 
            || String.isEmpty(text) 
            || Struct.get(this, "__previousText") == text) {
          return
        }

        Struct.set(this, "__previousText", text)
        if (!Struct.contains(this, "__colors")) {
          Struct.set(this, "__colors", {
            unfocusedValid: this.textField.style.c_bkg_unfocused.c,
            unfocusedInvalid: ColorUtil.fromHex(VETheme.color.denyShadow).toGMColor(),
            focusedValid: this.textField.style.c_bkg_focused.c,
            focusedInvalid: ColorUtil.fromHex(VETheme.color.deny).toGMColor(),
          })
        }

        var isValid = Optional.is(JSON.parse(text))
        var colors = Struct.get(this, "__colors")
        this.textField.style.c_bkg_unfocused.c = isValid 
          ? colors.unfocusedValid
          : colors.unfocusedInvalid
        this.textField.style.c_bkg_focused.c = isValid 
          ? colors.focusedValid
          : colors.focusedInvalid
      }
    },
  }
}
global.__UIItemUtils = new _UIItemUtils()
#macro UIItemUtils global.__UIItemUtils
