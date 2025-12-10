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
  shaderGaussianBlur = ShaderUtil.fetch("shader_gaussian_blur")

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

      var a1 = String.format(fps, 4, 0)
      var a2 = String.format(this.debugMinFPS, 4, 0)
      var b1 = String.format(fpsReal, 4, 0)
      var b2 = String.format(gridService.avgCircular.value, 4, 0)
      var c1 = String.format(updateSum, 2, 2)
      var c2 = String.format(renderSum, 2, 2)
      var d1 = String.format(timeSum, 2, 2)
      var d2 = String.format(gridService.avgTime.get(), 2, 2)
      var e1 = String.format(shrooms, 4, 0)
      var e2 = String.format(bullets, 4, 0)
      var f1 = String.format(deltaTime, 1, 5)
      var f2 = String.format(this.debugMaxDelta, 1, 5)
      var text = "" 
        + $"fps:     {a1}    | fps-real:     {b1}\n"
        + $"fps-min: {a2}    | fps-real-avg: {b2}\n"    
        +  "-----------------|-------------------\n"
        + $"update: { c1} ms | total:    { d1} ms\n"
        + $"render: { c2} ms | avg:      { d2} ms\n"
        +  "-----------------|-------------------\n"
        + $"shrooms: {e1}    | dt:        {   f1}\n"
        + $"bullets: {e2}    | dt-max:    {   f2}\n"
      
      /*
            fps:     xxxx    | fps-real:     xxxx
            fps-min: xxxx    | fps-real-avg: xxxx    
            -----------------|-------------------
            update: xxxxx ms | total:    xxxxx ms
            render: xxxxx ms | avg:      xxxxx ms
            -----------------|-------------------
            shrooms: xxxx    | dt:        xxxxxxx
            bullets: xxxx    | dt-max:    xxxxxxx
      */

      GPU.render.text(
        layout.x() + layout.width() - 60, 
        layout.y() + 80, 
        text, 
        1.0, 
        0.0, 
        1.0, 
        c_lime, 
        GPU_DEFAULT_FONT_BOLD, 
        HAlign.RIGHT, 
        VAlign.TOP, 
        c_black, 
        1.0
      )
    }

    var gridCamera = this.gridRenderer.camera
    var gridCameraMessage = ""
    if ((enableEditor || enableDebugOverlay)
        && (gridCamera.enableKeyboardLook || gridCamera.enableMouseLook)) {

      var g1 = String.format(gridCamera.x + (sin(this.gridRenderer.camera.breathTimer2.time) * GRID_SERVICE_PIXEL_WIDTH * -1.0), 4, 2)
      var g2 = String.format(gridCamera.y, 4, 2)
      var g3 = String.format(gridCamera.z, 4, 2)
      var g4 = String.format(gridCamera.pitch + (sin(this.gridRenderer.camera.breathTimer1.time) * BREATH_TIMER_FACTOR_1), 4, 2)
      var g5 = String.format(gridCamera.angle + (sin(this.gridRenderer.camera.breathTimer2.time / 4.0) * BREATH_TIMER_FACTOR_2), 4, 2)
      var h1 = String.format(gridService.view.x, 4, 2)
      var h2 = String.format(gridService.view.x, 4, 2)
      gridCameraMessage += ""
        + $"| x:         {g1}\n"
        + $"| y:         {g2}\n"
        + $"| z:         {g3}\n"
        + $"| pitch:     {g4}\n"
        + $"| angle:     {g5}\n"
        + $"|-------------------\n"
        + $"| view.x:    {h1}\n"
        + $"| view.y:    {h2}\n"
      /*
            | x:         xxxx.xx
            | y:         xxxx.xx
            | z:         xxxx.xx
            | pitch:     xxxx.xx
            | angle:     xxxx.xx
            |-------------------
            | view.x:    xxxx.xx
            | view.y:    xxxx.xx
      */

      var player = controller.playerService.player
      var i1 = String.format((player == null ? 0.0 : player.x), 4, 2)
      var i2 = String.format((player == null ? 0.0 : player.y), 4, 2)
      gridCameraMessage += player == null ? "" :
        + $"|-------------------\n"
        + $"| player.x:  {i1}\n"
        + $"| player.y:  {i2}\n"
      /*
            |-------------------
            | player.x:  xxxx.xx
            | player.y:  xxxx.xx
      */

      GPU.render.text(
        layout.x() + layout.width() - 60,
        layout.y() + layout.height() - 80,
        gridCameraMessage,
        1.0,
        0.0,
        1.0, 
        c_lime,
        GPU_DEFAULT_FONT_BOLD,
        HAlign.RIGHT,
        VAlign.BOTTOM,
        c_black,
        1.0
      )
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
  ///@param {Task} task
  ///@param {Number|String} iterator
  ///@param {UILayout} layout
  renderTextureLoad = function(task, iterator, layout) {
    if (task.name == "texture-load-task") {
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

    var renderBlur = Visu.settings.getValue("visu.debug.render-surfaces")
      ? this.gridRenderer.renderDebugSurfaces
      : this.gridRenderer.renderGUIGameSurface

    GPU.set.shader(this.shaderGaussianBlur)
    var uniform = this.shaderGaussianBlur.uniforms.get("u_resolution")
    uniform.setter(uniform.asset, layout.width(), layout.height())
    this.shaderGaussianBlur.uniforms.get("u_size").set(this.blur.update().value)
    renderBlur(layout)
    GPU.reset.shader()

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
      if (stateName == "load") {
        this.executor.tasks.forEach(this.renderTextureLoad, this.layout)
      }
      
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