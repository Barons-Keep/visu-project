///@package io.alkapivo.visu.test.component.player

///@static
global.__PlayerServiceTestUtil = {

  ///@param {Player} player
  ///@param {Struct} [config]
  installKeyboardHook: function(player, config = {}) {
    if (Struct.getIfType(player, "keyboardHook", Boolean, false)) {
      return
    }

    Struct.set(player, "keyboardHook", true)
    Struct.set(player.keyboard, "keypressMap", Struct.toMap(config, String, TestKeypress, function(config, key) {
      return new TestKeypress({
        durations: GMArray.map(Struct.getIfType(config, "durations", GMArray, []), Lambda.passthrough),
        luck: Struct.getIfType(config, "luck", Number, 0.0),
        key: key,
      })
    }))
    Struct.set(player.keyboard, "_update", player.keyboard.update)
    Struct.set(player.keyboard, "update", method(player.keyboard, function() {
      this.keypressMap.forEach(function(keypress, name, keyboard) {
        keypress.update().updateKeyboard(keyboard)
      }, this)
      return this
    }))
  },

  ///@param {Player}
  uninstallKeyboardHook: function(player) {
    Struct.set(player, "keyboardHook", false)
    var update = Struct.getIfType(player.keyboard, "_update", Callable)
    if (!Optional.is(update)) {
      Logger.warn("uninstallKeyboardHook", "_update was not found")
      update = function() {
        Logger.warn("Player", "Dummy player keyboard update")
      }
    }

    player.keyboard.update = method(player.keyboard, update)
  },
}
#macro PlayerServiceTestUtil global.__PlayerServiceTestUtil


///@param {Struct} [json]
///@return {Task}
function TestEvent_PlayerService_player_shoot(json = {}) constructor {
  return new Task("TestEvent_PlayerService_player_shoot")
    .setTimeout(Struct.getIfType(json, "timeout", Number, 10.0))
    .setPromise(new Promise())
    .setState({
      player: Struct.getIfType(json, "player", Struct, {
        "icon":{
          "name":"texture_ve_icon_effect_shader",
          "blend":"#3564C5"
        },
        "en-pl_use-mask":true,
        "en-pl_use-stats":true,
        "en-pl_texture":{
          "angle":0.0,
          "frame":0.046923670000000001,
          "alpha":1.0,
          "animate":1.0,
          "blend":"#FFFFFF",
          "scaleX":2.0,
          "scaleY":2.0,
          "speed":7.0,
          "name":"texture_baron",
          "randomFrame":false
        },
        "en-pl_mask":{
          "x":56.0,
          "y":56.0,
          "width":60.0,
          "height":60.0
        },
        "en-pl_reset-pos":true,
        "en-pl_stats":{
          "force":{
            "value":0.0
          },
          "bomb":{
            "value":5.0
          },
          "life":{
            "value":4.0
          },
          "point":{
            "value":0.0
          }
        },
        "en-pl_use-bullethell":true,
        "en-pl_bullethell":{
          "x":{
            "acceleration":2.0,
            "friction":20.0,
            "speedMax":1.6
          },
          "y":{
            "acceleration":2.0,
            "friction":20.0,
            "speedMax":1.6
          },
          "guns":[
            {
              "cooldown":60.0,
              "angle":90.0,
              "bullet":"bullet-default",
              "speed":24.0,
              "offsetX":-112.0,
              "offsetY":-96.0,
              "focus": null,
            },
            {
              "cooldown":60.0,
              "angle":90.0,
              "bullet":"bullet-default",
              "speed":24.0,
              "offsetX":112.0,
              "offsetY":-96.0,
              "focus": false,
            },
            {
              "cooldown":60.0,
              "angle":96.0,
              "bullet":"bullet-default",
              "minForce":1.0,
              "speed":24.0,
              "offsetX":-112.0,
              "offsetY":96.0,
              "focus": true,
            },
            {
              "cooldown":60.0,
              "angle":84.0,
              "bullet":"bullet-default",
              "minForce":1.0,
              "speed":24.0,
              "offsetX":112.0,
              "offsetY":96.0,
              "focus": true,
            }
          ]
        },
        "en-pl_use-platformer":true,
        "en-pl_platformer":{
          "x":{
            "acceleration":1.9199999999999999,
            "friction":9.3000000000000007,
            "speedMax":2.5
          },
          "jump":{
            "size":4.0
          },
          "y":{
            "acceleration":1.9199999999999999,
            "friction":0.0,
            "speedMax":25.0
          }
        },
        "en-pl_use-racing":true,
        "en-pl_racing":{
          "nitro":{
            "acceleration":0.5,
            "friction":1.0,
            "speedMax":1.0
          },
          "throttle":{
            "acceleration":0.20000000000000001,
            "friction":0.5,
            "speedMax":1.5
          },
          "wheel":{
            "acceleration":0.29999999999999999,
            "friction":0.059999999999999998,
            "speedMax":3.0
          }
        },
      }),
      unfocusTimer: new Timer(Struct.getIfType(json, "unfocusTimer", Number, 2.0)),
      unfocusBulletCount: Struct.getIfType(json, "unfocusBulletCount", Number, 4),
      focusTimer: new Timer(Struct.getIfType(json, "focusTimer", Number, 2.0)),
      focusBulletCount: Struct.getIfType(json, "focusBulletCount", Number, 5),
      stage: "init",
      calcPlayerBullets: function() {
        var controller = Beans.get(BeanVisuController)
        var counter = { playerBullets: 0 }
        controller.bulletService.bullets.forEach(function(bullet, index, acc) {
          if (bullet.producer == Player) {
            acc.playerBullets += 1
          }
        }, counter)

        return counter.playerBullets
      },
      stages: {
        init: function(task) {
          var controller = Beans.get(BeanVisuController)
          if (controller.menu.containers.size() != 0) {
            return
          }

          controller.coinService.send(new Event("clear-coins"))
          controller.shroomService.send(new Event("clear-shrooms"))
          controller.bulletService.send(new Event("clear-bullets"))
          controller.playerService.send(new Event("clear-player"))
          task.state.stage = "spawn"
        },
        spawn: function(task) {
          var controller = Beans.get(BeanVisuController)
          Assert.isTrue(!Optional.is(controller.playerService.player), "player shouldn't be spawned")

          var counter = task.state.calcPlayerBullets()
          Assert.isTrue(counter == 0, $"At stage spawn Player bullets counter should be 0, not ${counter}")

          controller.dispatcher.execute(new Event("spawn-track-event", {
            callable: "brush_entity_player",
            config: task.state.player,
          }))

          task.state.stage = "unfocus"
        },
        unfocus: function(task) {
          var controller = Beans.get(BeanVisuController)
          var player = Assert.isType(controller.playerService.player, Player, "player must be spawned")

          PlayerServiceTestUtil.installKeyboardHook(player, {
            action: {
              durations: [ FRAME_MS ],
              luck: 1.0,
            },
            focus: {
              durations: [ FRAME_MS ],
              luck: 0.0,
            },
          })

          if (!task.state.unfocusTimer.update().finished) {
            return
          }

          var counter = task.state.calcPlayerBullets()
          Assert.isTrue(counter <= task.state.unfocusBulletCount, $"At stage unfocus Player bullets counter should be {task.state.unfocusBulletCount}, not ${counter}")
          if (counter == task.state.unfocusBulletCount) {
            controller.bulletService.send(new Event("clear-bullets"))
            task.state.stage = "beforeFocus"
            PlayerServiceTestUtil.uninstallKeyboardHook(player)
          }
        },
        beforeFocus: function(task) {
          var counter = task.state.calcPlayerBullets()
          Assert.isTrue(counter == 0, $"At stage beforeFocus Player bullets counter should be 0, not ${counter}")
          task.state.stage = "focus"
        },
        focus: function(task) {
          var controller = Beans.get(BeanVisuController)
          var player = Assert.isType(controller.playerService.player, Player, "player must be spawned")

          PlayerServiceTestUtil.installKeyboardHook(player, {
            action: {
              durations: [ FRAME_MS ],
              luck: 1.0,
            },
            focus: {
              durations: [ FRAME_MS ],
              luck: 1.0,
            },
          })

          if (!task.state.focusTimer.update().finished) {
            return
          }

          var counter = task.state.calcPlayerBullets()
          Assert.isTrue(counter <= task.state.focusBulletCount, $"At stage focus Player bullets counter should be {task.state.unfocusBulletCount}, not ${counter}")
          if (counter == task.state.focusBulletCount) {
            task.fullfill()
            PlayerServiceTestUtil.uninstallKeyboardHook(player)
            controller.coinService.send(new Event("clear-coins"))
            controller.shroomService.send(new Event("clear-shrooms"))
            controller.bulletService.send(new Event("clear-bullets"))
            controller.playerService.send(new Event("clear-player"))
          }
        },
      }
    })
    .whenUpdate(function(executor) {
      var stage = Struct.get(this.state.stages, this.state.stage)
      stage(this)
    })
    .whenStart(function(executor) {
      Logger.test("PlayerServiceTest", "TestEvent_PlayerService_player_shoot started")
      Beans.get(BeanTestRunner).installHooks()
      Visu.settings.setValue("visu.god-mode", true)
      Beans.get(BeanVisuController).menu.send(new Event("close", { fade: false }))
    })
    .whenFinish(function(data) {
      Logger.test("PlayerServiceTest", "TestEvent_PlayerService_player_shoot finished")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
    .whenTimeout(function() {
      Logger.test("PlayerServiceTest", "TestEvent_PlayerService_player_shoot timeout")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
}
