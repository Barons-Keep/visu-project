///@package io.alkapivo.visu.ui

///@type {String}
#macro VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT " ON "


///@type {String}
#macro VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT " OFF"


///@enum
function _VisuMenuEntryEventType(): Enum() constructor {
  OPEN_NODE = "open-node"
  OPEN_TRACK_SETUP = "open-track-setup"
  LOAD_TRACK = "load-track"
}
global.__VisuMenuEntryEventType = new _VisuMenuEntryEventType()
#macro VisuMenuEntryEventType global.__VisuMenuEntryEventType


///@param {String} sfxName
function playCleanSFX(sfxName) {
  var controller = Beans.get(BeanVisuController)
  if (controller == null) {
    return
  }

  var sfx = controller.sfxService.get(sfxName)
  if (sfx == null) {
    return
  }

  var size = sfx.queue.size()
  if (size == 0) {
    sfx.play()
    return
  }

  var sound = sfx.queue.tail().sound
  if (sound == null) {
    return
  }

  if (sound.getPosition() / sound.getDuration() > 0.5) {
    sfx.play()
  }
}


///@return {Callable}
function factoryPostRenderVisuMenuSliderEntry() {
  return function() {
    var label = Struct.get(this, "label")
    if (label == null) {
      label = new UILabel({
        text: $"{string(int64(this.value))}",
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_kodeo_mono_18_bold",
        color: VisuTheme.color.text,
        outline: true,
        outlineColor: VisuTheme.color.side,
        useScale: false,
      })
      Struct.set(this, "label", label)
    }
    
    label.text = $"{string(int64(this.value))}"
    label.render(
      this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2.0),
      this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2.0)
    )
  }
}


///@return {Callable}
function factoryPostRenderVisuMenuSliderEntryPercentage() {
  return function() {
    var label = Struct.get(this, "label")
    if (label == null) {
      label = new UILabel({
        text: $"{string(int64(this.value))}%",
        align: { v: VAlign.CENTER, h: HAlign.CENTER },
        font: "font_kodeo_mono_18_bold",
        color: VisuTheme.color.text,
        outline: true,
        outlineColor: VisuTheme.color.side,
        useScale: false,
      })
      Struct.set(this, "label", label)
    }
    
    label.text = $"{string(int64(this.value))}%"
    label.render(
      this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2.0),
      this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2.0)
    )
  }
}


///@param {String} name
///@param {String} text
///@return {Struct}
function factoryPlayerKeyboardKeyEntryConfig(name, text) {
  return {
    layout: { type: UILayoutType.VERTICAL },
    label: { 
      key: name,
      text: text,
      cooldown: new Timer(FRAME_MS * 10),
      updateCustom: function() {
        if (!this.cooldown.finished) {
          this.cooldown.update()
        }

        var lastKey = keyboard_lastkey
        if (lastKey == vk_nokey || this.context.state.get("remapKey") != this.key) {          
          return
        }

        this.context.state.set("remapKey", null)
        keyboard_lastkey = vk_nokey
        this.cooldown.reset()
        Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
        if (lastKey == KeyboardKeyType.ESC || lastKey == KeyboardKeyType.ENTER) {
          return
        }

        var keyboard = Beans.get(BeanVisuIO).keyboards.get("player")
        keyboard.setKey(this.key, lastKey)
        Logger.debug("VisuMenu", $"Remap key {this.key} to {lastKey}")

        Visu.settings.setValue("visu.keyboard.player.up", Struct.get(keyboard.keys, "up").gmKey)
        Visu.settings.setValue("visu.keyboard.player.down", Struct.get(keyboard.keys, "down").gmKey)
        Visu.settings.setValue("visu.keyboard.player.left", Struct.get(keyboard.keys, "left").gmKey)
        Visu.settings.setValue("visu.keyboard.player.right", Struct.get(keyboard.keys, "right").gmKey)
        Visu.settings.setValue("visu.keyboard.player.action", Struct.get(keyboard.keys, "action").gmKey)
        Visu.settings.setValue("visu.keyboard.player.bomb", Struct.get(keyboard.keys, "bomb").gmKey)
        Visu.settings.setValue("visu.keyboard.player.focus", Struct.get(keyboard.keys, "focus").gmKey)
        Visu.settings.save()
      },
      callback: new BindIntent(function() {
        if (!this.cooldown.finished || this.context.state.get("remapKey") == this.key) {
          return
        }

        this.context.state.set("remapKey", this.key)
        keyboard_lastkey = vk_nokey
      }),
      onMouseReleasedLeft: function() {
        this.callback()
      },
    },
    preview: {
      key: name,
      text: "",
      updateCustom: function() {
        var keyCode = Struct.get(Beans.get(BeanVisuIO).keyboards.get("player").keys, this.key).gmKey
        if (KeyboardKeyType.contains(keyCode)) {
          this.label.text = KeyboardKeyType.findKey(keyCode)
        } else if (KeyboardSpecialKeys.contains(keyCode)) {
          this.label.text = KeyboardSpecialKeys.get(keyCode)
        } else {
          this.label.text = chr(keyCode)
        }
        
        if (this.context.state.get("remapKey") == this.key) {
          this.label.alpha = (random(100) / 100) * 0.6
        } else {
          this.label.alpha = 1.0
        }
      },
      callback: new BindIntent(function() {
        if (this.context.state.get("remapKey") == this.key) {
          return
        }

        this.context.state.set("remapKey", this.key)
        keyboard_lastkey = vk_nokey
      }),
      onMouseReleasedLeft: function() {
        this.callback()
      },
    },
  }
}


///@param {Struct} json
function VisuMenuNode(json) constructor {

  ///@type {String}
  title = Assert.isType(json.title, String)

  ///@type {?String}
  back = Core.isType(json.back, String) ? json.back : null

  ///@type {Array<VisuMenuEntry>}
  entries = new Array(VisuMenuEntry, Core.isType(Struct.get(json, "entries"), GMArray) 
    ? GMArray.map(json.entries, function(json) { return new VisuMenuEntry(json) }) 
    : [])
}


///@param {Struct} json
function VisuMenuEntry(json) constructor {

  ///@type {String}
  name = Assert.isType(json.name, String)

  ///@type {String}
  title = Struct.getIfType(json, "title", String, "")

  ///@type {VisuMenuEntryEvent}
  event = new VisuMenuEntryEvent(json.event)
}


///@param {Struct} json
function VisuMenuEntryEvent(json) constructor {

  ///@type {String}
  type = Assert.isEnum(json.type, VisuMenuEntryEventType)

  ///@type {?Struct}
  data = Core.isType(Struct.get(json, "data"), Struct) ? json.data : null
}


///@param {?Struct} [_config]
function VisuMenu(_config = null) constructor {

  ///@return {Map<String, VisuMenuNode>}
  static parseNodes = function() {
    var nodes = new Map(String, VisuMenuNode)
    try {
      var manifest = FileUtil
        .readFileSync(FileUtil.get(Core.getRuntimeType() != RuntimeType.GXGAMES
          ? $"{working_directory}track/manifest.json"
          : $"{working_directory}track/manifest-wasm.json"))
        .getData()
      var parserTask = JSON.parserTask(manifest, {
        callback: function(prototype, json, key, acc) {
          acc.add(new prototype(json), key)
        },
        acc: nodes,
        model: "Collection<io.alkapivo.visu.ui.VisuMenuNode>",
      })

      var index = 0
      var MAX_INDEX = 9999
      while (true) {
        if (parserTask.update().status != TaskStatus.RUNNING) {
          break
        }
        Assert.isTrue(index++ <= MAX_INDEX, $"Exceed MAX_INDEX={MAX_INDEX}")
      }
    } catch (exception) {
      Logger.error("VisuMenu", $"Exception throwed while parsing track/manifest.json: {exception.message}")
      Core.printStackTrace().printException(exception)
    }

    return nodes
  }

  ///@type {?Struct}
  config = Optional.is(_config) ? Assert.isType(_config, Struct) : null

  ///@type {Boolean}
  enabled = false

  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@type {?Callable}
  back = null

  ///@type {any}
  backData = null

  ///@type {?String}
  remapKey = null

  ///@type {Map<String, VisuMenuNode>}
  nodes = this.parseNodes()

  ///@param {String} nodeName
  ///@return {Event}
  factoryOpenVisuMenuNode = function(nodeName) {
    var node = this.nodes.get(nodeName)
    if (!Core.isType(node, VisuMenuNode)) {
      return this.factoryOpenMainMenuEvent()
    }

    var back = Core.isType(this.nodes.get(node.back), VisuMenuNode)
      ? this.factoryOpenVisuMenuNode
      : this.factoryOpenMainMenuEvent
    var backData = back == this.factoryOpenVisuMenuNode ? node.back : null,
    var event = new Event("open").setData({
      back: back,
      backData: backData,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: $"{nodeName}_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: node.title
          },
        },
      },
      content: new Array(Struct, node.entries
        .map(function(entry, index, nodeName) {
          return {
            name: $"{nodeName}_menu-button-entry_{index}",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              title: {
                text: entry.title,
              },
              label: { 
                text: entry.name,
                callback: new BindIntent(function() {
                  var controller = Beans.get(BeanVisuController)
                  var menu = controller.menu
                  var event = this.callbackData
                  switch (event.type) {
                    case VisuMenuEntryEventType.OPEN_NODE:
                      menu.send(Core.isType(menu.nodes.get(event.data.node), VisuMenuNode)
                        ? menu.factoryOpenVisuMenuNode(event.data.node)
                        : menu.factoryOpenMainMenuEvent())
                      controller.sfxService.play("menu-select-entry")
                      break
                    case VisuMenuEntryEventType.OPEN_TRACK_SETUP:
                      if (!Optional.is(Struct.getIfType(event.data, "title", String))) {
                        Struct.set(event.data, "title", this.text)
                      }

                      menu.send(menu.factoryOpenTrackSetupEvent(event.data))
                      controller.sfxService.play("menu-select-entry")
                      break
                    case VisuMenuEntryEventType.LOAD_TRACK:
                      controller.send(new Event("load", {
                        manifest: $"{working_directory}{event.data.path}",
                        autoplay: true,
                      }))
                      controller.sfxService.play("menu-select-entry")
                      break
                    default:
                      throw new Exception("VisuMenuEntryEventType does not support '{this.event.type}'")
                  }
                }),
                callbackData: entry.event,
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          }
        }, nodeName, Struct)
        .add(
          {
            name: $"{nodeName}_menu-button-entry_back",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "Back",
                callback: new BindIntent(function() {
                  var controller = Beans.get(BeanVisuController)
                  var menu = controller.menu
                  menu.send(Core.isType(menu.nodes.get(this.callbackData), VisuMenuNode)
                    ? menu.factoryOpenVisuMenuNode(this.callbackData)
                    : menu.factoryOpenMainMenuEvent())
                  controller.sfxService.play("menu-select-entry")
                }),
                callbackData: node.back,
                onMouseReleasedLeft: function() {
                  this.callback()
                },
                colorHoverOut: VisuTheme.color.deny,
              },
            }
          }
        ).getContainer()
      ),
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenTrackSetupEvent = function(_config = null) {
    var context = this
    var config = Struct.appendUnique(
      _config,
      {
        title: "",
        path: "",
        node: null,
      }
    )

    var event = new Event("open").setData({
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "open-track-setup_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: { label: { text: config.title } },
      },
      content: new Array(Struct, [
        {
          name: "open-track-setup_menu-spin-select-entry_difficulty",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Difficulty" },
            previous: { 
              callback: function() {
                var map = new Map(String, Number)
                  .set(Difficulty.EASY, 0)
                  .set(Difficulty.NORMAL, 1)
                  .set(Difficulty.HARD, 2)
                  .set(Difficulty.LUNATIC, 3)
                var pointer = map.getDefault(Visu.settings.getValue("visu.difficulty"), 1)
                var target = clamp(int64(pointer - 1), 0, 3)
                var value = map.findKey(function(value, key, target) {
                  return value == target
                }, target)

                if (!Optional.is(value)) {
                  return
                }

                Visu.settings.setValue("visu.difficulty", value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                var value = Visu.settings.getValue("visu.difficulty")
                if (value == Difficulty.EASY) {
                  this.sprite.setAlpha(0.15)
                } else {
                  this.sprite.setAlpha(1.0)
                }
              }
            },
            preview: {
              label: {
                text: Visu.settings.getValue("visu.difficulty")
              },
              updateCustom: function() { 
                this.label.text = Visu.settings.getValue("visu.difficulty")
              },
            },
            next: { 
              callback: function() {
                var map = new Map(String, Number)
                  .set(Difficulty.EASY, 0)
                  .set(Difficulty.NORMAL, 1)
                  .set(Difficulty.HARD, 2)
                  .set(Difficulty.LUNATIC, 3)
                var pointer = map.getDefault(Visu.settings.getValue("visu.difficulty"), 1)
                var target = clamp(int64(pointer + 1), 0, 3)
                var value = map.findKey(function(value, key, target) {
                  return value == target
                }, target)

                if (!Optional.is(value)) {
                  return
                }

                Visu.settings.setValue("visu.difficulty", value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                var value = Visu.settings.getValue("visu.difficulty")
                if (value == Difficulty.LUNATIC) {
                  this.sprite.setAlpha(0.15)
                } else {
                  this.sprite.setAlpha(1.0)
                }
              }
            },
          },
        },
        {
          name: "open-track-setup_menu-button-entry_play",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Play",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).send(new Event("load", {
                  manifest: $"{working_directory}{this.callbackData}",
                  autoplay: true,
                }))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
              }),
              callbackData: config.path,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "open-track-setup_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                var controller = Beans.get(BeanVisuController)
                var menu = controller.menu
                menu.send(Core.isType(menu.nodes.get(this.callbackData), VisuMenuNode)
                  ? menu.factoryOpenVisuMenuNode(this.callbackData)
                  : menu.factoryOpenMainMenuEvent())
                controller.sfxService.play("menu-select-entry")
              }),
              callbackData: config.node,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ]),
      back: config.node != null 
        ? this.factoryOpenVisuMenuNode
        : this.factoryOpenMainMenuEvent,
      backData: config.node,
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenMainMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenMainMenuEvent,
        quit: this.factoryConfirmationDialog,
        titleLabel: "VISU Project",
        disableResume: false,
        isTrackLoaded: Beans.get(BeanVisuController).trackService.isTrackLoaded(),
        isGameOver: Beans.get(BeanVisuController).fsm.getStateName() == "game-over",
      }
    )

    var event = new Event("open").setData({
      back: null,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "main-menu_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: config.titleLabel,
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "main-menu_menu-button-entry_settings",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Options",
              callback: new BindIntent(function() {
                var menu = Beans.get(BeanVisuController).menu
                menu.send(menu.factoryOpenSettingsMenuEvent(this.callbackData))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "main-menu_menu-button-entry_credits",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Credits",
              callback: new BindIntent(function() {
                var menu = Beans.get(BeanVisuController).menu
                menu.send(menu.factoryOpenCreditsMenuEvent(this.callbackData))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
      ])
    })

    var menuState = config.isGameOver
      ? "game-over"
      : (config.isTrackLoaded ? "in-game" : "main-menu")
    
    var counter = 0
    switch (menuState) {
      case "in-game":
        if (!config.disableResume) {
          event.data.content.add({
            name: "main-menu_menu-button-entry_resume",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "Resume",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).fsm.dispatcher.send(new Event("transition", { name: "play" }))
                  Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                }),
                callbackData: config,
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          }, counter)
          counter++
        }

        event.data.content.add({
          name: "main-menu_menu-button-entry_retry",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Retry",
              callback: new BindIntent(function() {
                var controller = Beans.get(BeanVisuController)
                Assert.isType(controller.track, VisuTrack, "VisuController.track must be type of VisuTrack")
                controller.send(new Event("load", {
                  manifest: $"{controller.track.path}manifest.visu",
                  autoplay: true,
                }))
                controller.sfxService.play("menu-select-entry")
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        }, counter)
        counter++
  
        event.data.content.add({
          name: "main-menu_menu-button-entry_restart",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Main menu",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
                Beans.get(BeanVisuController).menu.send(Callable
                  .run(this.callbackData.quit, {
                    back: this.callbackData.back,
                    accept: function() {
                      Scene.open("scene_visu", {
                        VisuController: {
                          initialState: { name: "idle" },
                        },
                      })
                      return new Event("close")
                    },
                    decline: this.callbackData.back,
                  }))
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        }, counter)
        counter++
        break
      case "main-menu":
        event.data.content.add({
          name: "main-menu_menu-button-entry_play",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Play",
              callback: new BindIntent(function() {
                var controller = Beans.get(BeanVisuController)
                var menu = controller.menu
                var root = Core.getProperty("visu.menu.play.root", "root.tracks")
                menu.send(menu.factoryOpenVisuMenuNode(root))
                controller.sfxService.play("menu-select-entry")
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        }, counter)
        counter++
        break
      case "game-over":
        var editor = Beans.get(Visu.modules().editor.controller)
        if (Optional.is(editor)) {
          event.data.content.add({
            name: "main-menu_menu-button-entry_resume",
            template: VisuComponents.get("menu-button-entry"),
            layout: VisuLayouts.get("menu-button-entry"),
            config: {
              layout: { type: UILayoutType.VERTICAL },
              label: { 
                text: "Resume (EDITOR)",
                callback: new BindIntent(function() {
                  Beans.get(BeanVisuController).fsm.dispatcher.send(new Event("transition", { name: "play" }))
                  Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                }),
                callbackData: config,
                onMouseReleasedLeft: function() {
                  this.callback()
                },
              },
            }
          }, counter)
          counter++
        }

        event.data.content.add({
          name: "main-menu_menu-button-entry_retry",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Retry",
              callback: new BindIntent(function() {
                var controller = Beans.get(BeanVisuController)
                Assert.isType(controller.track, VisuTrack, "VisuController.track must be type of VisuTrack")
                controller.send(new Event("load", {
                  manifest: $"{controller.track.path}manifest.visu",
                  autoplay: true,
                }))
                controller.sfxService.play("menu-select-entry")
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        }, counter)
        counter++
  
        event.data.content.add({
          name: "main-menu_menu-button-entry_restart",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Main menu",
              callback: new BindIntent(function() {
                Scene.open("scene_visu", {
                  VisuController: {
                    initialState: { name: "idle" },
                  },
                })
                return new Event("close")
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        }, counter)
        counter++
        break
    }

    if (Core.getRuntimeType() != RuntimeType.GXGAMES) {
      event.data.content.add({
        name: "main-menu_menu-button-entry_quit",
        template: VisuComponents.get("menu-button-entry"),
        layout: VisuLayouts.get("menu-button-entry"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Quit",
            callback: new BindIntent(function() {
              Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              Beans.get(BeanVisuController).menu.send(Callable
                .run(this.callbackData.quit, { back: this.callbackData.back }))
            }),
            callbackData: config,
            onMouseReleasedLeft: function() {
              this.callback()
            },
            colorHoverOut: VisuTheme.color.deny,
          },
        }
      })
    }

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryConfirmationDialog = function(_config = null) {
    var context = this
    var config = Struct.appendUnique(
      _config,
      {
        accept: function() { return new Event("game-end") },
        acceptLabel: "Yes",
        decline: context.factoryOpenMainMenuEvent, 
        declineLabel: "No",
        message: "Are you sure?"
      }
    )

    var event = new Event("open").setData({
      accept: config.accept,
      decline: config.decline,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "confirmation-dialog_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: config.message,
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "confirmation-dialog_menu-button-entry_accept",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: config.acceptLabel,
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.accept,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "confirmation-dialog_menu-button-entry_decline",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: config.declineLabel,
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.decline,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        },
      ])
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenSettingsMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        graphics: this.factoryOpenGraphicsSettingsMenuEvent,
        audio: this.factoryOpenAudioSettingsMenuEvent,
        gameplay: this.factoryOpenGameplaySettingsMenuEvent,
        controls: this.factoryOpenControlsMenuEvent,
        developer: this.factoryOpenDeveloperMenuEvent,
        back: this.factoryOpenMainMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "settings_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Settings",
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "settings_menu-button-entry_graphics",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Graphics",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.graphics,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "settings_menu-button-entry_audio",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Audio",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.audio,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "settings_menu-button-entry_gameplay",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Gameplay",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.gameplay,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "settings_menu-button-entry_controls",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Controls",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.controls,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "settings_menu-button-entry_developer",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Developer",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.developer,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "settings_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ])
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenCreditsMenuEvent = function(_config = null) {
    static factoryCreditsEntry = function(index, text, url = null) {
      return {
        name: $"credits_menu-button-entry_{index}",
        template: VisuComponents.get("menu-label-entry"),
        layout: VisuLayouts.get("menu-button-entry"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: {
            text: text,
            url: url,
            callback: new BindIntent(function() {
              if (Core.isType(this.url, String)) {
                url_open(this.url)
              }
            }),
            onMouseReleasedLeft: function() {
              this.callback()
            },
          },
        }
      }
    }

    static factoryCreditsTitle = function(index, text) {
      return {
        name: $"credits_menu-button-entry_{index}",
        template: VisuComponents.get("menu-button-entry"),
        layout: VisuLayouts.get("menu-button-entry"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { text: text },
        }
      }
    }

    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenMainMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "credits_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Credits",
          },
        },
      },
      content: new Array(Struct, [
        factoryCreditsTitle("ijwgRtbT", "Game design"),
        factoryCreditsEntry("TywGRhb1", "Alkapivo"),
        factoryCreditsEntry("h26GR3bc", "Baron"),
        factoryCreditsTitle("nrmgjhgj", "Level design"),
        factoryCreditsEntry("gKgVhDsT", "Alkapivo"),
        factoryCreditsEntry("nT3VF4vl", "Baron"),
        factoryCreditsTitle("YU9WJfKr", "Music"),
        factoryCreditsEntry("GHR54bnv", "GOETIA - Death of the Muse - 01 Create and Yet Fate's Faw Avoid"),
        factoryCreditsEntry("G10ccQRd", "GOETIA - Cerecloth"),
        factoryCreditsEntry("I94zzBo7", "kedy_selma - Just To Create Something"),
        factoryCreditsEntry("Y6yNV8JN", "kedy_selma - Passion"),
        factoryCreditsEntry("anMlmEyW", "pikaro & PAXNKOXD - the memories fade but the feeling remains"),
        factoryCreditsEntry("fyQD5OCd", "Schnoopy - Destination Unknown"),
        factoryCreditsEntry("TdMvcdS6", "Sewerslvt - Psychosis"),
        factoryCreditsEntry("Zvsi4gtq", "Sewerslvt - Purple Hearts In Her Eyes"),
        factoryCreditsEntry("4Ht9Ewl1", "zoogies - digitalshadow"),
        factoryCreditsTitle("qQwqRmsT", "Programming"),
        factoryCreditsEntry("Bimj4rUU", "Alkapivo - visu-project", "https://github.com/Barons-Keep/visu-project"),
        factoryCreditsEntry("4MnGw7O7", "Alkapivo - visu-gml", "https://github.com/Barons-Keep/visu-gml"),
        factoryCreditsEntry("Ubngnmgi", "Alkapivo - core-gml", "https://github.com/Alkapivo/core-gml"),
        factoryCreditsEntry("7ixDm727", "Alkapivo - gm-cli", "https://github.com/Alkapivo/gm-cli"),
        factoryCreditsEntry("YnO6tbvb", "Alkapivo, maras_cz - mh-cz.gmtf-gml", "https://github.com/Alkapivo/mh-cz.gmtf-gml"),
        factoryCreditsEntry("nHAfeBGD", "Alkapivo, blokatt - fyi.odditica.bktGlitch-gml", "https://github.com/Alkapivo/fyi.odditica.bktGlitch-gml"),
        factoryCreditsEntry("OO9EyOWN", "Alkapivo, Pixelated_Pope - com.pixelatedpope.tdmc-gml", "https://github.com/Alkapivo/com.pixelatedpope.tdmc-gml"),
        factoryCreditsTitle("tu8URzmo", "Shaders"),
        factoryCreditsEntry("aooLlGEu", "svtetering - NOG BETERE 2", "https://shadertoy.com/view/NtlSzX"),
        factoryCreditsEntry("upVVCWbu", "KeeVee_Games - HUE: musnik.itch.io/hue-shader", "https://musnik.itch.io/hue-shader"),
        factoryCreditsEntry("samNRF8w", "haquxx - 002 BLUE", "https://shadertoy.com/view/WldSRn"),
        factoryCreditsEntry("jVnyiDrA", "tomorrowevening - 70S MELT", "https://shadertoy.com/view/XsX3zl"),
        factoryCreditsEntry("LYOYldBk", "kishimisu - ART", "https://shadertoy.com/view/mtyGWy"),
        factoryCreditsEntry("lyEVE3tF", "trinketMage - BASE WARP FBM", "https://shadertoy.com/view/tdG3Rd"),
        factoryCreditsEntry("3ifsKUds", "iekdosha - BROKEN TIME PORTAL", "https://shadertoy.com/view/XXcGWr"),
        factoryCreditsEntry("7K0W1mre", "edankwan - CINESHADER LAVA", "https://shadertoy.com/view/3sySRK"),
        factoryCreditsEntry("aaaSDR6q", "murieron - CLOUDS 2D", "https://shadertoy.com/view/WdXBW4"),
        factoryCreditsEntry("5RDIFbcJ", "Peace - COLORS EMBODY", "https://shadertoy.com/view/lffyWf"),
        factoryCreditsEntry("ehqFeJ3X", "ProfessorPixels - CUBULAR", "https://shadertoy.com/view/M3tGWr"),
        factoryCreditsEntry("2glz4V6F", "supah - DISCOTEQ 2", "https://shadertoy.com/view/DtXfDr"),
        factoryCreditsEntry("o9fJZ0fn", "lise - DIVE TO CLOUD", "https://shadertoy.com/view/ll3SWl"),
        factoryCreditsEntry("hVL0jFKT", "anatole_duprat - FLAME", "https://shadertoy.com/view/MdX3zr"),
        factoryCreditsEntry("AIWL1gM4", "Peace - GRID SPACE", "https://shadertoy.com/view/lffyWf"),
        factoryCreditsEntry("0jyLdQ6w", "Peace - LIGHTING WITH GLOW", "https://shadertoy.com/view/MclyWl"),
        factoryCreditsEntry("rmwl74YR", "butadiene - MONSTER", "https://shadertoy.com/view/WtKSzt"),
        factoryCreditsEntry("ogXsppv1", "whisky_shusuky - OCTAGRAMS", "https://shadertoy.com/view/tlVGDt"),
        factoryCreditsEntry("zGNI2nXl", "kasari39 - PHANTOM STAR", "https://shadertoy.com/view/ttKGDt"),
        factoryCreditsEntry("YrA0aotr", "ChunderFPV - SINCOS 3D", "https://shadertoy.com/view/XfXGz4"),
        factoryCreditsEntry("WaV9TrLR", "Kali - STAR NEST", "https://shadertoy.com/view/XlfGRj"),
        factoryCreditsEntry("sP4kWe3m", "magician0809 - UI NOISE HALO", "https://shadertoy.com/view/3tBGRm"),
        factoryCreditsEntry("zTzYxKu5", "iq - WARP", "https://shadertoy.com/view/lsl3RH"),
        factoryCreditsEntry("CHnh0XGa", "Dave_Hoskins - WARP SPEED 2", "https://shadertoy.com/view/4tjSDt"),
        factoryCreditsEntry("GHNnOTK1", "nayk - WHIRLPOOL", "https://shadertoy.com/view/lcscDj"),
        factoryCreditsEntry("Ihb80AdW", "xygthop3 - ABBERATION", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("OlklAeQ1", "xygthop3 - CRT", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("ZT7Suy4K", "xygthop3 - EMBOSS", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("aVEfOzcV", "xygthop3 - LED", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("FwKDGXOK", "xygthop3 - MAGNIFY", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("zfF2QBQb", "xygthop3 - MOSAIC", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("5VHqgJRb", "xygthop3 - POSTERIZATION", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("xHGSKCnB", "xygthop3 - REVERT", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("SqtaHVR2", "xygthop3 - RIPPLE", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("CLd7vpDl", "xygthop3 - SCANLINES", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("pt2ZUbes", "xygthop3 - SHOCK_WAVE", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("nQJhn2mH", "xygthop3 - SKETCH", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("wRA1P0cI", "xygthop3 - THERMAL", "https://github.com/xygthop3/Free-Shaders"),
        factoryCreditsEntry("TYwCSS3l", "xygthop3 - WAVE", "https://github.com/xygthop3/Free-Shaders"),
        {
          name: "credits_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ])
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenGraphicsSettingsMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenSettingsMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "graphics_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Graphics",
          },
        },
      },
      content: new Array(Struct, [
        /*
        {
          name: "graphics_menu-button-input-entry_auto-resize",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Auto-resize",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.auto-resize")
                Visu.settings.setValue("visu.graphics.auto-resize", !value).save()
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.auto-resize")
                Visu.settings.setValue("visu.graphics.auto-resize", !value).save()
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.auto-resize") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-spin-select-entry_resolution",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Resolution" },
            previous: { 
              callback: function() { },
            },
            preview: {
              label: {
                text: ""
              },
              updateCustom: function() { this.label.text = $"{GuiWidth()}x{GuiHeight()}" },
            },
            next: { 
              callback: function() { },
            },
          },
        },
        */
        {
          name: "graphics_menu-button-input-entry_fullscreen",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Fullscreen",
              callback: new BindIntent(function() {
                var controller = Beans.get(BeanVisuController)
                var fullscreen = controller.displayService.getFullscreen()
                controller.displayService.setFullscreen(!fullscreen)
                Visu.settings.setValue("visu.fullscreen", !fullscreen).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")

                if (fullscreen && Visu.settings.getValue("visu.borderless-window")) {
                  controller.displayService.center()
                }
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: "" },
              callback: function() {
                var controller = Beans.get(BeanVisuController)
                var fullscreen = controller.displayService.getFullscreen()
                controller.displayService.setFullscreen(!fullscreen)
                Visu.settings.setValue("visu.fullscreen", !fullscreen).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
                if (fullscreen && Visu.settings.getValue("visu.borderless-window")) {
                  controller.displayService.center()
                }
              },
              updateCustom: function() {
                this.label.text = Beans.get(BeanVisuController).displayService.getFullscreen() ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_borderless_window",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Borderless window",
              callback: new BindIntent(function() {
                var controller = Beans.get(BeanVisuController)
                var borderlessWindow = controller.displayService.getBorderlessWindow()
                controller.displayService.setBorderlessWindow(!borderlessWindow)
                Visu.settings.setValue("visu.borderless-window", !borderlessWindow).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: "" },
              callback: function() {
                var controller = Beans.get(BeanVisuController)
                var borderlessWindow = controller.displayService.getBorderlessWindow()
                controller.displayService.setBorderlessWindow(!borderlessWindow)
                Visu.settings.setValue("visu.borderless-window", !borderlessWindow).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Beans.get(BeanVisuController).displayService.getBorderlessWindow() ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_vsync",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "VSync",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.vsync")
                Visu.settings.setValue("visu.graphics.vsync", !value).save()
                display_reset(Visu.settings.getValue("visu.graphics.aa"), Visu.settings.getValue("visu.graphics.vsync"))
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.vsync")
                Visu.settings.setValue("visu.graphics.vsync", !value).save()
                display_reset(Visu.settings.getValue("visu.graphics.aa"), Visu.settings.getValue("visu.graphics.vsync"))
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.vsync") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_bkt-glitch",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Glitch effects",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.bkt-glitch")
                Visu.settings.setValue("visu.graphics.bkt-glitch", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.bkt-glitch")
                Visu.settings.setValue("visu.graphics.bkt-glitch", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.bkt-glitch") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_particle",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Particles",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.particle")
                Visu.settings.setValue("visu.graphics.particle", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.particle")
                Visu.settings.setValue("visu.graphics.particle", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.particle") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_bkg-tx",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Background textures",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.bkg-tx")
                Visu.settings.setValue("visu.graphics.bkg-tx", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.bkg-tx")
                Visu.settings.setValue("visu.graphics.bkg-tx", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.bkg-tx") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_frg-tx",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Background textures",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.frg-tx")
                Visu.settings.setValue("visu.graphics.frg-tx", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.frg-tx")
                Visu.settings.setValue("visu.graphics.frg-tx", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.frg-tx") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        /*
        {
          name: "graphics_menu-spin-select-entry_anti-aliasing",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Anti aliasing" },
            previous: { 
              aaRange: Core.fetchAARange(),
              callback: function() {
                var index = this.aaRange.findIndex(Lambda.equal, Visu.settings.getValue("visu.graphics.aa"))
                if (!Optional.is(index)) {
                  return
                }
                index = clamp(index - 1, 0, this.aaRange.size() - 1)
                Visu.settings.setValue("visu.graphics.aa", this.aaRange.get(index)).save()
                display_reset(Visu.settings.getValue("visu.graphics.aa"), Visu.settings.getValue("visu.graphics.vsync"))
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                var index = this.aaRange.findIndex(Lambda.equal, Visu.settings.getValue("visu.graphics.aa"))
                if (!Optional.is(index)) {
                  this.sprite.setAlpha(0.0)
                } else if (index == 0) {
                  this.sprite.setAlpha(0.15)
                } else {
                  this.sprite.setAlpha(1.0)
                }
              }
            },
            preview: {
              label: {
                text: string(int64(round(Visu.settings.getValue("visu.graphics.aa"))))
              },
              updateCustom: function() {
                var value = round(Visu.settings.getValue("visu.graphics.aa"))
                this.label.text = $"{string(int64(value))}"
              },
            },
            next: { 
              aaRange: Core.fetchAARange(),
              callback: function() {
                var index = this.aaRange.findIndex(Lambda.equal, Visu.settings.getValue("visu.graphics.aa"))
                if (!Optional.is(index)) {
                  return
                }
                index = clamp(index + 1, 0, this.aaRange.size() - 1)
                Visu.settings.setValue("visu.graphics.aa", this.aaRange.get(index)).save()
                display_reset(Visu.settings.getValue("visu.graphics.aa"), Visu.settings.getValue("visu.graphics.vsync"))
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                var index = this.aaRange.findIndex(Lambda.equal, Visu.settings.getValue("visu.graphics.aa"))
                if (!Optional.is(index)) {
                  this.sprite.setAlpha(0.0)
                } else if (index == this.aaRange.size() - 1) {
                  this.sprite.setAlpha(0.15)
                } else {
                  this.sprite.setAlpha(1.0)
                }
              }
            },
          },
        },
        */
        {
          name: "graphics_menu-button-input-entry_bkg-shaders",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Background shaders",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.bkg-shaders")
                Visu.settings.setValue("visu.graphics.bkg-shaders", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.bkg-shaders")
                Visu.settings.setValue("visu.graphics.bkg-shaders", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.bkg-shaders") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_main-shaders",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Grid shaders",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.main-shaders")
                Visu.settings.setValue("visu.graphics.main-shaders", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.main-shaders")
                Visu.settings.setValue("visu.graphics.main-shaders", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.main-shaders") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-button-input-entry_combined-shaders",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Combined shaders",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.graphics.combined-shaders")
                Visu.settings.setValue("visu.graphics.combined-shaders", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.graphics.combined-shaders")
                Visu.settings.setValue("visu.graphics.combined-shaders", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.graphics.combined-shaders") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "graphics_menu-slider-entry_shaders-limit",
          template: VisuComponents.get("menu-slider-entry"),
          layout: VisuLayouts.get("menu-slider-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Max simultaneous shaders" },
            slider: {
              value: round(Visu.settings.getValue("visu.graphics.shaders-limit")),
              minValue: 0.0,
              maxValue: DEFAULT_SHADER_PIPELINE_LIMIT,
              snapValue: 1.0,
              updatePosition: function(mouseX, mouseY) {
                this.callback()
              },
              callback: function() {
                var value = round(Visu.settings.getValue("visu.graphics.shaders-limit"))
                if (this.value == value) {
                  return
                }

                Visu.settings.setValue("visu.graphics.shaders-limit", this.value).save()
                playCleanSFX("menu-move-cursor")
              },
              postRender: factoryPostRenderVisuMenuSliderEntry(),
            },
          },
        },
        {
          name: "graphics_menu-slider-entry_shader-quality",
          template: VisuComponents.get("menu-slider-entry"),
          layout: VisuLayouts.get("menu-slider-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Shaders quality" },
            slider: {
              value: round(Visu.settings.getValue("visu.graphics.shader-quality") * 100.0),
              minValue: 1.0,
              maxValue: 100.0,
              snapValue: 1.0,
              updatePosition: function(mouseX, mouseY) {
                this.callback()
              },
              callback: function() {
                var value = round(Visu.settings.getValue("visu.graphics.shader-quality") * 100.0)
                if (this.value == value) {
                  return
                }

                Visu.settings.setValue("visu.graphics.shader-quality", this.value / 100.0).save()
                playCleanSFX("menu-move-cursor")
              },
              postRender: factoryPostRenderVisuMenuSliderEntryPercentage(),
            },
          },
        },
        {
          name: "graphics_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ])
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenAudioSettingsMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenSettingsMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "audio_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Audio",
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "audio_menu-slider-entry_ost-volume",
          template: VisuComponents.get("menu-slider-entry"),
          layout: VisuLayouts.get("menu-slider-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "OST volume" },
            slider: {
              value: round(Visu.settings.getValue("visu.audio.ost-volume") * 100.0),
              minValue: 0.0,
              maxValue: 100.0,
              snapValue: 1.0,
              updatePosition: function(mouseX, mouseY) {
                this.callback()
              },
              callback: function() {
                var value = round(Visu.settings.getValue("visu.audio.ost-volume") * 100.0)
                if (this.value == value) {
                  return
                }

                Visu.settings.setValue("visu.audio.ost-volume", this.value / 100.0).save()
                playCleanSFX("menu-move-cursor")
              },
              postRender: factoryPostRenderVisuMenuSliderEntryPercentage(),
            },
          },
        },
        {
          name: "audio_menu-slider-entry_sfx-volume",
          template: VisuComponents.get("menu-slider-entry"),
          layout: VisuLayouts.get("menu-slider-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "SFX volume" },
            slider: {
              value: round(Visu.settings.getValue("visu.audio.sfx-volume") * 100.0),
              minValue: 0.0,
              maxValue: 100.0,
              snapValue: 1.0,
              updatePosition: function(mouseX, mouseY) {
                this.callback()
              },
              callback: function() {
                var value = round(Visu.settings.getValue("visu.audio.sfx-volume") * 100.0)
                if (this.value == value) {
                  return
                }

                Visu.settings.setValue("visu.audio.sfx-volume", this.value / 100.0).save()
                playCleanSFX("menu-move-cursor")
              },
              postRender: factoryPostRenderVisuMenuSliderEntryPercentage(),
            },
          },
        },
        {
          name: "audio_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ])
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenGameplaySettingsMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenSettingsMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "gameplay_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Gameplay",
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "gameplay_menu-button-input-entry_render-hud",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Render HUD",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.interface.render-hud")
                Visu.settings.setValue("visu.interface.render-hud", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.interface.render-hud")
                Visu.settings.setValue("visu.interface.render-hud", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.interface.render-hud") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        /*
        {
          name: "gameplay_menu-spin-select-entry_hud-posituion",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "HUD position" },
            previous: { 
              callback: function() {

              },
            },
            preview: {
              label: {
                text: "Bottom left"
              },
              updateCustom: function() {

              },
            },
            next: { 
              callback: function() {

              },
            },
          },
        },
        */
        {
          name: "gameplay_menu-button-input-entry_player-hint",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Off-screen player hints",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.interface.player-hint")
                Visu.settings.setValue("visu.interface.player-hint", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.interface.player-hint")
                Visu.settings.setValue("visu.interface.player-hint", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.interface.player-hint") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "gameplay_menu-spin-select-entry_dt",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Delta time" },
            previous: { 
              callback: function() {
                var map = new Map(String, Number)
                  .set(DeltaTimeMode.DEFAULT, 0)
                  .set(DeltaTimeMode.STEADY, 1)
                  .set(DeltaTimeMode.UNSTEADY, 2)
                  .set(DeltaTimeMode.DISABLED, 3)
                var pointer = map.getDefault(Visu.settings.getValue("visu.delta-time"), 0)
                var target = clamp(int64(pointer - 1), -1, 4)
                target = target == -1 ? 3 : (target == 4 ? 0 : target)
                var value = map.findKey(Lambda.equal, target)

                if (!Optional.is(value)) {
                  return
                }

                Visu.settings.setValue("visu.delta-time", value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
            },
            preview: {
              label: {
                text: Visu.settings.getValue("visu.delta-time")
              },
              updateCustom: function() { 
                this.label.text = Visu.settings.getValue("visu.delta-time")
              },
            },
            next: { 
              callback: function() {
                var map = new Map(String, Number)
                  .set(DeltaTimeMode.DEFAULT, 0)
                  .set(DeltaTimeMode.STEADY, 1)
                  .set(DeltaTimeMode.UNSTEADY, 2)
                  .set(DeltaTimeMode.DISABLED, 3)
                var pointer = map.getDefault(Visu.settings.getValue("visu.delta-time"), 0)
                var target = clamp(int64(pointer + 1), -1, 4)
                target = target == -1 ? 3 : (target == 4 ? 0 : target)
                var value = map.findKey(Lambda.equal, target)

                if (!Optional.is(value)) {
                  return
                }

                Visu.settings.setValue("visu.delta-time", value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
            },
          },
        },
        {
          name: "gameplay_menu-slider-entry_scale-gui",
          template: VisuComponents.get("menu-slider-entry"),
          layout: VisuLayouts.get("menu-slider-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "GUI scale" },
            slider: {
              value: round(Visu.settings.getValue("visu.interface.scale") * 100.0),
              minValue: 50.0,
              maxValue: 400.0,
              snapValue: 5.0,
              updatePosition: function(mouseX, mouseY) {
                this.callback()
              },
              callback: function() {
                var value = round(Struct.getIfType(this.context, "scaleIntent", Number, Visu.settings.getValue("visu.interface.scale")) * 100.0)
                if (this.value == value) {
                  return
                }

                Visu.settings.setValue("visu.interface.scale", this.value / 100.0).save()
                Struct.set(this.context, "scaleIntent", this.value / 100.0)
                playCleanSFX("menu-move-cursor")
              },
              postRender: factoryPostRenderVisuMenuSliderEntryPercentage(),
            },
          },
        },
        {
          name: "gameplay_menu-button-entry_apply",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Apply GUI Scale",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")

                var scaleIntent = Struct.getIfType(this.context, "scaleIntent", Number, Visu.settings.getValue("visu.interface.scale"))
                Visu.settings.setValue("visu.interface.scale", scaleIntent).save()
                Beans.get(BeanVisuController).displayService.scale = scaleIntent
                Beans.get(BeanVisuController).displayService.state = "required"
                Beans.get(BeanVisuController).displayService.timer.reset().finish()

                Beans.get(BeanVisuController).visuRenderer.fadeTimer.reset().time = -0.33
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "gameplay_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
                Struct.set(this.context, "scaleIntent", Visu.settings.getValue("visu.interface.scale"))
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ])
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenControlsMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenSettingsMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "controls_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Controls",
          },
        },
      },
      content: new Array(Struct, [
        {
          name: $"settings_menu-keyboard-key-entry_up",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("up", "Up"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_down",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("down", "Down"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_left",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("left", "Left"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_right",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("right", "Right"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_action",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("action", "Shoot"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_bomb",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("bomb", "Use bomb"),
        },
        {
          name: $"settings_menu-keyboard-key-entry_focus",
          template: VisuComponents.get("menu-keyboard-key-entry"),
          layout: VisuLayouts.get("menu-keyboard-key-entry"),
          config: factoryPlayerKeyboardKeyEntryConfig("focus", "Focus mode"),
        },
        {
          name: "settings_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ])
    })

    return event
  }

  ///@param {?Struct} [_config]
  ///@return {Event}
  factoryOpenDeveloperMenuEvent = function(_config = null) {
    var config = Struct.appendUnique(
      _config,
      {
        back: this.factoryOpenSettingsMenuEvent, 
      }
    )

    var event = new Event("open").setData({
      back: config.back,
      layout: Beans.get(BeanVisuController).visuRenderer.layout,
      title: {
        name: "controls_title",
        template: VisuComponents.get("menu-title"),
        layout: VisuLayouts.get("menu-title"),
        config: {
          label: { 
            text: "Developer",
          },
        },
      },
      content: new Array(Struct, [
        {
          name: "developer_menu-button-input-entry_debug",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Debug mode",
              callback: new BindIntent(function() {
                var value = !is_debug_overlay_open()
                Visu.settings.setValue("visu.debug", value).save()
                Core.debugOverlay(value)
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = !is_debug_overlay_open()
                Visu.settings.setValue("visu.debug", value).save()
                Core.debugOverlay(value)
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = is_debug_overlay_open() ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "developer_menu-button-input-entry_god-mode",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "God mode",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.god-mode")
                Visu.settings.setValue("visu.god-mode", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.god-mode")
                Visu.settings.setValue("visu.god-mode", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.god-mode") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "developer_menu-button-input-entry_debug-render-entities-mask",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Render debug masks",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.debug.render-entities-mask")
                Visu.settings.setValue("visu.debug.render-entities-mask", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.debug.render-entities-mask")
                Visu.settings.setValue("visu.debug.render-entities-mask", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.debug.render-entities-mask") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "developer_menu-button-input-entry_debug-render-debug-chunks",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Render debug chunks",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.debug.render-debug-chunks")
                Visu.settings.setValue("visu.debug.render-debug-chunks", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.debug.render-debug-chunks")
                Visu.settings.setValue("visu.debug.render-debug-chunks", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.debug.render-debug-chunks") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "developer_menu-button-input-entry_debug-render-surfaces",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Render debug surfaces",
              callback: new BindIntent(function() {
                var value = Visu.settings.getValue("visu.debug.render-surfaces")
                Visu.settings.setValue("visu.debug.render-surfaces", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = Visu.settings.getValue("visu.debug.render-surfaces")
                Visu.settings.setValue("visu.debug.render-surfaces", !value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Visu.settings.getValue("visu.debug.render-surfaces") ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "developer_menu-button-input-entry_ws",
          template: VisuComponents.get("menu-button-input-entry"),
          layout: VisuLayouts.get("menu-button-input-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "WebSocket",
              callback: new BindIntent(function() {
                var value = false
                var controller = Beans.get(BeanVisuController)
                if (controller.server.isRunning()) {
                  value = false
                  controller.server.free()
                } else {
                  value = true
                  controller.server.run()
                }

                Visu.settings.setValue("visu.server.enable", value).save()
                controller.sfxService.play("menu-use-entry")
              }),
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
            input: {
              label: { text: VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT },
              callback: function() {
                var value = false
                var controller = Beans.get(BeanVisuController)
                if (controller.server.isRunning()) {
                  value = false
                  controller.server.free()
                } else {
                  value = true
                  controller.server.run()
                }

                Visu.settings.setValue("visu.server.enable", value).save()
                controller.sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                this.label.text = Beans.get(BeanVisuController).server.isRunning() ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
                this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
              },
              onMouseReleasedLeft: function() {
                this.callback()
              },
            }
          }
        },
        {
          name: "developer_menu-spin-select-entry_difficulty",
          template: VisuComponents.get("menu-spin-select-entry"),
          layout: VisuLayouts.get("menu-spin-select-entry"),
          config: { 
            layout: { type: UILayoutType.VERTICAL },
            label: { text: "Difficulty" },
            previous: { 
              callback: function() {
                var map = new Map(String, Number)
                  .set(Difficulty.EASY, 0)
                  .set(Difficulty.NORMAL, 1)
                  .set(Difficulty.HARD, 2)
                  .set(Difficulty.LUNATIC, 3)
                var pointer = map.getDefault(Visu.settings.getValue("visu.difficulty"), 1)
                var target = clamp(int64(pointer - 1), 0, 3)
                var value = map.findKey(function(value, key, target) {
                  return value == target
                }, target)

                if (!Optional.is(value)) {
                  return
                }

                Visu.settings.setValue("visu.difficulty", value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                var value = Visu.settings.getValue("visu.difficulty")
                if (value == Difficulty.EASY) {
                  this.sprite.setAlpha(0.15)
                } else {
                  this.sprite.setAlpha(1.0)
                }
              }
            },
            preview: {
              label: {
                text: Visu.settings.getValue("visu.difficulty")
              },
              updateCustom: function() { 
                this.label.text = Visu.settings.getValue("visu.difficulty")
              },
            },
            next: { 
              callback: function() {
                var map = new Map(String, Number)
                  .set(Difficulty.EASY, 0)
                  .set(Difficulty.NORMAL, 1)
                  .set(Difficulty.HARD, 2)
                  .set(Difficulty.LUNATIC, 3)
                var pointer = map.getDefault(Visu.settings.getValue("visu.difficulty"), 1)
                var target = clamp(int64(pointer + 1), 0, 3)
                var value = map.findKey(function(value, key, target) {
                  return value == target
                }, target)

                if (!Optional.is(value)) {
                  return
                }

                Visu.settings.setValue("visu.difficulty", value).save()
                Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              },
              updateCustom: function() {
                var value = Visu.settings.getValue("visu.difficulty")
                if (value == Difficulty.LUNATIC) {
                  this.sprite.setAlpha(0.15)
                } else {
                  this.sprite.setAlpha(1.0)
                }
              }
            },
          },
        },
        {
          name: "developer_menu-button-entry_restart",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Restart game",
              callback: new BindIntent(function() {
                VISU_MANIFEST_LOAD_ON_START_DISPATCHED = false
                VISU_FORCE_GOD_MODE_DISPATCHED = false
                Scene.open("scene_visu", {
                  VisuController: {
                    initialState: { name: Core.getProperty("visu.splashscreen.skip") ? "idle" : "splashscreen", },
                  },
                })
                return new Event("close")
              }),
              callbackData: config,
              onMouseReleasedLeft: function() {
                this.callback()
              },
            },
          }
        },
        {
          name: "developer_menu-button-entry_back",
          template: VisuComponents.get("menu-button-entry"),
          layout: VisuLayouts.get("menu-button-entry"),
          config: {
            layout: { type: UILayoutType.VERTICAL },
            label: { 
              text: "Back",
              callback: new BindIntent(function() {
                Beans.get(BeanVisuController).menu.send(Callable.run(this.callbackData))
                Beans.get(BeanVisuController).sfxService.play("menu-select-entry")
              }),
              callbackData: config.back,
              onMouseReleasedLeft: function() {
                this.callback()
              },
              colorHoverOut: VisuTheme.color.deny,
            },
          }
        }
      ])
    })

    var editorConstructor = Core.getConstructor("VisuEditorController")
    if (Optional.is(editorConstructor)) {
      event.data.content.add({
        name: "developer_menu-button-input-entry_editor",
        template: VisuComponents.get("menu-button-input-entry"),
        layout: VisuLayouts.get("menu-button-input-entry"),
        config: {
          layout: { type: UILayoutType.VERTICAL },
          label: { 
            text: "Editor",
            callback: function() {
              Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              var value = false
              var editorIOConstructor = Core.getConstructor(Visu.modules().editor.io)
              var editorControllerConstructor = Core.getConstructor(Visu.modules().editor.controller)
              if (!Optional.is(editorIOConstructor) || !Optional.is(editorControllerConstructor)) {
                return
              }
              
              if (Optional.is(Beans.get(Visu.modules().editor.io))) {
                Beans.kill(Visu.modules().editor.io)
                value = false
              } else {
                Beans.add(Beans.factory(Visu.modules().editor.io, GMServiceInstance, 
                  Beans.get(BeanVisuController).layerId, new editorIOConstructor()))
                value = true
              }

              if (Optional.is(Beans.get(Visu.modules().editor.controller))) {
                Beans.kill(Visu.modules().editor.controller)
                value = false
              } else {
                Beans.add(Beans.factory(Visu.modules().editor.controller, GMServiceInstance, 
                  Beans.get(BeanVisuController).layerId, new editorControllerConstructor()))
                value = true
                var editor = Beans.get(Visu.modules().editor.controller)
                if (Optional.is(editor)) {
                  editor.send(new Event("open"))
                }
              }

              Visu.settings.setValue("visu.editor.enable", value).save()
            },
            onMouseReleasedLeft: function() {
              this.callback()
            },
          },
          input: {
            label: { text: "" },
            updateCustom: function() {
              this.label.text = Optional.is(Beans.get(Visu.modules().editor.controller)) ? VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT : VISU_MENU_BUTTON_INPUT_ENTRY_FALSE_TEXT
              this.label.alpha = this.label.text == VISU_MENU_BUTTON_INPUT_ENTRY_TRUE_TEXT ? 1.0 : 0.3
            },
            callback: function() {
              Beans.get(BeanVisuController).sfxService.play("menu-use-entry")
              var value = false

              var editorIOConstructor = Core.getConstructor("VisuEditorIO")
              if (Optional.is(editorIOConstructor)) {
                if (Optional.is(Beans.get(Visu.modules().editor.io))) {
                  Beans.kill(Visu.modules().editor.io)
                  value = false
                } else {
                  Beans.add(Beans.factory(Visu.modules().editor.io, GMServiceInstance, 
                    Beans.get(BeanVisuController).layerId, new editorIOConstructor()))
                  value = true
                }
              }

              var editorConstructor = Core.getConstructor("VisuEditorController")
              if (Optional.is(editorConstructor)) {
                if (Optional.is(Beans.get(Visu.modules().editor.controller))) {
                  Beans.kill(Visu.modules().editor.controller)
                  value = false
                } else {
                  Beans.add(Beans.factory(Visu.modules().editor.controller, GMServiceInstance, 
                    Beans.get(BeanVisuController).layerId, new editorConstructor()))
                  value = true
                  var editor = Beans.get(Visu.modules().editor.controller)
                  if (Optional.is(editor)) {
                    editor.send(new Event("open"))
                  }
                }
              }

              Visu.settings.setValue("visu.editor.enable", value).save()
            },
          }
        }
      }, 1)
    }

    return event
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "visu-menu",
        //x: function() { return this.context.x() + (this.context.width() - this.width()) / 2.0 },
        x: function() { return this.context.x() },
        y: function() { return this.context.y() },
        width: function() { return this.context.width() },
        height: function() { return this.context.height() },
        nodes: {
          "visu-menu.title": {
            name: "visu-menu.title",
            x: function() { return this.context.x() },
            y: function() { return this.context.y() },
            width: function() { return this.context.width() },
            height: function() { return min(this.context.height() * 0.16, 100) },
          },
          "visu-menu.content": {
            name: "visu-menu.content",
            x: function() { return this.context.x() + ((this.context.width() - this.width()) / 2.0) },
            y: function() { return Struct.get(this.context.nodes, "visu-menu.title").bottom() 
              + this.__margin.top 
              + ((this._height(this.context, this.__margin) - this.height()) / 2.0)
            },
            width: function() { return max(this.context.width() * 0.3, 540) },
            viewHeight: 0.0,
            height: function() {
              this.viewHeight = clamp(this.viewHeight, 0.0, this._height(this.context, this.__margin))
              return this.viewHeight
            },
            _height: function(context, margin) { 
              return context.height() 
                - Struct.get(context.nodes, "visu-menu.title").height()
                - Struct.get(context.nodes, "visu-menu.footer").height()
                - margin.top
                - margin.bottom
            },
            //margin: { top: 24, bottom: 24 },
            margin: { top: 0, bottom: 0 },
          },
          "visu-menu.footer": {
            name: "visu-menu.footer",
            x: function() { return this.context.x() },
            y: function() { return this.context.y() + this.context.height() - this.height() },
            width: function() { return this.context.width() },
            height: function() { return min(this.context.height() * 0.16, 100) },
          },
        }
      },
      parent
    )
  }

  ///@private
  ///@param {Struct} title
  ///@param {Array<Struct>} content
  ///@param {?UIlayout} [parent]
  ///@return {Map<String, UI>}
  factoryContainers = function(title, content, parent = null) {
    static factoryTitle = function(name, controller, layout, title) {
      return new UI({
        name: name,
        controller: controller,
        layout: layout,
        state: new Map(String, any, {
          "background-alpha": 0.5,
          "background-color": ColorUtil.fromHex(VisuTheme.color.sideDark).toGMColor(),
          "title": title,
          "uiAlpha": 0.0,
          "uiAlphaFactor": 0.05,
        }),
        updateArea: Callable
          .run(UIUtil.updateAreaTemplates
          .get("applyLayout")),
        renderDefault: new BindIntent(Callable
          .run(UIUtil.renderTemplates
          .get("renderDefaultNoSurface"))),
        __render: function() {
          var uiAlpha = clamp(this.state.get("uiAlpha") + DELTA_TIME * this.state.get("uiAlphaFactor"), 0.0, 1.0)
          this.state.set("uiAlpha", uiAlpha)
          this.renderDefault()
        },
        render: function() {
          var uiAlpha = clamp(this.state.get("uiAlpha") + DELTA_TIME * this.state.get("uiAlphaFactor"), 0.0, 1.0)
          //var uiAlpha = clamp(this.state.get("uiAlpha") + DeltaTime.apply(this.state.get("uiAlphaFactor")), 0.0, 1.0) 
          this.state.set("uiAlpha", uiAlpha)
          if (this.surface == null) {
            this.surface = new Surface({ width: this.area.getWidth(), height: this.area.getHeight() })
          }

          this.surface.update(this.area.getWidth(), this.area.getHeight())
          //if (!this.surfaceTick.get() && !this.surface.updated) {
          //  this.surface.render(this.area.getX(), this.area.getY(), uiAlpha)
          //  return
          //}
          
          GPU.set.surface(this.surface)
          var color = this.state.get("background-color")
          if (Core.isType(color, GMColor)) {
            GPU.render.clear(color, uiAlpha * this.state.getIfType("background-alpha", Number, 1.0))
          }
          
          var areaX = this.area.x
          var areaY = this.area.y
          var delta = DeltaTime.deltaTime
          DeltaTime.deltaTime += this.updateTimer != null && this.updateTimer.finished && this.surfaceTick.previous ? 0.0 : this.surfaceTick.delta
          this.area.x = this.offset.x
          this.area.y = this.offset.y
          this.items.forEach(this.renderItem, this.area)
          this.area.x = areaX
          this.area.y = areaY
          DeltaTime.deltaTime = delta
  
          GPU.reset.surface()
          static easeInExpo = function(progress = 0.0) {
            return progress == 0.0 ? 0.0 : Math.pow(2.0, 10.0 * progress - 10.0)
          }

          static easeOutExpo = function(progress = 0.0) {
            return progress == 1.0 ? 1.0 : 1.0 - Math.pow(2.0, -10.0 * progress)
          }
          
          var _ui = this.state.get("uiAlphaFactor") >= 0.0
            ? easeOutExpo(uiAlpha)
            : (1.0 + easeInExpo(1.0 - abs(uiAlpha)))
          this.surface.render(this.area.getX() * _ui, this.area.getY(), uiAlpha)
          //this.renderDefault()
        },
        onInit: function() {
          this.items.forEach(function(item) { item.free() }).clear()
          this.addUIComponents(new Array(UIComponent, [ 
            new UIComponent(this.state.get("title"))
          ]),
          new UILayout({
            area: this.area,
            width: function() { return this.area.getWidth() },
            height: function() { return this.area.getHeight() },
          }))
        },
      })
    }

    static factoryContent = function(name, controller, layout, content) {
      return new UI({
        name: name,
        controller: controller,
        layout: layout,
        selectedIndex: 0,
        previousIndex: 0,
        state: new Map(String, any, {
          "background-alpha": 0.33,
          "background-color": ColorUtil.fromHex(VisuTheme.color.accentShadow).toGMColor(),
          "content": content,
          "isKeyboardEvent": true,
          "initPress": false,
          "remapKey": null,
          "remapKeyRestored": 2,
          "uiAlpha": 0.0,
          "uiAlphaFactor": 0.05,
          "breath": new Timer(16 * pi, { loop: Infinity, amount: FRAME_MS * 8 }),
          "keyboard": new Keyboard({
            up: KeyboardKeyType.ARROW_UP,
            down: KeyboardKeyType.ARROW_DOWN,
            left: KeyboardKeyType.ARROW_LEFT,
            right: KeyboardKeyType.ARROW_RIGHT,
            space: KeyboardKeyType.SPACE,
            enter: KeyboardKeyType.ENTER,
          }),
          "keyUpdater": new PrioritizedPressedKeyUpdater({ cooldown: 0.05 }),
          "playerKeyUpdater": new PrioritizedPressedKeyUpdater({ cooldown: 0.05 }),
        }),
        scrollbarY: { align: HAlign.RIGHT },
        fetchViewHeight: function() {
          return VISU_MENU_ENTRY_HEIGHT * this.collection.size()
        },
        updateArea: Callable
          .run(UIUtil.updateAreaTemplates
          .get("scrollableY")),
        updateVerticalSelectedIndex: new BindIntent(Callable
          .run(UIUtil.templates
          .get("updateVerticalSelectedIndex"))),
        updateCustom: function() {
          this.layout.viewHeight = this.fetchViewHeight()
          this.controller.remapKey = this.state.get("remapKey")
          if (Optional.is(this.controller.remapKey)) {
            this.state.set("remapKeyRestored", 2)
            return
          } 

          var remapKeyRestored = this.state.get("remapKeyRestored")
          if (remapKeyRestored > 0) {
            this.state.set("remapKeyRestored", remapKeyRestored - 1)
            return
          }

          if (this.state.get("initPress")) {
            this.state.set("initPress", false)
            var pointer = Struct.inject(this, "selectedIndex", 0)
            pointer = Core.isType(pointer, Number) ? clamp(pointer, 0, this.collection.size() - 1) : 0
            this.state.set("isKeyboardEvent", true)
            Struct.set(this, "selectedIndex", pointer)

            this.collection.components.forEach(function(component, iterator, pointer) {
              if (component.index == pointer) {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOver") 
                    ? ColorUtil.fromHex(item.colorHoverOver).toGMColor()
                    : item.backgroundColor
                })
              } else {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOut") 
                    ? ColorUtil.fromHex(item.colorHoverOut).toGMColor()
                    : item.backgroundColor
                })
              }
            }, pointer)
          }

          var keyboard = this.state.get("keyboard")
          var playerKeyboard = Beans.get(BeanVisuIO).keyboards.get("player")
          //this.state.get("keyUpdater")
          //  .updateKeyboard(keyboard.update())
          keyboard.update()
          this.state.get("playerKeyUpdater")
            .bindKeyboardKeys(playerKeyboard)
            .updateKeyboard(playerKeyboard.update())
          if (playerKeyboard.keys.up.pressed || keyboard.keys.up.pressed) {
            var pointer = Struct.inject(this, "selectedIndex", 0)
            if (!Core.isType(pointer, Number)) {
              pointer = 0
            } else {
              pointer = clamp(
                (pointer == 0 ? this.collection.size() - 1 : pointer - 1), 
                0, 
                (this.collection.size() -1 >= 0 ? this.collection.size() - 1 : 0)
              )
            }

            this.state.set("isKeyboardEvent", true)
            Struct.set(this, "selectedIndex", pointer)

            this.collection.components.forEach(function(component, iterator, pointer) {
              if (component.index == pointer) {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOver") 
                    ? ColorUtil.fromHex(item.colorHoverOver).toGMColor()
                    : item.backgroundColor
                })
              } else {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOut") 
                    ? ColorUtil.fromHex(item.colorHoverOut).toGMColor()
                    : item.backgroundColor
                })
              }
            }, pointer)
          }

          if (playerKeyboard.keys.down.pressed || keyboard.keys.down.pressed) {
            var pointer = Struct.inject(this, "selectedIndex", 0)
            if (!Core.isType(pointer, Number)) {
              pointer = 0
            } else {
              pointer = clamp(
                (pointer == this.collection.size() - 1 ? 0 : pointer + 1), 
                0, 
                (this.collection.size() - 1 >= 0 ? this.collection.size() - 1 : 0)
              )
            }
            
            this.state.set("isKeyboardEvent", true)
            Struct.set(this, "selectedIndex", pointer)

            this.collection.components.forEach(function(component, iterator, pointer) {
              if (component.index == pointer) {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOver") 
                    ? ColorUtil.fromHex(item.colorHoverOver).toGMColor()
                    : item.backgroundColor
                })
              } else {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOut") 
                    ? ColorUtil.fromHex(item.colorHoverOut).toGMColor()
                    : item.backgroundColor
                })
              }
            }, pointer)
          }

          if (playerKeyboard.keys.left.pressed || keyboard.keys.left.pressed) {
            var component = this.collection.findByIndex(Struct.inject(this, "selectedIndex", 0))
            if (Optional.is(component)) {
              var type = null
              if (String.contains(component.name, "menu-button-entry")) {
                type = "menu-button-entry"
              } else if (String.contains(component.name, "menu-button-input-entry")) {
                type = "menu-button-input-entry"
              } else if (String.contains(component.name, "menu-spin-select-entry")) {
                type = "menu-spin-select-entry"
              } if (String.contains(component.name, "menu-slider-entry")) {
                type = "menu-slider-entry"
              }

              switch (type) {
                case "menu-button-entry":
                  break
                case "menu-button-input-entry":
                  var label = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "label")

                  if (Optional.is(label)) {
                    label.callback()
                  }
                  break
                case "menu-spin-select-entry":
                  var previous = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "previous")
                  
                  if (Optional.is(previous)) {
                    previous.callback()
                  }
                  break
                case "menu-slider-entry":
                  var slider = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "slider")
                  
                  if (Optional.is(slider)) {
                    slider.value = clamp(slider.value - slider.snapValue, slider.minValue, slider.maxValue)
                    if (slider.store != null && value != slider.store.getValue()) {
                      slider.store.set(slider.value)
                    }
                    slider.callback()
                  }
                  break
              }
            }
          }

          if (playerKeyboard.keys.right.pressed || keyboard.keys.right.pressed) {
            var component = this.collection.findByIndex(Struct.inject(this, "selectedIndex", 0))
            if (Optional.is(component)) {
              var type = null
              if (String.contains(component.name, "menu-button-entry")) {
                type = "menu-button-entry"
              } else if (String.contains(component.name, "menu-button-input-entry")) {
                type = "menu-button-input-entry"
              } else if (String.contains(component.name, "menu-spin-select-entry")) {
                type = "menu-spin-select-entry"
              } if (String.contains(component.name, "menu-slider-entry")) {
                type = "menu-slider-entry"
              }

              switch (type) {
                case "menu-button-entry":
                  break
                case "menu-button-input-entry":
                  var label = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "label")

                  if (Optional.is(label)) {
                    label.callback()
                  }
                  break
                case "menu-spin-select-entry":
                  var next = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "next")
                  
                  if (Optional.is(next)) {
                    next.callback()
                  }
                  break
                case "menu-slider-entry":
                  var slider = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "slider")
                  
                  if (Optional.is(slider)) {
                    slider.value = clamp(slider.value + slider.snapValue, slider.minValue, slider.maxValue)
                    if (slider.store != null && value != slider.store.getValue()) {
                      slider.store.set(slider.value)
                    }
                    slider.callback()
                  }
                  break
              }
            }
          }
          
          if (playerKeyboard.keys.action.pressed
            || keyboard.keys.space.pressed
            || keyboard.keys.enter.pressed) {
            var component = this.collection.findByIndex(Struct.inject(this, "selectedIndex", 0))
            if (Optional.is(component)) {
              var type = null
              if (String.contains(component.name, "menu-button-entry")) {
                type = "menu-button-entry"
              } else if (String.contains(component.name, "menu-button-input-entry")) {
                type = "menu-button-input-entry"
              } else if (String.contains(component.name, "menu-spin-select-entry")) {
                type = "menu-spin-select-entry"
              } else if (String.contains(component.name, "menu-keyboard-key-entry")) {
                type = "menu-keyboard-key-entry"
              } if (String.contains(component.name, "menu-slider-entry")) {
                type = "menu-slider-entry"
              }

              switch (type) {
                case "menu-button-entry":
                case "menu-button-input-entry":
                  var label = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "label")

                  if (Optional.is(label)) {
                    label.callback()
                  }
                  break
                case "menu-spin-select-entry":
                  break
                case "menu-keyboard-key-entry":
                  var label = component.items.find(function(item, index, name) { 
                    return String.contains(item.name, name) && Core.isType(Struct.get(item, "callback"), Callable)
                  }, "label")

                  if (Optional.is(label)) {
                    label.callback()
                  }
                  break
                case "menu-slider-entry":
                  break
              }
            }
          }

          var component = this.collection.findByIndex(Struct.get(this, "selectedIndex"))
          if (Optional.is(component)) {
            if (this.selectedIndex != this.previousIndex) {
              Beans.get(BeanVisuController).sfxService.play("menu-move-cursor")
            }
            this.previousIndex = this.selectedIndex

            this.state.get("breath").update()
            component.items.forEach(function(item, index, context) {
              // horizontal offset
              var itemX = item.area.getX();
              var itemWidth = item.area.getWidth()
              var offsetX = abs(context.offset.x)
              var areaWidth = context.area.getWidth()
              var itemRight = itemX + itemWidth
              if (itemX < offsetX || itemRight > offsetX + areaWidth) {
                var newX = (itemX < offsetX) ? itemX : itemRight - areaWidth
                context.offset.x = -1 * clamp(newX, 0.0, abs(context.offsetMax.x))
              }

              // vertical offset
              var itemY = item.area.getY();
              var itemHeight = item.area.getHeight()
              var offsetY = abs(context.offset.y)
              var areaHeight = context.area.getHeight()
              var itemBottom = itemY + itemHeight
              if (itemY < offsetY || itemBottom > offsetY + areaHeight) {
                var newY = (itemY < offsetY) ? itemY : itemBottom - areaHeight
                context.offset.y = -1 * clamp(newY, 0.0, abs(context.offsetMax.y))
              }

              item.backgroundAlpha = ((cos(this.state.get("breath").time) + 2.0) / 3.0) + 0.3
            }, this)
          }

          this.collection.components.forEach(function(component, iterator, pointer) {
            if (component.index != pointer) {
              component.items.forEach(function(item) {
                item.backgroundAlpha = 0.75
              })
            }
          }, Struct.get(this, "selectedIndex"))
        },
        renderItem: Callable
          .run(UIUtil.renderTemplates
          .get("renderItemDefaultScrollable")),
        renderDefaultScrollable: new BindIntent(Callable
          .run(UIUtil.renderTemplates
          .get("renderDefaultScrollableBlend"))),
        renderDefault: function() {
          this.updateVerticalSelectedIndex(VISU_MENU_ENTRY_HEIGHT)
          this.renderDefaultScrollable()
        },
        renderSurface: function() {
          var color = this.state.getIfType("background-color", GMColor, c_white)
          var alpha = this.state.getIfType("background-alpha", Number, 0.0)
          GPU.render.clear(color, alpha * this.state.get("uiAlpha"))
          
          var areaX = this.area.x
          var areaY = this.area.y
          //var delta = DeltaTime.deltaTime
          //DeltaTime.deltaTime += this.updateTimer != null && this.updateTimer.finished && this.surfaceTick.previous ? 0.0 : this.surfaceTick.delta
          this.area.x = this.offset.x
          this.area.y = this.offset.y
          this.items.forEach(this.renderItem, this.area)
          this.area.x = areaX
          this.area.y = areaY
          //DeltaTime.deltaTime = delta
        },
        render: function() {
          var uiAlpha = clamp(this.state.get("uiAlpha") + DELTA_TIME * this.state.get("uiAlphaFactor"), 0.0, 1.0)
          //var uiAlpha = clamp(this.state.get("uiAlpha") + DeltaTime.apply(this.state.get("uiAlphaFactor")), 0.0, 1.0)
          this.state.set("uiAlpha", uiAlpha)

          this.updateVerticalSelectedIndex(VISU_MENU_ENTRY_HEIGHT)
          if (!Optional.is(this.surface)) {
            this.surface = new Surface()
          }
  
          this.surface.update(this.area.getWidth(), this.area.getHeight())
          //if (!this.surfaceTick.get() && !this.surface.updated) {
          //  this.surface.render(this.area.getX(), this.area.getY(), uiAlpha)
          //  if (this.enableScrollbarY) {
          //    this.scrollbarY.render(this)
          //  }
          //  return
          //}
  
          this.surface.renderOn(this.renderSurface)
          static easeInExpo = function(progress = 0.0) {
            return progress == 0.0 ? 0.0 : Math.pow(2.0, 10.0 * progress - 10.0)
          }

          static easeOutExpo = function(progress = 0.0) {
            return progress == 1.0 ? 1.0 : 1.0 - Math.pow(2.0, -10.0 * progress)
          }
          
          var _ui = this.state.get("uiAlphaFactor") >= 0.0
            ? easeOutExpo(uiAlpha)
            : (1.0 + easeInExpo(1.0 - abs(uiAlpha)))
          this.surface.render(this.area.getX() * _ui, this.area.getY(), uiAlpha)
          if (this.enableScrollbarY) {
            this.scrollbarY.render(this)
          }
        },
        onMousePressedLeft: Callable
          .run(UIUtil.mouseEventTemplates
          .get("onMouseScrollbarY")),
        onMouseWheelUp: Callable
          .run(UIUtil.mouseEventTemplates
          .get("scrollableOnMouseWheelUpY")),
        onMouseWheelDown: Callable
          .run(UIUtil.mouseEventTemplates
          .get("scrollableOnMouseWheelDownY")),
        onInit: function() {
          this.collection = new UICollection(this, { layout: this.layout })
          this.state.get("content").forEach(function(template, index, context) {
            context.collection.add(new UIComponent(template))
          }, this)

          if (this.state.get("content").size() > 0) {
            Struct.set(this, "selectedIndex", 0)
            this.state.set("isKeyboardEvent", true)
            this.collection.components.forEach(function(component, iterator, pointer) {
              if (component.index == pointer) {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOver") 
                    ? ColorUtil.fromHex(item.colorHoverOver).toGMColor()
                    : item.backgroundColor
                })
              } else {
                component.items.forEach(function(item) {
                  item.backgroundColor = Struct.contains(item, "colorHoverOut") 
                    ? ColorUtil.fromHex(item.colorHoverOut).toGMColor()
                    : item.backgroundColor
                })
              }
            }, Struct.inject(this, "selectedIndex", 0))
          }

          this.state.set("initPress", true)
          this.scrollbarY.render = method(this.scrollbarY, function() { })
        },
      })
    }

    this.layout = this.factoryLayout(parent)
    this.containers
      .clear()
      .set(
        "container_visu-menu.title", 
        factoryTitle(
          "container_visu-menu.title",
          this,
          Struct.get(this.layout.nodes, "visu-menu.title"),
          title
        ))
      .set(
        "container_visu-menu.content", 
        factoryContent(
          "container_visu-menu.content",
          this,
          Struct.get(this.layout.nodes, "visu-menu.content"),
          content
        ))
      .set(
        "container_visu-menu.footer", 
        factoryTitle(
          "container_visu-menu.footer",
          this,
          Struct.get(this.layout.nodes, "visu-menu.footer"),
          {
            name: "visu-menu.footer",
            template: VisuComponents.get("menu-title"),
            layout: VisuLayouts.get("menu-title"),
            config: {
              label: { 
                //text: $"github.com/Alkapivo | v.{GM_build_date} | {date_datetime_string(GM_build_date)}",
                text: $"v{Visu.version()}\nBaron's Keep 2025 (c)\n",
                updateCustom: function() {
                  var serverVersion = Visu.serverVersion()
                  if (!Optional.is(serverVersion)) {
                    return this
                  }

                  var version = Visu.version()
                  this.label.text = version == serverVersion 
                    ? $"v{version}\nBaron's Keep 2025 (c)\n"
                    : $"v{version} (itch.io: v{serverVersion})\nBaron's Keep 2025 (c)\n"

                },
                font: "font_kodeo_mono_12_bold",
                onMouseReleasedLeft: function() {
                  url_open("https://github.com/Barons-Keep/visu-project")
                }
              },
            },
          }
        ))

    return this.containers
  }
  
  ///@private
  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      var controller = Beans.get(BeanVisuController)
      var editor = Beans.get(Visu.modules().editor.controller)
      if (editor != null && editor.renderUI) {
        //this.enabled = false
        return
      }

      var blur = controller.visuRenderer.blur
      blur.target = 24.0
      blur.startValue = blur.value
      blur.reset()

      this.dispatcher.execute(new Event("close"))
      this.back = Struct.getIfType(event.data, "back", Callable)
      this.backData = Struct.get(event.data, "backData")
      this.enabled = true
      this.containers = this.factoryContainers(event.data.title, event.data.content, event.data.layout)
      this.containers.forEach(function(container, key, uiService) {
        container.state.set("uiAlphaFactor", 0.05)
        uiService.send(new Event("add", {
          container: container,
          replace: true,
        }))
      }, controller.uiService)
    },
    "close": function(event) {    
      var controller = Beans.get(BeanVisuController)
      if (Struct.getIfType(event.data, "fade", Boolean, false)) {
        var blur = controller.visuRenderer.blur
        blur.target = 0.0
        blur.startValue = blur.value
        blur.reset()

        this.containers.forEach(function (container) {
          Struct.set(container, "onMousePressedLeft", method(container, function(event) { }))
          Struct.set(container, "onMouseWheelUp", method(container, function(event) { }))
          Struct.set(container, "onMouseWheelDown", method(container, function(event) { }))
          Struct.set(container, "updateCustom", method(container, function() {
            this.state.set("uiAlphaFactor", -0.05)
            var blur = Beans.get(BeanVisuController).visuRenderer.blur
            if (blur.value == 0.0) {
              this.controller.send(new Event("close"))
            }
          }))
        })

        return
      }

      this.back = null
      this.backData = null
      this.enabled = false
      this.containers.forEach(function (container, key, uiService) {
        uiService.send(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, controller.uiService).clear()
    },
    "back": function(event) {
      if (this.back != null) {
        this.dispatcher.execute(this.back(this.backData))
        return
      }

      this.dispatcher.execute(new Event("close", { fade: true }))
    },
    "game-end": function(event) {
      game_end()
    },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETrackControl}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}
