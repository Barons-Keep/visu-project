///@package io.alkapivo.visu.renderer

///@enum
function _WallpaperType(): Enum() constructor {
  BACKGROUND = "BACKGROUND"
  GRID = "GRID"
  FOREGROUND = "FOREGROUND"

  ///@override
  ///@return {Array<String>}
  keys = function() {
    static filterKeys = function(key) {
      return key != "_keys"
          && key != "keys"
          && key != "get"
          && key != "getKey"
          && key != "findKey"
          && key != "contains"
          && key != "containsKey"
    }

    if (this._keys == null) {
      this._keys = new Array(String, GMArray.sort(GMArray.filter(Struct.keys(this), filterKeys)))
    }

    return this._keys
  }
}
global.__WallpaperType = new _WallpaperType()
#macro WallpaperType global.__WallpaperType


///@type {GMArray<String>}
global.__VISU_FONT = [
  "font_kodeo_mono_10_regular",
  "font_kodeo_mono_12_regular",
  "font_kodeo_mono_18_regular",
  "font_kodeo_mono_28_regular",
  "font_kodeo_mono_48_regular",

  "font_kodeo_mono_10_bold",
  "font_kodeo_mono_12_bold",
  "font_kodeo_mono_18_bold",
  "font_kodeo_mono_28_bold",
  "font_kodeo_mono_48_bold",

  "font_inter_8_regular",
  "font_inter_10_regular",
  "font_inter_12_regular",
  "font_inter_18_regular",
  "font_inter_24_regular",
  "font_inter_28_regular",

  "font_inter_8_bold",
  "font_inter_10_bold",
  "font_inter_12_bold",
  "font_inter_18_bold",
  "font_inter_24_bold",
  "font_inter_28_bold",

  "font_consolas_10_regular",
  "font_consolas_12_regular",
  "font_consolas_18_regular",
  "font_consolas_28_regular",

  "font_consolas_10_bold",
  "font_consolas_12_bold",
  "font_consolas_18_bold",
  "font_consolas_28_bold"
]
#macro VISU_FONT global.__VISU_FONT


function VisuRenderer() constructor {

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this, {
    loggerPrefix: "VisuRenderer",
    enableLogger: true,
    catchException: false,
  })

  ///@type {GridRenderer}
  gridRenderer = new GridRenderer()

  ///@type {SubtitleRenderer}
  subtitleRenderer = new SubtitleRenderer()

  ///@type {VisuHUDRenderer}
  hudRenderer = new VisuHUDRenderer()

  ///@type {DialogueRenderer}
  dialogueRenderer = new DialogueRenderer()

  ///@type {UILayout}
  layout = new UILayout({
    name: "visu-game-layout",
    x: function() { return 0 },
    y: function() { return 0 },
    width: GuiWidth,
    height: GuiHeight,
  })

  ///@type {Number}
  spinnerFactor = 0
  
  ///@type {Timer}
  initTimer = new Timer(0.5)

  ///@type {Timer}
  fadeTimer = new Timer(0.25)

  ///@type {NumberTransformer}
  blur = new NumberTransformer({
    value: 0.0,
    target: 24.0,
    factor: 0.5,
    increase: 0.002,
  })

  ///@private
  ///@type {Sprite}
  spinner = Assert.isType(SpriteUtil.parse({ 
    name: "texture_spinner", 
    scaleX: 0.5, 
    scaleY: 0.5,
  }), Sprite, "VisuRenderer::spiner must be type of Sprite")

  ///@private
  ///@type {Font}
  font = new Font(font_kodeo_mono_18_bold)

  ///@private
  ///@type {Number}
  debugFPSLowCooldown = 0.0

  ///@private
  ///@type {Number}
  debugMinFPS = GAME_FPS

  ///@private
  ///@type {Number}
  debugDeltaHighCooldown = 0.0

  ///@private
  ///@type {Number}
  debugMaxDelta = 1.0

  ///@private
  ///@type {Struct}
  Assert.isTrue(shader_is_compiled(shader_gaussian_blur), "shader_gaussian_blur must be compiled")
  shaderGaussianBlur = {
    uniformSize: shader_get_uniform(shader_gaussian_blur, "size"),
    setSize: function(width, height, value) {
      shader_set_uniform_f(this.uniformSize, width, height, value)
      return this
    },
    setShader: function() {
      shader_set(shader_gaussian_blur)
      return this
    },
    render: function(handler, data) {
      handler(data)
      return this
    },
    resetShader: function() {
      shader_reset()
      return this
    },
  }

  ///@private
  ///@type {Boolean}
  renderEditorMode = Core.getProperty("visu.editor.renderEditorMode", false)

  ///@private
  ///@param {UILayout} layout
  ///@return {VisuRenderer}
  renderSpinner = function(layout) {
    var controller = Beans.get(BeanVisuController)
    var loaderState = controller.loader.fsm.getStateName()
    if (loaderState != "idle" && loaderState != "cooldown" && loaderState != "loaded") {
      this.spinnerFactor = lerp(this.spinnerFactor, 100.0, 0.08)

      var color = c_black
      var alpha = clamp((this.spinnerFactor / 100) * 0.85, 0.0, 1.0)
      if (alpha > 0) {
        GPU.render.rectangle(0, 0, GuiWidth(), GuiHeight(), false, 
          color, color, color, color, alpha * 0.5)
      }

      this.spinner
        .setAngle(30.0 * (this.spinnerFactor / 100))
        .setAlpha(alpha)
        .render(GuiWidth() / 2.0, (GuiHeight() * 0.75) - this.spinnerFactor)
    } else if (this.spinnerFactor > 0) {
      this.spinnerFactor = lerp(this.spinnerFactor, 0.0, 0.08)

      var color = c_black
      var alpha = clamp((this.spinnerFactor / 100) * 0.85, 0.0, 1.0)
      if (alpha > 0) {
        GPU.render.rectangle(
          0, 0, 
          GuiWidth(), GuiHeight(), 
          false, 
          color, color, color, color, 
          alpha * 0.5
        )
      }

      this.spinner
        .setAngle(-30.0 * (this.spinnerFactor / 100.0))
        .setAlpha(alpha)
        .render(GuiWidth() / 2.0, (GuiHeight() * 0.75) - this.spinnerFactor)
    }

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {VisuRenderer}
  renderDebugGUI = function(layout) {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(Visu.modules().editor.controller)
    var gridService = controller.gridService
    var enableEditor = editor != null && editor.renderUI
    var enableDebugOverlay = is_debug_overlay_open()

    if (this.debugFPSLowCooldown > 0) {
      this.debugFPSLowCooldown--
    } else {
      this.debugMinFPS = GAME_FPS
    }

    var fpsReal = round(fps_real)
    if (fpsReal < this.debugMinFPS) {
      this.debugMinFPS = fpsReal
      this.debugFPSLowCooldown = GAME_FPS * 2
    }

    if (this.debugDeltaHighCooldown > 0) {
      this.debugDeltaHighCooldown--
    } else {
      this.debugMaxDelta = DELTA_TIME
    }

    var deltaTime = DELTA_TIME
    if (deltaTime >= this.debugMaxDelta) {
      this.debugMaxDelta = deltaTime
      this.debugDeltaHighCooldown = GAME_FPS * 2
    }
    
    if (enableDebugOverlay) {
      var shrooms = controller.shroomService.shrooms.size()
      var bullets = controller.bulletService.bullets.size()
  
      var renderSum = controller.renderTimer.getValue() + controller.renderGUITimer.getValue()
      var updateSum = controller.updateDebugTimer.getValue() + (enableEditor ? editor.updateDebugTimer.getValue() : 0.0)
      var timeSum = renderSum + updateSum
      gridService.avgTime.add(timeSum)
      gridService.avgCircular.add(fpsReal)

      /*
      fps:     xxxx    | fps-real:     xxxx
      fps-min: xxxx    | fps-real-avg: xxxx    
      -----------------|-----------------------
      update: xxxxx ms | total:       xxxxx ms
      render: xxxxx ms | avg:         xxxxx ms
      -----------------|-----------------------
      shrooms: xxxx    | dt:        xxxxxxx
      bullets: xxxx    | dt-max:    xxxxxxx
      */
      var a1 = String.format(fps, 4, 0) // fps
      var a2 = String.format(this.debugMinFPS, 4, 0) // fps-min
      var b1 = String.format(gridService.avgCircular.value, 4, 0) // fps-real
      var b2 = String.format(gridService.avgCircular.value, 4, 0) // fps-real-avg
      var c1 = String.format(updateSum, 2, 2) // update
      var c2 = String.format(renderSum, 2, 2) // render
      var d1 = String.format(timeSum, 2, 2) // total
      var d2 = String.format(gridService.avgTime.get(), 2, 2) // avg
      var e1 = String.format(shrooms, 4, 0) // shrooms
      var e2 = String.format(bullets, 4, 0) // bullets
      var f1 = String.format(deltaTime, 1, 5)
      var f2 = String.format(this.debugMaxDelta, 1, 5)
      var text = $"fps:     {a1}    | fps-real:     {b1}    \n"
               + $"fps-min: {a2}    | fps-real-avg: {b2}    \n"    
               +  "-----------------|-----------------------\n"
               + $"update: { c1} ms | total:       { d1} ms \n"
               + $"render: { c2} ms | avg:         { d2} ms \n"
               +  "-----------------|-----------------------\n"
               + $"shrooms: {e1}    | dt:        {   f1}    \n"
               + $"bullets: {e2}    | dt-max:    {   f2}    \n"
        
      GPU.render.text(64, 80, text, 1.0, 0.0, 1.0, c_lime, 
        GPU_DEFAULT_FONT_BOLD, HAlign.LEFT, VAlign.TOP, c_black, 1.0)
    }

    var gridCamera = this.gridRenderer.camera
    var gridCameraMessage = ""
    if ((enableEditor || enableDebugOverlay)
        && (gridCamera.enableKeyboardLook || gridCamera.enableMouseLook)) {
      gridCameraMessage = gridCameraMessage 
        + $"x:     {gridCamera.x + (sin(this.gridRenderer.camera.breathTimer2.time) * GRID_SERVICE_PIXEL_WIDTH * -1.0)}\n"
        + $"y:     {gridCamera.y}\n"
        + $"z:     {gridCamera.z}\n"
        + $"pitch: {gridCamera.pitch + (sin(this.gridRenderer.camera.breathTimer1.time) * BREATH_TIMER_FACTOR_1)}\n"
        + $"angle: {gridCamera.angle + (sin(this.gridRenderer.camera.breathTimer2.time / 4.0) * BREATH_TIMER_FACTOR_2)}\n"
        + $"view.x: {gridService.view.x}\n"
        + $"view.y: {gridService.view.y}\n"

      var player = controller.playerService.player
      if (player != null) {
        gridCameraMessage = gridCameraMessage 
          + $"player.x: {player.x}\n"
          + $"player.y: {player.y}\n"
      }
    }
    
    if (gridCameraMessage != "") {
      GPU.render.text(32, GuiHeight() - 32, gridCameraMessage, 1.0, 0.0, 1.0, 
        c_lime, GPU_DEFAULT_FONT_BOLD, HAlign.LEFT, VAlign.BOTTOM, c_black, 1.0)
    }

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {VisuRenderer}
  renderUI = function(layout) {
    var controller = Beans.get(BeanVisuController)
    controller.uiService.render()

    var editor = Beans.get(Visu.modules().editor.controller)
    if (editor != null && editor.renderUI) {
      editor.uiService.render()
    }

    return this
  }

  ///@private
  ///@param {Task} task
  ///@param {Number|String} iterator
  ///@param {UILayout} layout
  renderSplashscreen = function(task, iterator, layout) {
    if (task.name == "splashscreen") {
      task.state.render(task, layout)
    }
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {VisuRenderer}
  renderMenu = function(layout) {
    var controller = Beans.get(BeanVisuController)
    if (controller.menu.enabled) {
      return this
    }

    if (this.blur.target != 0.0) {
      this.blur.target = 0.0
      this.blur.startValue = this.blur.value
      this.blur.reset()
    }
    
    this.gridRenderer.renderGUI(layout)
    this.subtitleRenderer.renderGUI(layout)  
    if (Visu.settings.getValue("visu.interface.render-hud")) {
      this.hudRenderer.renderGUI(layout)
    }

    this.dialogueRenderer.render(layout)

    var editor = Beans.get(Visu.modules().editor.controller)
    var state = controller.fsm.getStateName() 
    if (this.renderEditorMode 
        && editor != null 
        && !editor.renderUI 
        && (state == "idle"
          || state == "play"
          || state == "pause"
          || state == "paused")) {
      var _x = layout.x()
      var _y = layout.y()
      var _width = layout.width()
      var _height = layout.height()
      var xStart = _width * (1.0 - 0.061)
      var yStart = _height * (1.0 - 0.08)
      var text = "SHOW EDITOR [F5]"
      GPU.render.text(_x + xStart, _y + yStart, text, 1.0, 0.0, 0.6, c_white, this.font, HAlign.RIGHT, VAlign.BOTTOM, c_lime, 8.0)
    }
    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {VisuRenderer}
  renderGame = function(layout) {
    if (!Beans.get(BeanVisuController).menu.enabled) {
      return this
    }

    this.blur.update()
    this.shaderGaussianBlur
      .setShader()
      .setSize(layout.width(), layout.height(), this.blur.value)
      .render(Visu.settings.getValue("visu.debug.render-surfaces")
        ? this.gridRenderer.renderDebugSurfaces
        : this.gridRenderer.renderGUIGameSurface, layout)
      .resetShader()
    
    return this
  }

  ///@private
  ///@param {Timer} timer
  ///@return {VisuRenderer}
  renderFadeBackground = function (timer) {
    if (timer.finished) {
      return this
    }

    var alpha = clamp(timer.duration - timer.time, 0.0, 1.0)
    if (alpha <= 0) {
      return this
    }

    GPU.render.rectangle(0, 0, GuiWidth(), GuiHeight(), false, c_black, c_black, c_black, c_black, alpha)
    return this
  }

  ///@return {VisuRenderer}
  update = function() {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(Visu.modules().editor.controller)
    var layout = editor == null ? this.layout : editor.layout.nodes.preview
    var stateName = controller.fsm.getStateName()
    if (stateName != "splashscreen") {
      this.initTimer.update()
      this.fadeTimer.update()
      this.gridRenderer.update(layout)
      this.hudRenderer.update(layout)
      this.dialogueRenderer.update()
    }

    this.executor.update()
    return this
  }
  
  ///@return {VisuRenderer}
  render = function() {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(Visu.modules().editor.controller)
    var layout = editor == null ? this.layout : editor.layout.nodes.preview
    var stateName = controller.fsm.getStateName()
    if (stateName != "splashscreen") {
      this.gridRenderer.render(layout)
    }

    return this
  }

  ///@return {VisuRenderer}
  renderGUI = function() {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(Visu.modules().editor.controller)
    var layout = editor == null ? this.layout : editor.layout.nodes.preview
    var stateName = controller.fsm.getStateName()
    if (stateName == "splashscreen") {
      this.executor.tasks.forEach(this.renderSplashscreen, this.layout)
    } else {
      this.renderMenu(layout)
      this.renderGame(layout)
      this.renderUI(layout)
      this.renderSpinner(layout)
      this.renderDebugGUI(layout)
      this.renderFadeBackground(this.initTimer)
      this.renderFadeBackground(this.fadeTimer)
    }

    return this
  }

  ///@return {VisuRenderer}
  free = function() {
    this.gridRenderer.free()
    return this
  }
}