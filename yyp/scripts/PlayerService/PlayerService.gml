///@package io.alkapivo.visu.service.player

///@param {?Struct} [config]
function PlayerService(config = null): Service(config) constructor {

  ///@type {?Player}
  player = null

  statistics = {
    lives: 0,
    usedLives: 0,
    bombs: 0,
    usedBombs: 0,
    force: 0,
    maxForce: 0,
    points: 0,
    normalTime: 0,
    focusedTime: 0,
    aliveTime: 0,
    maxAliveTime: 0,
    report: function() {
      return {
        lives: this.lives,
        usedLives: this.usedLives,
        bombs: this.bombs,
        usedBombs: this.usedBombs,
        force: this.force,
        maxForce: this.maxForce,
        points: this.points,
        normalTime: this.normalTime,
        focusedTime: this.focusedTime,
        maxAliveTime: this.maxAliveTime
      }
    },
    reset: function() {
      this.lives = 0
      this.usedLives = 0
      this.bombs = 0
      this.usedBombs = 0
      this.force = 0
      this.maxForce = 0
      this.points = 0
      this.normalTime = 0
      this.focusedTime = 0
      this.aliveTime = 0
      this.maxAliveTime = 0
      return this
    },
    factoryPlayer: function(player) {
      this.reset()
      return this
    },
    freePlayer: function(player, reason) {
      switch (reason) {
        case "life":
          this.usedLives += 1
          this.aliveTime = 0.0
          break
        case "bomb":
          this.usedBombs += 1
          break
        case "force":
          this.maxForce = max(this.maxForce, player.stats.force.value)
          break
        default:
          this.lives = player.stats.life.value
          this.bombs = player.stats.bomb.value
          this.force = player.stats.force.value
          this.points = player.stats.point.value
          this.aliveTime += FRAME_MS * DELTA_TIME
          this.maxAliveTime = max(this.aliveTime, this.maxAliveTime)
          if (player.handler.focus) {
            this.focusedTime += FRAME_MS * DELTA_TIME
          } else {
            this.normalTime += FRAME_MS * DELTA_TIME
          }
          break
      }
      return this
    },
    validate: function() {
      Logger.debug("PlayerService", "PlayerStatistics are OK")
      return this
    },
  }

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
        mouse: Beans.get(BeanVisuIO).mouses.get("player"),
        handler: JSON.clone(Struct.getIfType(event.data, "handler", Struct, {})),
      })

      var controller = Beans.get(BeanVisuController)
      var gridService = controller.gridService
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
      Struct.set(template, "uid", controller.gridService.generateUID())

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
      this.player.update(Beans.get(BeanVisuController))
    }

    return this
  }
}
