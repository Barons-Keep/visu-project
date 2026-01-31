///@package io.alkapivo.visu

#macro BeanVisuIO "VisuIO"
///@param {?Struct} [config]
function VisuIO(config = null): Service(config) constructor {

  ///@type {Map}
  keyboards = new Map(String, Keyboard, {
    "player": new Keyboard({
      up: Visu.settings.getValue("visu.keyboard.player.up", KeyboardKeyType.ARROW_UP),
      down: Visu.settings.getValue("visu.keyboard.player.down", KeyboardKeyType.ARROW_DOWN),
      left: Visu.settings.getValue("visu.keyboard.player.left", KeyboardKeyType.ARROW_LEFT),
      right: Visu.settings.getValue("visu.keyboard.player.right", KeyboardKeyType.ARROW_RIGHT),
      action: Visu.settings.getValue("visu.keyboard.player.action", ord("Z")),
      bomb: Visu.settings.getValue("visu.keyboard.player.bomb", ord("X")),
      focus: Visu.settings.getValue("visu.keyboard.player.focus", KeyboardKeyType.SHIFT),
    })
  })

  mouses = new Map(String, Mouse, {
    "player": new Mouse({
      up: Visu.settings.getValue("visu.mouse.player.up", MouseButtonType.NONE),
      down: Visu.settings.getValue("visu.mouse.player.down", MouseButtonType.NONE),
      left: Visu.settings.getValue("visu.mouse.player.left", MouseButtonType.NONE),
      right: Visu.settings.getValue("visu.mouse.player.right", MouseButtonType.NONE),
      action: Visu.settings.getValue("visu.mouse.player.action", MouseButtonType.NONE),
      bomb: Visu.settings.getValue("visu.mouse.player.bomb", MouseButtonType.NONE),
      focus: Visu.settings.getValue("visu.mouse.player.focus", MouseButtonType.NONE),
    })
  })

  ///@type {Keyboard}
  keyboard = new Keyboard({ 
    fullscreen: KeyboardKeyType.F11,
    openMenu: KeyboardKeyType.ESC,
  })

  ///@type {Mouse}
  mouse = new Mouse({ 
    left: MouseButtonType.LEFT,
    right: MouseButtonType.RIGHT,
    wheelUp: MouseButtonType.WHEEL_UP,
    wheelDown: MouseButtonType.WHEEL_DOWN,
  })

  ///@type {Boolean}
  mouseMoved = false

  ///@type {Number}
  mouseMovedCooldown = Core.getProperty("visu.io.mouse-moved.cooldown", 4.0)
  
  ///@private
  ///@param {VisuController} controller
  ///@return {VisuIO}
  fullscreenKeyboardEvent = function(controller) {
    if (Core.getRuntimeType() == RuntimeType.GXGAMES) {
      return this
    }

    if (this.keyboard.keys.fullscreen.pressed) {
      var fullscreen = Beans.get(BeanDisplayService).getFullscreen()
      Logger.debug(BeanVisuIO, String.template("DisplayService::setFullscreen({0})", fullscreen ? "false" : "true"))
      
      Beans.get(BeanDisplayService).setFullscreen(!fullscreen)
      if (fullscreen && Visu.settings.getValue("visu.borderless-window")) {
        Beans.get(BeanDisplayService).center()
      }

      Visu.settings.setValue("visu.fullscreen", !fullscreen).save()
    }

    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@return {VisuIO}
  functionKeyboardEvent = function(controller) {
    var menu = controller.menu
    if (this.keyboard.keys.openMenu.pressed 
        && controller.visuRenderer.initTimer.finished
        && menu.remapKey == null) {

      var state = controller.fsm.getStateName()
      switch (state) {
        case "idle":
          if (menu.enabled) {
            if (controller.visuRenderer.blur.target != 0.0) {
              menu.send(new Event("back"))
            } else {
              menu.send(menu.factoryOpenMainMenuEvent())
            }
          } else {
            menu.send(menu.factoryOpenMainMenuEvent())
          }
          break
        case "game-over":
          break
        case "play":
          var fsmState = controller.fsm.currentState
          if (fsmState.state.get("promises-resolved") != "success") {
            break
          }

          var editor = Beans.get(Visu.modules().editor.controller)
          if (Optional.is(editor) && editor.renderUI) {
            break
          }

          controller.send(new Event("pause", menu.factoryOpenMainMenuEvent()))
          break
        case "paused":
          if (menu.enabled) {
            menu.send(new Event("back") )
            if (!Optional.is(menu.back)) {
              controller.send(new Event("play"))
            }
          } else {
            menu.send(menu.factoryOpenMainMenuEvent())
          }
          break
      }
    }

    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@return {VisuIO}
  mouseEvent = function(controller) {
    static generateMouseEvent = function(name) {
      return new Event(name, { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      })
    }

    var _x = MouseUtil.getMouseX() 
    var _y = MouseUtil.getMouseY()
    if (this.mouse.buttons.left.pressed) {
      controller.uiService.send(generateMouseEvent("MousePressedLeft"))
    }

    if (this.mouse.buttons.left.released) {
      controller.uiService.send(generateMouseEvent("MouseReleasedLeft"))
      Beans.get(BeanDisplayService).setCursor(Cursor.DEFAULT)
    }

    if (this.mouse.buttons.left.drag) {
      controller.uiService.send(generateMouseEvent("MouseDragLeft"))
    }

    if (this.mouse.buttons.left.drop) {
      controller.uiService.send(generateMouseEvent("MouseDropLeft"))
    }

    if (this.mouse.buttons.right.pressed) {
      controller.uiService.send(generateMouseEvent("MousePressedRight"))
    }

    if (this.mouse.buttons.right.released) {
      controller.uiService.send(generateMouseEvent("MouseReleasedRight"))
    }
    
    if (this.mouse.buttons.wheelUp.on) {  
      controller.uiService.send(generateMouseEvent("MouseWheelUp"))
    }
    
    if (this.mouse.buttons.wheelDown.on) {  
      controller.uiService.send(generateMouseEvent("MouseWheelDown"))
    }

    if (MouseUtil.hasMoved() && this.mouseMoved == 0) {  
      this.mouseMoved = this.mouseMovedCooldown
      //controller.uiService.send(generateMouseEvent("MouseHoverOver"))
      controller.uiService.mouseEventHandler("MouseHoverOver", _x, _y)
    } else if (this.mouseMoved > 0) {
      this.mouseMoved = clamp(this.mouseMoved - 1, 0, this.mouseMovedCooldown)
    }

    return this
  }

  ///@private
  ///@param {VisuController} controller
  ///@return {VisuIO}
  __mouseEvent = function(controller) {
    static generateMouseEvent = function(name) {
      return new Event(name, { 
        x: MouseUtil.getMouseX(), 
        y: MouseUtil.getMouseY(),
      })
    }

    if (this.mouse.buttons.left.pressed) {
      controller.uiService.send(generateMouseEvent("MousePressedLeft"))
    }

    if (this.mouse.buttons.left.released) {
      controller.uiService.send(generateMouseEvent("MouseReleasedLeft"))
      Beans.get(BeanDisplayService).setCursor(Cursor.DEFAULT)
    }

    if (this.mouse.buttons.left.drag) {
      controller.uiService.send(generateMouseEvent("MouseDragLeft"))
    }

    if (this.mouse.buttons.left.drop) {
      controller.uiService.send(generateMouseEvent("MouseDropLeft"))
    }

    if (this.mouse.buttons.right.pressed) {
      controller.uiService.send(generateMouseEvent("MousePressedRight"))
    }

    if (this.mouse.buttons.right.released) {
      controller.uiService.send(generateMouseEvent("MouseReleasedRight"))
    }
    
    if (this.mouse.buttons.wheelUp.on) {  
      controller.uiService.send(generateMouseEvent("MouseWheelUp"))
    }
    
    if (this.mouse.buttons.wheelDown.on) {  
      controller.uiService.send(generateMouseEvent("MouseWheelDown"))
    }

    if (MouseUtil.hasMoved() && this.mouseMoved == 0) {  
      this.mouseMoved = this.mouseMovedCooldown
      controller.uiService.send(generateMouseEvent("MouseHoverOver"))
    } else if (this.mouseMoved > 0) {
      this.mouseMoved = clamp(this.mouseMoved - 1, 0, this.mouseMovedCooldown)
    }

    return this
  }

  ///@return {VisuIO}
  updateBegin = function() {
    var controller = Beans.get(BeanVisuController)
    var isController = controller != null
    try {
      //EVENT_COUNTER.log().reset()
      GMArray.updateBegin()
      Struct.updateBegin()
      this.keyboard.update()
      this.mouse.update()
      GMTFContext.updateBegin()
      
      if (!isController) {
        return this
      }

      this.fullscreenKeyboardEvent(controller)
      this.functionKeyboardEvent(controller)
      this.mouseEvent(controller)
    } catch (exception) {
      var message = $"'{BeanVisuIO}::update()' fatal error: {exception.message}"
      Logger.error(BeanVisuIO, message)
      Core.printStackTrace().printException(exception)
      if (isController) {
        controller.send(new Event("spawn-popup", { message: message }))
      }
    }

    return this
  }
}