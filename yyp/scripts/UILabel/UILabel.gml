///@package io.alkapivo.core.service.ui

///@param {Struct} json
function UILabel(json) constructor {

  ///@type {String}
  text = Struct.getIfType(json, "text", String, "")

  ///@type {Font}
  font = Assert.isType(FontUtil.fetch(Struct.getIfType(json, "font", String, "font_basic")), Font,
    "UILabel.font must be type of Font")

  ///@type {GMColor}
  color = ColorUtil.fromHex(Struct.getIfType(json, "color", String, "#000000")).toGMColor()

  ///@type {Number}
  alpha = clamp(Struct.getIfType(json, "alpha", Number, 1.0), 0.0, 1.0)

  ///@type {Struct}
  align = {
    v: Struct.getIfEnum(Struct.get(json, "align"), "v", VAlign, VAlign.TOP),
    h: Struct.getIfEnum(Struct.get(json, "align"), "h", HAlign, HAlign.LEFT),
  }

  ///@type {Vector2}
  offset = Vector.parse(Struct.get(json, "offset"), Vector2)

  ///@type {Boolean}
  outline = Struct.getIfType(json, "outline", Boolean, false)

  ///@type {GMColor}
  outlineColor = ColorUtil.fromHex(Struct.getIfType(json, "outlineColor", String, "#ffffff")).toGMColor()

  ///@type {any}
  value = null

  ///@type {Boolean}
  enableColorWrite = Struct.getIfType(json, "enableColorWrite", Boolean, 
    Core.getProperty("core.ui-service.use-surface-optimalization", false))

  ///@type {Boolean}
  useScale = Struct.getIfType(json, "useScale", Boolean, true)

  ///@type {Boolean}
  useScaleWithOffset = Struct.getIfType(json, "useScaleWithOffset", Boolean, false)

  ///@param {Number} alpha
  ///@return {UILabel}
  setAlpha = function(alpha) {
    this.alpha = alpha
    return this
  }

  ///@param {Number} x
  ///@param {Number} y
  ///@param {Number} [maxWidth]
  ///@param {Number} [maxHeight]
  ///@param {Number} [forceScale]
  ///@return {UILabel}
  render = function(x, y, maxWidth = 0, maxHeight = 0, forceScale = 1.0) { 
    var enableBlend = GPU.get.blendEnable()
    if (!enableBlend) {
      GPU.set.blendEnable(true)
    }

    var colorWriteConfig = null
    if (this.enableColorWrite) {
      colorWriteConfig = GPU.get.colorWrite()
      GPU.set.colorWrite(true, true, true, false)
    }

    if (this.font.asset != GPU.get.font()) {
      GPU.set.font(this.font.asset)
    } 

    var _x = x + this.offset.x
    var _y = y + this.offset.y
    var _width = string_width(this.text)
    var _height = string_height(this.text)
    var _includeOffset = this.useScaleWithOffset ? 1 : 0
    var _maxWidth = maxWidth - (this.offset.x * _includeOffset)
    var _maxHeight = maxHeight - (this.offset.y * _includeOffset)
    var _outline = this.outline ? this.outlineColor : null
    var _scale = this.useScale 
      ? min(
        (_width > _maxWidth ? (_maxWidth / _width) : 1.0),
        (_height > _maxHeight ? (_maxHeight / _height) : 1.0)
      )
      : 1.0

    _scale = _scale < 1.0
      ? clamp(floor((_scale * 0.95) / 0.125) * 0.125, 0.0, 1.0)
      : _scale

    if (_scale <= 0.0) {
      return this
    }
    
    GPU.render.text(
      _x, 
      _y, 
      this.text,
      _scale,
      0.0,
      this.alpha,
      this.color,
      this.font,
      this.align.h,
      this.align.v,
      _outline,
      1.0
    )
    
    if (!enableBlend) {
      GPU.set.blendEnable(enableBlend)
    }

    if (Optional.is(colorWriteConfig)) {
      GPU.set.colorWrite(colorWriteConfig[0], colorWriteConfig[1], colorWriteConfig[2], colorWriteConfig[3])
    }

    return this
  }
}
