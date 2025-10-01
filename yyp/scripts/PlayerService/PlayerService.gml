///@package io.alkapivo.visu.service.player

///@param {VisuController} _controller
///@param {Struct} [config]
function PlayerService(_controller, config = {}): Service() constructor {

  ///@type {VisuController}
  controller = Assert.isType(_controller, VisuController)

  ///@type {?Player}
  player = null

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "spawn-player": function(event) {
      var template = new PlayerTemplate({
        name: "player_default",
        sprite: Struct.getDefault(event.data, "sprite", {
          name: "texture_player",
          animate: true,
        }),
        mask: Struct.get(event.data, "mask"),
        stats: Struct.get(event.data, "stats"),
        keyboard: Beans.get(BeanVisuIO).keyboards.get("player"),
        handler: JSON.clone(Struct.getIfType(event.data, "handler", Struct, {})),
      })

      var gridService = this.controller.gridService
      var view = gridService.view
      var _x = view.x + (view.width / 2.0)
      var _y = gridService.height - (view.height * 0.25)

      if (Core.isType(this.player, Player)) {
        if (Struct.get(event.data, "reset-position") != true) {
          _x = this.player.x
          _y = this.player.y
        }

        if (!Optional.is(Struct.get(template, "stats"))) {
          Struct.set(template, "stats", this.player.stats)
        }
      }

      Struct.set(template, "x", _x)
      Struct.set(template, "y", _y)
      Struct.set(template, "uid", this.controller.gridService.generateUID())

      this.set(new Player(template))
    },
    "clear-player": function(event) {
      this.remove()
    },
  }))

  ///@param {Player}
  ///@return {PlayerService}
  set = function(player) {
    if (!Core.isType(player, Player)) {
      return this
    }

    this.remove().player = player
    return this
  }

  ///@return {PlayerService}
  remove = function() {
    this.player = null
    return this
  }

  ///@param {Event} event
  ///@return {Promise}
  send = function(event) {
    if (!Core.isType(event.promise, Promise)) {
      event.promise = new Promise()
    }

    return this.dispatcher.send(event)
  }

  ///@override
  ///@return {PlayerService}
  update = function() {
    this.dispatcher.update()
    if (this.player != null) {
      this.player.update(this.controller)
    }

    return this
  }
}
