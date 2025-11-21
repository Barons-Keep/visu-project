///@package io.alkapivo.visu.ui.controller

///@param {Test} test
///@return {Task}
function Test_VisuMenu_select_track(test) {
  var json = Struct.get(test, "data")
  return new Task("Test_VisuMenu_select_track")
    .setTimeout(Struct.getDefault(json, "timeout", 60.0))
    .setPromise(new Promise())
    .setState({
      description: test.description,
      cooldown: new Timer(Struct.getDefault(json, "cooldown", 0.8)),
      getContent: function() {
        return Beans.get(BeanVisuController).menu.containers.get("container_visu-menu.content")
      },
      stage: "cooldownBefore",
      difficulty: Visu.settings.getValue("visu.difficulty"),
      stages: {
        cooldownBefore: function(task) {
          if (task.state.cooldown.update().finished) {
            task.state.stage = "setup"
            task.state.cooldown.reset()
          }
        },
        setup: function(task) {
          if (Beans.get(BeanVisuController).fsm.getStateName() == "splashscreen") {
            return
          }

          if (Optional.is(Beans.get(Visu.modules().editor.io))) {
            Beans.kill(Visu.modules().editor.io)
          }

          if (Optional.is(Beans.get(Visu.modules().editor.controller))) {
            Beans.kill(Visu.modules().editor.controller)
          }

          Beans.get(BeanTestRunner).exceptions.clear()
          task.state.stage = "open"
        },
        open: function(task) {
          var controller = Beans.get(BeanVisuController)
          controller.menu.send(controller.menu.factoryOpenMainMenuEvent())
          task.state.stage = "select_new_game"
        },
        select_new_game: function(task) {
          var content = task.state.getContent()
          if (!Optional.is(content)) {
            return
          }

          var item = content.items.get("label_main-menu_menu-button-entry_play_menu-button-entry")
          if (!Optional.is(item)) {
            return
          }

          item.onMouseReleasedLeft()
          task.state.stage = "select_artist"
        },
        select_artist: function(task) {
          var content = task.state.getContent()
          if (!Optional.is(content)) {
            return
          }

          var item = content.items.find(function(item) {
            return String.contains(item.name, "0_menu-button-entry")
          })

          if (!Optional.is(item)) {
            return
          }

          item.onMouseReleasedLeft()
          task.state.stage = "select_track"
        },
        select_track: function(task) {
          var content = task.state.getContent()
          if (!Optional.is(content)) {
            return
          }

          var item = content.items.find(function(item) {
            return String.contains(item.name, "0_menu-button-entry")
          })

          if (!Optional.is(item)) {
            return
          }

          item.onMouseReleasedLeft()
          task.state.stage = "verify_open_track_setup"
        },
        verify_open_track_setup: function(task) {
          var content = task.state.getContent()
          if (!Optional.is(content)) {
            return
          }
          var difficulty = Visu.settings.getValue("visu.difficulty")
          var play = content.items.get("label_open-track-setup_menu-button-entry_play_menu-button-entry")
          var button = content.items.get(difficulty == Difficulty.LUNATIC
            ? "open-track-setup_menu-spin-select-entry_difficulty_previous"
            : "open-track-setup_menu-spin-select-entry_difficulty_next")
          var back = content.items.get("label_open-track-setup_menu-button-entry_back_menu-button-entry")
          if (!Optional.is(play) || !Optional.is(button) || !Optional.is(back)) {
            return
          }

          button.onMouseReleasedLeft()
          task.state.difficulty = difficulty
          task.state.stage = "verify_difficulty"
        },
        verify_difficulty: function(task) {
          var content = task.state.getContent()
          if (!Optional.is(content)) {
            return
          }

          var difficulty = Visu.settings.getValue("visu.difficulty")
          if (difficulty == task.state.difficulty) {
            return
          }

          var back = content.items.get("label_open-track-setup_menu-button-entry_back_menu-button-entry")
          if (!Optional.is(back)) {
            return
          }

          back.onMouseReleasedLeft()
          task.state.stage = "verify_back"
        },
        verify_back: function(task) {
          var content = task.state.getContent()
          if (!Optional.is(content)) {
            return
          }
          
          var item = content.items.find(function(item) {
            return String.contains(item.name, "open-track-setup_menu-spin-select-entry_difficulty_")
          })

          if (Optional.is(item)) {
            return
          }

          task.state.stage = "done"
        },
        done: function(task) {
          task.fullfill()
        }
      }
    })
    .whenUpdate(function(executor) {
      var stage = Struct.get(this.state.stages, this.state.stage)
      stage(this)
    })
    .whenStart(function(executor) {
      Logger.test(BeanTestRunner, $"Test_VisuMenu_select_track started.\nDescription: {this.state.description}")
      Beans.get(BeanTestRunner).installHooks()
      Visu.settings.setValue("visu.god-mode", true)
    })
    .whenFinish(function(data) {
      Logger.test(BeanTestRunner, $"Test_VisuMenu_select_track finished.\nDescription: {this.state.description}")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
    .whenTimeout(function() {
      Logger.test(BeanTestRunner, $"Test_VisuMenu_select_track timeout.\nDescription: {this.state.description}")
      this.reject("failure")
      Beans.get(BeanTestRunner).uninstallHooks()
    })
}