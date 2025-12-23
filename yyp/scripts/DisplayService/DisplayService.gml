///@package io.alkapivo.core.service

///@enum
function _Cursor(): Enum() constructor {
  DEFAULT = cr_default
  RESIZE_HORIZONTAL = cr_size_we
  RESIZE_VERTICAL = cr_size_ns
  NONE = cr_none
}
global.__Cursor = new _Cursor()
#macro Cursor global.__Cursor


///@enum
function _TimingMethod(): Enum() constructor {
  SLEEP = tm_sleep
  COUNTSYNC = tm_countvsyncs
  COUNTSYNC_WINALT = tm_countvsyncs_winalt
  SYSTEMTIMING = tm_systemtiming
}
global.__TimingMethod = new _TimingMethod()
#macro TimingMethod global.__TimingMethod


///@param {Controller} _controller
///@param {Struct} [config]
function DisplayService(_controller, config = {}): Service() constructor {

  ///@type {Controller}
  controller = Assert.isType(_controller, Struct)

	///@type {Number}
	windowWidth = Struct.getIfType(config, "windowWidth", Number, 960)
	
	///@type {Number}
	windowHeight = Struct.getIfType(config, "windowHeight", Number, 540)

  ///@type {Number}
  minWidth = Struct.getIfType(config, "minWidth", Number, 320)

  ///@type {Number}
  minHeight = Struct.getIfType(config, "minHeight", Number, 240)

  ///@type {Number}
  beforeFullscreenWidth = Struct.getIfType(config, "windowWidth", Number, 960)
	
	///@type {Number}
	beforeFullscreenHeight = Struct.getIfType(config, "windowHeight", Number, 540)

  ///@type {Number}
  scale = Core.isType(Struct.get(config, "scale"), Number) ? config.scale : 1

  ///@private
  ///@type {String}
	state = "required"

  ///@private
  ///@type {Timer}
  timer = new Timer(FRAME_MS * 20)

  ///@private
	///@type {Number}
	previousWidth = this.beforeFullscreenWidth
	
  ///@private
	///@type {Number}
	previousHeight = this.beforeFullscreenHeight

  ///@private
  ///@type {Number}
  previousGuiWidth = this.windowWidth * this.scale

  ///@private
  ///@type {Number}
  previousGuiHeight = this.windowHeight * this.scale

  ///@private
  ///@type {DisplayTimingMethodConstant}
  timingMethod = TimingMethod.getDefault(Core.getProperty("core.display-service.timing-method"), TimingMethod.COUNTSYNC)

  ///@private
  ///@type {Number}
  sleepMargin = Core.getProperty("core.display-service.sleep-margin", 10)

  ///@return {DisplayService}
  init = function() {
    Logger.info("DisplayService", $"Setup timing method {TimingMethod.getKey(this.timingMethod)}")
    display_set_timing_method(this.timingMethod)

    Logger.info("DisplayService", $"Setup sleep margin {this.sleepMargin}")
    display_set_sleep_margin(this.sleepMargin)
    return this
  }

  ///@return {Number}
  getWidth = function() {
    return window_get_width()
  }

  ///@return {Number}
  getHeight = function() {
    return window_get_height()
  }

  ///@return {Number}
  getDisplayWidth = function() {
    return display_get_width()
  }

  ///@return {Number}
  getDisplayHeight = function() {
    return display_get_height()
  }

  ///@return {Boolean}
  getFullscreen = function() {
    return window_get_fullscreen() == true
  }

  ///@return {Boolean} [enable]
  ///@return {DisplayService}
  setFullscreen = function(enable = true) {
    var fullscreen = this.getFullscreen()
    window_set_fullscreen(enable)
    if (enable && !fullscreen) { 
      this.beforeFullscreenWidth = this.previousWidth
      this.beforeFullscreenHeight = this.previousHeight
      this.resize(this.getWidth(), this.getHeight())
    }

    if (!enable && fullscreen) {
      this.resize(this.beforeFullscreenWidth, this.beforeFullscreenHeight)
    }
    return this
  }

  ///@return {Boolean}
  getBorderlessWindow = function() {
    return !window_get_showborder()
  }

  ///@return {Boolean} [enable]
  ///@return {DisplayService}
  setBorderlessWindow = function(enable = true) {
    window_set_showborder(!enable)
    window_enable_borderless_fullscreen(enable)
    return this
  }

  ///@return {Cursor}
  getCursor = function(cursor) {
    return window_get_cursor()
  }

  ///@param {Cursor} cursor
  ///@return {DisplayService}
  setCursor = function(cursor) {
    window_set_cursor(cursor)
    return this
  }

  ///@return {String}
  getCaption = function() {
    return window_get_caption()
  }

  ///@param {String} caption
  ///@return {DisplayService}
  setCaption = function(caption) {
    window_set_caption(caption)
    return this
  }

  ///@return {DisplayService}
  center = function() {
    if (this.getFullscreen()) {
      return this
    }

    var xOffset = Core.getProperty("core.display-service.center.offset.x", 0.0)
    var yOffset = Core.getProperty("core.display-service.center.offset.y", 0.0)
    window_set_position(
      ((this.getDisplayWidth() - this.getWidth()) / 2.0) + xOffset,
      ((this.getDisplayHeight() - this.getHeight()) / 2.0) + yOffset
    )

    return this
  }
 

  ///@param {Number} _width
  ///@param {Number} _height
  ///@return {DisplayService}
  resize = function(_width, _height) {
    var width = Math.getEvenCeil(max(this.minWidth, _width))
    var height = Math.getEvenCeil(max(this.minHeight, _height))
    try {
      var guiWidth = Math.getEvenCeil(width / this.scale)
      var guiHeight = Math.getEvenCeil(height / this.scale)
      Logger.debug("DisplayService", $"Resize window from {this.previousWidth}x{this.previousHeight} to {width}x{height}, scale: {this.scale}")
      display_set_gui_size(guiWidth, guiHeight)
      window_set_size(width, height)
      surface_resize(application_surface, guiWidth, guiHeight)
      this.windowWidth = this.getWidth()
      this.windowHeight = this.getHeight()
    } catch (exception) {
      Logger.error("ResizeEvent", exception.message)
      Core.printStackTrace().printException(exception)
    }
    return this
  }

  ///@return {DisplayService}
  update = function() {
    static isResizeRequired = function(context) {
      return context.previousWidth != window_get_width()
        || context.previousHeight != window_get_height()
        || context.previousGuiWidth != display_get_gui_width()
        || context.previousGuiHeight != display_get_gui_height()
    }

    timingMethod = display_get_timing_method()
    if (timingMethod != this.timingMethod) {
      Logger.info("DisplayService", $"Update timing method to {TimingMethod.getKey(this.timingMethod)}")
      display_set_timing_method(this.timingMethod)
    }

    if (this.timingMethod == tm_sleep) {
      var sleepMargin = display_get_sleep_margin()
      if (sleepMargin != this.sleepMargin) {
        Logger.info("DisplayService", $"Update sleep margin from {sleepMargin} to {this.sleepMargin}")
        display_set_sleep_margin(this.sleepMargin)
      }
    }

    if (this.state == "idle" || this.state == "resized") {
      this.state = isResizeRequired(this) ? "required" : "idle"
    }

    if (this.state == "required" && this.timer.update().finished) {
      var width = window_get_width()
      var height = window_get_height()
      if (width > 0 && height > 0) {
        this.resize(width, height)
        this.timer.reset()
        this.state = "resized"
      }
    }

    if (this.state == "idle" || this.state == "resized") {
      this.previousWidth = window_get_width()
      this.previousHeight = window_get_height()
      this.previousGuiWidth = display_get_gui_width()
      this.previousGuiHeight = display_get_gui_height()
    }
    return this
  }

  this.init()
}
