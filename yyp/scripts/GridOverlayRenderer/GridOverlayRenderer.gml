///@package com.alkapivo.visu.renderer.grid

///@todo rename to sth that reflects video, background and foreground renderer
function GridOverlayRenderer() constructor {

  ///@type {Array<Task>}
  backgrounds = new Array(Task).enableGC()

  ///@type {Array<Task>}
  grids = new Array(Task).enableGC()

  ///@type {Array<Task>}
  foregrounds = new Array(Task).enableGC()

  ///@type {Array<Task>}
  backgroundColors = new Array(Task).enableGC()

  ///@type {Array<Task>}
  gridColors = new Array(Task).enableGC()

  ///@type {Array<Task>}
  foregroundColors = new Array(Task).enableGC()

  ///@private
  ///@type {Struct}
  parameters = {
    width: GuiWidth(),
    height: GuiHeight(),
    x: 0,
    y: 0,
  }

  ///@return {GridOverlayRenderer}
  clear = function() {
    this.backgrounds.clear()
    this.grids.clear()
    this.foregrounds.clear()
    this.backgroundColors.clear()
    this.gridColors.clear()
    this.foregroundColors.clear()
    return this
  }

  ///@param {WallpaperType} type
  ///@return {Array<Task>}
  getTextures = function(type) {
    switch (type) {
      case WallpaperType.BACKGROUND: return this.backgrounds
      case WallpaperType.GRID: return this.grids
      case WallpaperType.FOREGROUND: return this.foregrounds
      default: return this.backgrounds
    }
  }

  ///@param {WallpaperType} type
  ///@return {Array<Task>}
  getColors = function(type) {
    switch (type) {
      case WallpaperType.BACKGROUND: return this.backgroundColors
      case WallpaperType.GRID: return this.gridColors
      case WallpaperType.FOREGROUND: return this.foregroundColors
      default: return this.backgroundColors
    }
  }

  ///@param {Task} tassk
  ///@param {Number} index
  ///@param {Struct} acc
  renderColor = function(task, index, acc) {
    var color = task.state.get("color")
    var alpha = color.alpha
    color = color.toGMColor()
    GPU.set.blendModeExt(task.state.get("blendModeSource"), task.state.get("blendModeTarget"))
    GPU.set.blendEquation(task.state.get("blendEquation"), task.state.get("blendEquationAlpha"))
    GPU.render.rectangle(0, 0, acc.width, acc.height, false, color, color, color, color, alpha)
    GPU.reset.blendEquation()
    GPU.reset.blendMode()
  }

  ///@param {Task} task
  ///@param {Number} index
  ///@param {Struct} acc
  renderTexture = function(task, index, acc) {
    var width = acc.width
    var height = acc.height
    task.state.set("surfaceWidth", width)
    task.state.set("surfaceHeight", height)

    var sprite = task.state.get("sprite")
    sprite.scaleToFill(width, height)
    sprite.setScaleX(sprite.scaleX * task.state.get("xScale"))
    sprite.setScaleY(sprite.scaleY * task.state.get("yScale"))

    var coordX = ((sprite.texture.offsetX / sprite.texture.width) * width)
      - (ceil(((sprite.texture.width * sprite.getScaleX()) - width) / 2.0) + task.state.get("x"))
      - acc.x
    var coordY = ((sprite.texture.offsetY / sprite.texture.height) * height)
      - (ceil(((sprite.texture.height * sprite.getScaleY()) - height) / 2.0) + task.state.get("y"))
      - acc.y

    GPU.set.blendModeExt(task.state.get("blendModeSource"), task.state.get("blendModeTarget"))
    GPU.set.blendEquation(task.state.get("blendEquation"), task.state.get("blendEquationAlpha"))

    if (task.state.get("tiled")) {
      sprite.renderTiled(coordX, coordY)
    } else {
      sprite.render(coordX, coordY)
    }

    GPU.reset.blendEquation()
    GPU.reset.blendMode()
  }

  ///@param {Number} width
  ///@param {Number} height
  ///@return {GridOverlayRenderer}
  renderBackgrounds = function(width, height) {
    this.parameters.width = width
    this.parameters.height = height
    this.parameters.x = 0.0
    this.parameters.y = 0.0
    this.backgroundColors.forEach(this.renderColor, this.parameters)
    if (Visu.settings.getValue("visu.graphics.bkg-tx")) {
      this.backgrounds.forEach(this.renderTexture, this.parameters)
    }
    return this
  }

  ///@param {Number} width
  ///@param {Number} height
  ///@param {Number} [x]
  ///@param {Number} [y]
  ///@return {GridOverlayRenderer}
  renderGrids = function(width, height, x = 0.0, y = 0.0) {
    this.parameters.width = width
    this.parameters.height = height
    this.parameters.x = x
    this.parameters.y = y
    this.gridColors.forEach(this.renderColor, this.parameters)
    this.grids.forEach(this.renderTexture, this.parameters)
    return this
  }

  ///@param {Number} width
  ///@param {Number} height
  ///@return {GridOverlayRenderer}
  renderForegrounds = function(width, height) {
    this.parameters.width = width
    this.parameters.height = height
    this.parameters.x = 0.0
    this.parameters.y = 0.0
    this.foregroundColors.forEach(this.renderColor, this.parameters)
    if (Visu.settings.getValue("visu.graphics.frg-tx")) {
      this.foregrounds.forEach(this.renderTexture, this.parameters)
    }

    return this
  }

  ///@param {Number} width
  ///@param {Number} height
  ///@param {Number} [alpha]
  ///@param {GMColor} [blend]
  ///@param {?BlendConfig} [blendConfig]
  ///@return {GridOverlayRenderer}
  renderVideo = function(width, height, alpha = 1.0, blend = c_white, blendConfig = null) {
    var videoService = Beans.get(BeanVisuController).videoService
    var video = videoService.getVideo()
    if (!Core.isType(video, Video) || !video.isLoaded()) {
      return this
    }

    video.surface.update()

    var scale = max(width / video.surface.width, height / video.surface.height)
    var _width = ceil(video.surface.width * scale)
    var _height = ceil(video.surface.height * scale)
    var _x = -1 * ceil((_width - width) / 2.0)
    var _y = -1 * ceil((_height - height) / 2.0)
    video.surface.render(_x, _y, _width, _height, alpha, blend, blendConfig)    
    return this
  }

  ///@return {GridOverlayRenderer}
  update = function() {
    static gcFilter = function(task, index, gc) {
      if (!Core.isType(task, Task)
        || task.name != "fade-sprite"
        || task.status == TaskStatus.FULLFILLED
        || task.status == TaskStatus.REJECTED
        || !Core.isType(task.state.get("sprite"), Sprite)) {
        
        gc.add(index)
      }
    }

    static gcColorFilter = function(task, index, gc) {
      if (!Core.isType(task, Task)
        || task.name != "fade-color"
        || task.status == TaskStatus.FULLFILLED
        || task.status == TaskStatus.REJECTED
        || !Core.isType(task.state.get("color"), Color)) {
        
        gc.add(index)
      }
    }
    
    this.backgrounds.forEach(gcFilter, this.backgrounds.gc).runGC()
    this.grids.forEach(gcFilter, this.grids.gc).runGC()
    this.foregrounds.forEach(gcFilter, this.foregrounds.gc).runGC()

    this.backgroundColors.forEach(gcColorFilter, this.backgroundColors.gc).runGC()
    this.gridColors.forEach(gcColorFilter, this.gridColors.gc).runGC()
    this.foregroundColors.forEach(gcColorFilter, this.foregroundColors.gc).runGC()
    return this
  }
}
