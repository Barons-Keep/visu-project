///@package io.alkapivo.core.renderer

#macro GMSurface "GMSurface"

///@type {Number}
global.__SURFACE_MAX_WIDTH = 8192
#macro SURFACE_MAX_WIDTH global.__SURFACE_MAX_WIDTH

///@type {Number}
global.__SURFACE_MAX_HEIGHT = 8192
#macro SURFACE_MAX_HEIGHT global.__SURFACE_MAX_HEIGHT

///@enum
function _SurfaceFormat(): Enum() constructor {
  RGBA8UNORM = surface_rgba8unorm
}
global.__SurfaceFormat = new _SurfaceFormat()
#macro SurfaceFormat global.__SurfaceFormat


///@param {Number} _width
///@param {Number} _height
///@param {SurfaceFormat} [_format]
///@param {?Struct} [config]
///@param {GMSurface} _asset
///_width, _height, _format = SurfaceFormat.RGBA8UNORM, _asset = null
function Surface(config = null) constructor {

  ///@type {Number}
  width = Assert.isType(clamp(Struct
    .getDefault(config, "width", 1), 1, SURFACE_MAX_WIDTH), Number)

  ///@type {Number}
  height = Assert.isType(clamp(Struct
    .getDefault(config, "height", 1), 1, SURFACE_MAX_HEIGHT), Number)

  ///@type {SurfaceFormat}
  format = Assert.isEnum(Struct
    .getDefault(config, "format", SurfaceFormat.RGBA8UNORM), SurfaceFormat)

  ///@type {?GMSurface}
  asset = Struct.contains(config, "asset")
    ? Assert.isType(Struct.get(config, "asset"), GMSurface)
    : null

  ///@type {Boolean}
  updated = false

  ///@type {Boolean}
  depth = Struct.getIfType(config, "depth", Boolean, false)

  ///@type {String}
  //key = null // used by SURFACE_COUNTER

  ///@param {?Number} [width]
  ///@param {?Number} [height]
  ///@return {Surface}
  update = function(width = null, height = null) {
    this.updated = false
    if (Core.isType(width, Number) && width > 2) {
      this.width = ceil(width)
    }

    if (Core.isType(height, Number) && height > 2) {
      this.height = ceil(height)
    }

    if (!Core.isType(this.asset, GMSurface)) {
      surface_depth_disable(!this.depth)
      //SURFACE_COUNTER.surfaceCreate(this, this.width, this.height, this.format)
      this.asset = surface_create(this.width, this.height, this.format)
      this.updated = true
    } else {
      if (this.depth && !surface_has_depth(this.asset)) {
        //SURFACE_COUNTER.surfaceFree(this)
        surface_free(this.asset)
        this.asset = null
        
        surface_depth_disable(!this.depth)
        //SURFACE_COUNTER.surfaceCreate(this, this.width, this.height, this.format)
        this.asset = surface_create(this.width, this.height, this.format)
        this.updated = true
      }
    }

    if (surface_get_format(this.asset) != this.format) {
      surface_depth_disable(!this.depth)
      //SURFACE_COUNTER.surfaceCreate(this, this.width, this.height, this.format)
      this.asset = surface_create(this.width, this.height, this.format)
      this.updated = true
    }

    if (surface_get_width(this.asset) != this.width
      || surface_get_height(this.asset) != this.height) {

      surface_resize(this.asset, this.width, this.height);
      this.updated = true
    }
    return this
  }

  ///@param {Callable} callback
  ///@param {any} [data]
  ///@param {Boolean} [gpuSetSurface]
  ///@return {Surface}
  renderOn = function(callback, data = null, gpuSetSurface = true) {
    if (!Core.isType(this.asset, GMSurface)) {
      Logger.error("Surface", "renderOn fatal error")
      return this
    }

    if (gpuSetSurface) {
      GPU.set.surface(this)
      callback(data)
      GPU.reset.surface()
    } else {
      callback(data)
    }

    return this
  }

  ///@return {Surface}
  render = function(x = 0, y = 0, alpha = 1.0) {
    if (!Core.isType(this.asset, GMSurface)) {
      Logger.error("Surface", "render fatal error")
      return this
    }

    draw_surface_ext(this.asset, x, y, 1.0, 1.0, 0.0, c_white, alpha)
    return this
  }

  ///@param {Number} width
  ///@param {Number} height
  ///@param {Number} [x]
  ///@param {Number} [y]
  ///@param {Number} [alpha]
  ///@param {GMColor} [blend]
  ///@param {?BlendConfig} [blendConfig]
  ///@return {Surface}
  renderStretched = function(width, height, x = 0, y = 0, alpha = 1.0, blend = c_white, blendConfig = null) {
    if (!Core.isType(this.asset, GMSurface)) {
      Logger.error("Surface", "render fatal error")
      return this
    }

    if (blendConfig != null) {
      blendConfig.set()
      draw_surface_stretched_ext(this.asset, x, y, ceil(width), ceil(height), blend, alpha)
      blendConfig.reset()
    } else {
      draw_surface_stretched_ext(this.asset, x, y, ceil(width), ceil(height), blend, alpha)
    }

    return this
  }

  ///@param {Number} [x]
  ///@param {Number} [y]
  ///@param {Number} [angle]
  ///@param {Number} [alpha]
  ///@param {Number} [xOrigin]
  ///@param {Number} [yOrigin]
  ///@param {Number} [xScale]
  ///@param {Number} [yScale]
  ///@return {Surface}
  renderScaledAndRotated = function(x = 0, y = 0, angle = 0.0, alpha = 1.0, xOrigin = 0.5, yOrigin = 0.5, xScale = 1.0, yScale = 1.0) {
    var surfaceXOrigin = this.width * xOrigin
    var surfaceYOrigin = this.height * yOrigin
    var surfaceXOriginBegin = 0
    var surfaceYOriginBegin = 0
    var surfaceXOriginEnd = this.width
    var surfaceYOriginEnd = this.height
    var xPoint = x + ((this.width * xOrigin) - (dcos(angle) * (surfaceXOrigin * xScale)) - (dsin(angle) * (surfaceYOrigin * yScale)));
    var yPoint = y + ((this.height * yOrigin) - (dcos(angle) * (surfaceYOrigin * yScale)) + (dsin(angle) * (surfaceXOrigin * xScale)));
    draw_surface_general(
			this.asset,
			surfaceXOriginBegin,
			surfaceYOriginBegin,
			surfaceXOriginEnd,
			surfaceYOriginEnd,
			xPoint,
			yPoint,
			xScale,
			yScale,
			angle,
			c_white,
			c_white,
			c_white,
			c_white,
			alpha
    )
    return this
  }

  ///@param {Number} width
  ///@param {Number} height
  ///@return {Surface}
  scaleToFill = function(width, height) {
    if (width < 2 || height < 2) {
      return this
    }

    if (!Core.isType(this.asset, GMSurface)) {
      Logger.error("Surface", "scaleToFill fatal error")
      return this
    }
    
    var surfaceWidth = surface_get_width(this.asset)
    var surfaceHeight = surface_get_height(this.asset)
    var scale = max(width / surfaceWidth, height / surfaceHeight)
    this.width = ceil(surfaceWidth * scale)
    this.height = ceil(surfaceHeight * scale)
    surface_resize(this.asset, this.width, this.height)
    return this
  }

  free = function() {
    if (Core.isType(this.asset, GMSurface)) {
      //SURFACE_COUNTER.surfaceFree(this)
      surface_free(this.asset)
    }
  }
}


/*
#macro SURFACE_COUNTER global.surfaceCounter
global.surfaceCounter = {
  count: 0,
  surfaces: null,
  uidPointer: int64(0),
  generateUid: function() {
    if (SURFACE_COUNTER.uidPointer >= MAX_INT_64 - 1) {
      Logger.warn("Surface", $"Reached maximum available value for uidPointer ('{MAX_INT_64}'). Reset uidPointer to '0'")
      SURFACE_COUNTER.uidPointer = int64(0)
    }
    SURFACE_COUNTER.uidPointer++
    return md5_string_utf8(string(SURFACE_COUNTER.uidPointer))
  },
  surfaceCreate: function(context, width, height, format) {
    context.key = SURFACE_COUNTER.generateUid()
    context.asset = surface_create(width, height, format)
    SURFACE_COUNTER.addKey(context.key)
    Core.print("surface create", context.key)
  },
  surfaceFree: function(context) {
    surface_free(context.asset)
    SURFACE_COUNTER.removeKey(context.key)
    Core.print("surface free", context.key)
  },
  addKey: function(key) {
    if (SURFACE_COUNTER.surfaces == null) {
      SURFACE_COUNTER.surfaces = new Map(String, Boolean)
    }

    if (SURFACE_COUNTER.surfaces.contains(key)) {
      Logger.error("Surface", $"addKey: key exists: {key}")
      return
    }

    SURFACE_COUNTER.count++
    SURFACE_COUNTER.surfaces.add(true, key)
  },
  removeKey: function(key) {
    if (SURFACE_COUNTER.surfaces == null) {
      SURFACE_COUNTER.surfaces = new Map(String, Boolean)
    }

    if (!SURFACE_COUNTER.surfaces.contains(key)) {
      Logger.error("Surface", $"removeKey: key exists exists: {key}")
      return
    }

    SURFACE_COUNTER.surfaces.remove(key)
  },
  report: function() {
    Logger.test("Surface", $"size: {SURFACE_COUNTER.surfaces.size()}, count: {SURFACE_COUNTER.count}")
  }
}
*/