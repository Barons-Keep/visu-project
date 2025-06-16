///@package io.alkapivo.visu.renderer

function VisuRenderer() constructor {

  ///@type {GridRenderer}
  gridRenderer = new GridRenderer()

  ///@type {SubtitleRenderer}
  subtitleRenderer = new SubtitleRenderer()

  ///@type {VisuHUDRenderer}
  hudRenderer = new VisuHUDRenderer()

  ///@type {DialogueRenderer}
  dialogueRenderer = new DialogueRenderer()

  ///@type {FSM}
  fsm = new FSM(this, {
    displayName: "VisuRenderer",
    initialState: { name: "splashscreen" },
    states: {
      "splashscreen": {
        actions: {
          onStart: function(fsm, fsmState, data) {

          },
        },
        update: function(fsm) {
          fsm.dispatcher.send(new Event("transition", { name: "idle" }))
        },
        transitions: {
          "splashscreen": null,
          "idle": null,
        },
      },
      "idle": {
        actions: {
          onStart: function(fsm, fsmState, data) {

          },
        },
        update: function(fsm) {

        },
        transitions: {
          "splashscreen": null,
          "idle": null,
        },
      }
    }
  })

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@private
  ///@type {UILayout}
  layout = new UILayout({
    name: "visu-game-layout",
    x: function() { return 0 },
    y: function() { return 0 },
    width: GuiWidth,
    height: GuiHeight,
  })

  ///@private
  ///@type {Sprite}
  spinner = Assert.isType(SpriteUtil
    .parse({ 
      name: "texture_spinner", 
      scaleX: 0.5, 
      scaleY: 0.5,
    }), Sprite, "VisuRenderer.spiner must be type of Sprite")

  ///@private
  ///@type {Number}
  spinnerFactor = 0
  
  ///@private
  ///@type {Timer}
  initTimer = new Timer(0.5)

  ///@type {Timer}
  fadeTimer = new Timer(0.25)

  ///@private
  ///@type {NumberTransformer}
  blur = new NumberTransformer({
    value: 0.0,
    target: 24.0,
    factor: 0.5,
    increase: 0.002,
  })

  ///@private
  ///@type {Font}
  font = new Font(font_kodeo_mono_18_bold)

  ///@private
  ///@type {Boolean}
  renderEditorMode = Core.getProperty("visu.editor.renderEditorMode", false)

  ///@private
  ///@type {Number}
  debugFPSLowCooldown = 0.0

  ///@private
  ///@type {Number}
  debugMinFPS = GAME_FPS

  ///@private
  ///@return {VisuRenderer}
  init = function() {
    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {VisuRenderer}
  renderSpinner = function(layout) {
    var controller = Beans.get(BeanVisuController)
    var loaderState = controller.loader.fsm.getStateName()
    if (loaderState != "idle" && loaderState != "cooldown" && loaderState != "loaded") {
      var color = c_black
      this.spinnerFactor = lerp(this.spinnerFactor, 100.0, 0.08)

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
        .setAngle(30.0 * (this.spinnerFactor / 100))
        .setAlpha(alpha)
        .render(GuiWidth() / 2.0, (GuiHeight() * 0.75) - this.spinnerFactor)
    } else if (this.spinnerFactor > 0) {
      var color = c_black
      this.spinnerFactor = lerp(this.spinnerFactor, 0.0, 0.08)

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
    /*
    var editor = Beans.get(BeanVisuEditorController)
    if (Optional.is(editor)) {
      editor.uiService.containers.forEach(function(container, index) {
        GPU.render.text(
          60,
          60 + (24 * index),
          $"#{index}: {container.name}",
          1.0,
          0.0,
          1.0,
          c_lime,
          GPU_DEFAULT_FONT_BOLD,
          HAlign.LEFT,
          VAlign.TOP,
          c_black,
          1.0
        )  
      })
    }
    */
    
    var editor = Beans.get(BeanVisuEditorController)
    var controller = Beans.get(BeanVisuController)
    var gridService = controller.gridService
    var enableEditor = Optional.is(editor) && editor.renderUI
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
    
    if (enableDebugOverlay) {
      var shrooms = controller.shroomService.shrooms.size()
      var bullets = controller.bulletService.bullets.size()
  
      var renderSum = controller.renderTimer.getValue() + controller.renderGUITimer.getValue()
      var updateSum = controller.updateDebugTimer.getValue() + (enableEditor ? editor.updateDebugTimer.getValue() : 0.0)
      var timeSum = renderSum + updateSum
      gridService.avgTime.add(timeSum)
      gridService.avgCircular.add(fpsReal)
      var text = $"fps: {String.format(round(fps), 2, 0)}, fps-min: {String.format(this.debugMinFPS, 2, 0)}, fps-real-avg: {String.format(gridService.avgCircular.value, 3, 0)}, fps-real: {String.format(fpsReal, 3, 0)}" + "\n"
        + $"update: {String.format(updateSum, 2, 2)}ms, render: {String.format(renderSum, 2, 2)}ms, total: {String.format(timeSum, 2, 2)}ms, avg: {String.format(gridService.avgTime.get(), 2, 2)}ms" + "\n"
        + $"shrooms: {String.format(shrooms, 4, 0)}, bullets: {String.format(bullets, 4, 0)}" + "\n"
        
      GPU.render.text(
        64,
        80,
        text,
        1.0,
        0.0,
        1.0,
        c_lime,
        GPU_DEFAULT_FONT_BOLD,
        HAlign.LEFT,
        VAlign.TOP,
        c_black,
        1.0
      )
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
        + $"angle: {gridCamera.angle + (sin(this.gridRenderer.camera.breathTimer2.time) * BREATH_TIMER_FACTOR_2)}\n"
        + $"view.x: {gridService.view.x}\n"
        + $"view.y: {gridService.view.y}\n"

      var player = controller.playerService.player
      if (Optional.is(player)) {
        gridCameraMessage = gridCameraMessage 
          + $"player.x: {player.x}\n"
          + $"player.y: {player.y}\n"
      }
    }
    
    if (gridCameraMessage != "") {
      GPU.render.text(
        32,
        GuiHeight() - 32,
        gridCameraMessage,
        1.0,
        0.0,
        1.0,
        c_lime,
        GPU_DEFAULT_FONT_BOLD,
        HAlign.LEFT,
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
    var editor = Beans.get(BeanVisuEditorController)
    if (Core.isType(editor, VisuEditorController) && editor.renderUI) {
      editor.uiService.render()
    }

    Beans.get(BeanVisuController).uiService.render()

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
    var editor = Beans.get(BeanVisuEditorController)

    if (controller.menu.containers.size() != 0) {
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

    if (this.renderEditorMode && editor != null && !editor.renderUI) {
      var _x = layout.x()
      var _y = layout.y()
      var _width = layout.width()
      var _height = layout.height()
      var xStart = _width * (1.0 - 0.061)
      var yStart = _height * (1.0 - 0.08)
      var text = "SHOW EDITOR [F5]"
      GPU.render.text(
        _x + xStart,
        _y + yStart,
        text,
        1.0,
        0.0,
        0.6,
        c_white,
        this.font,
        HAlign.RIGHT,
        VAlign.BOTTOM,
        c_lime,
        8.0
      ) 
    }

    this.dialogueRenderer.render(layout)
    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {VisuRenderer}
  renderGame = function(layout) {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(BeanVisuEditorController)
    if (controller.menu.containers.size() == 0) {
      return this
    }

    this.blur.update()
    if (shader_is_compiled(shader_gaussian_blur)) {
      var uniformSize = shader_get_uniform(shader_gaussian_blur, "size")
      shader_set(shader_gaussian_blur)
      shader_set_uniform_f(uniformSize, layout.width(), layout.height(), this.blur.value)
      this.gridRenderer.renderGUIGameSurface(layout)
      shader_reset()
    } else {
      this.gridRenderer.renderGUI(layout)
    }

    return this
  }

  ///@return {VisuRenderer}
  update = function() {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(BeanVisuEditorController)
    var _layout = editor == null ? this.layout : editor.layout.nodes.preview
    var stateName = controller.fsm.getStateName()
    if (stateName != "splashscreen") {
      this.initTimer.update()
      this.fadeTimer.update()

      this.gridRenderer.update(_layout)
      this.hudRenderer.update(_layout)
      this.dialogueRenderer.update()
    }

    this.executor.update()
    return this
  }
  
  ///@return {VisuRenderer}
  render = function() {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(BeanVisuEditorController)
    var _layout = editor == null ? this.layout : editor.layout.nodes.preview
    var stateName = controller.fsm.getStateName()
    if (stateName != "splashscreen") {
      this.gridRenderer.render(_layout)
    }

    return this
  }

  ///@return {VisuRenderer}
  renderGUI = function() {
    var controller = Beans.get(BeanVisuController)
    var editor = Beans.get(BeanVisuEditorController)
    var _layout = editor == null ? this.layout : editor.layout.nodes.preview
    var stateName = controller.fsm.getStateName()
    if (stateName == "splashscreen") {
      this.executor.tasks.forEach(this.renderSplashscreen, _layout)
    } else {
      this.renderMenu(_layout)
      this.renderGame(_layout)
      this.renderUI(_layout)
      this.renderSpinner(_layout)
      this.renderDebugGUI(_layout)

      if (!this.initTimer.finished) {
        var alpha = clamp(this.initTimer.duration - this.initTimer.time, 0.0, 1.0)
        if (alpha > 0) {
          GPU.render.rectangle(
            0, 0, 
            GuiWidth(), GuiHeight(), 
            false, 
            c_black, c_black, c_black, c_black, 
            alpha
          )
        }
      }

      if (!this.fadeTimer.finished) {
        var alpha = clamp(this.fadeTimer.duration - this.fadeTimer.time, 0.0, 1.0)
        if (alpha > 0) {
          GPU.render.rectangle(
            0, 0, 
            GuiWidth(), GuiHeight(), 
            false, 
            c_black, c_black, c_black, c_black, 
            alpha
          )
        }
      }
    }

    return this
  }

  ///@return {VisuRenderer}
  free = function() {
    this.gridRenderer.free()
    return this
  }
  
  this.init()
}