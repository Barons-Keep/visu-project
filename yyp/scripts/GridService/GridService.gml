///@package io.alkapivo.visu.service.grid


///@type {Number}
global.__GRID_SERVICE_PIXEL_WIDTH = 2048
#macro GRID_SERVICE_PIXEL_WIDTH global.__GRID_SERVICE_PIXEL_WIDTH


///@type {Number}
global.__GRID_SERVICE_PIXEL_HEIGHT = 2048
#macro GRID_SERVICE_PIXEL_HEIGHT global.__GRID_SERVICE_PIXEL_HEIGHT


///@type {Number}
global.__GRID_ITEM_FRUSTUM_RANGE = 8
#macro GRID_ITEM_FRUSTUM_RANGE global.__GRID_ITEM_FRUSTUM_RANGE


///@type {Number}
global.__GRID_ITEM_CHUNK_SERVICE_SIZE = 0.5
#macro GRID_ITEM_CHUNK_SERVICE_SIZE global.__GRID_ITEM_CHUNK_SERVICE_SIZE

///@type {Number}
#macro VISU_FADE_FACTOR 0.025

///@param {Number} {_size}
function GridItemChunkService(_size) constructor {

  ///@type {Number}
  size = Assert.isType(_size, Number)

  ///@type {Map<String, Arrat<GridItem>>}
  chunks = new Map(String, Array)

  ///@param {Number} x
  ///@param {Number} y
  ///@return {String}
  getKey = function(x, y) {
    //return $"{int64(x)}_{int64(y)}"
    return string(int64(x)) + "_" + string(int64(y))
  }

  ///@param {String}
  ///@throws {AssertException}
  ///@return {Array<GridItem>}
  get = function(key) {
    //Assert.isType(key, String, "[GridItemChunkService::get(key)] argument 'key' must be a type of String")
    if (!this.chunks.contains(key)) {
      this.chunks.set(key, new Array(GridItem))
    }

    return this.chunks.get(key)
  }

  ///@param {GridItem}
  ///@throws {Exception}
  ///@return {GridItemChunkService}
  add = function(item) {
    Assert.isType(item, GridItem, "[GridItemChunkService::add(item)] argument 'item' must be a type of GridItem")
    var width = (item.mask.getWidth() * item.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH
    var height = (item.mask.getHeight() * item.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT
    var position = {
      start: {
        x: int64((((item.x) - (width / 2)) / this.size)),
        y: int64((((item.y) - (height / 2)) / this.size)),
      },
      finish: {
        x: int64((((item.x) + (width / 2)) / this.size)),
        y: int64((((item.y) + (height / 2)) / this.size)),
      },
      keys: new Array(String),
    }

    for (var row = 0; row <= position.finish.y - position.start.y; row++) {
      for (var column = 0; column <= position.finish.x - position.start.x; column++) {
        var key = this.getKey(position.start.x + column, position.start.y + row)
        var chunk = this.get(key)
        if (Optional.is(chunk.findIndex(Lambda.equal, item))) {
          var message = $"GridItem with uid '{item.uid}' was already added to chunk '{key}'"
          Logger.error("GridItemChunkService::add(item)", message)
          Core.printStackTrace()
          throw new Exception(message)
        }

        chunk.add(item)
        position.keys.add(key)
      }
    }

    item.chunkPosition = position
    return this
  }

  ///@param {GridItem} item
  ///@throws {AssertException|Exception}
  ///@return {GridItemChunkService}
  remove = function(item) {
    Assert.isType(item, GridItem, "[GridItemChunkService::remove(item)] argument 'item' must be a type of GridItem")
    item.chunkPosition.keys.forEach(function(key, iterator, acc) {
      var chunk = acc.get(key)
      var index = chunk.findIndex(Lambda.equal, acc.item)
      if (!Optional.is(index)) {
        var message = $"GridItem with uid '{acc.item.uid}' wasn't found in chunk '{key}'"
        Logger.error("GridItemChunkService::remove(item)", message)
        Core.printStackTrace()
        throw new Exception(message)
      }

      chunk.remove(index)
    }, {
      get: this.get,
      item: item,
    })

    item.chunkPosition = null
    return this
  }

  ///@param {GridItem} item
  ///@throws {AssertException|Exception}
  ///@return {GridItemChunkService}
  update = function(item) {
    //Assert.isType(item.chunkPosition, Struct, "[GridItemChunkService::update(item)] 'item.chunkPosition' must be a type of Struct")
    var position = item.chunkPosition
    var width = (item.mask.getWidth() * item.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH
    var height = (item.mask.getHeight() * item.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT
    var startX = int64((((item.x) - (width / 2)) / this.size))
    var startY = int64((((item.y) - (height / 2)) / this.size))
    var finishX = int64((((item.x) + (width / 2)) / this.size))
    var finishY = int64((((item.y) + (height / 2)) / this.size))
    
    if (position.start.x != startX
      || position.start.y != startY
      || position.finish.x != finishX
      || position.finish.y != finishY) {

      ///this.remove(item) without replacing chunkPosition
      var array = item.chunkPosition.keys
      var size = array.size()
      for (var idx = 0; idx < size; idx++) {
        var key = array.get(idx)
        var chunk = this.get(key)
        var index = chunk.findIndex(Lambda.equal, item)
        if (!Optional.is(index)) {
          var message = $"GridItem with uid '{item.uid}' wasn't found in chunk '{key}'"
          Logger.error("GridItemChunkService::update(item)", message)
          Core.printStackTrace()
          throw new Exception(message)
        }
        chunk.remove(index)
      }

      ///this.add(item) without replacing chunkPosition
      position.start.x = startX
      position.start.y = startY
      position.finish.x = finishX
      position.finish.y = finishY
      position.keys.clear()
      for (var row = 0; row <= position.finish.y - position.start.y; row++) {
        for (var column = 0; column <= position.finish.x - position.start.x; column++) {
          var key = this.getKey(position.start.x + column, position.start.y + row)
          var chunk = this.get(key)
          if (Optional.is(chunk.findIndex(Lambda.equal, item))) {
            var message = $"GridItem with uid '{item.uid}' was already added to chunk '{key}'"
            Logger.error("GridItemChunkService::update(item)", message)
            Core.printStackTrace()
            throw new Exception(message)
          }
  
          chunk.add(item)
          position.keys.add(key)
        }
      }
    }

    return this
  }

  ///@return {GridItemChunkService}
  clear = function() {
    this.chunks.clear()
    return this
  }
}


///@param {?Struct} [config]
function GridService(_config = null) constructor {

  ///@type {?Struct}
  config = Core.isType(_config, Struct) ? JSON.clone(_config) : null

  ///@type {Number}
  width = Struct.getIfType(this.config, "width", Number, 2048.0)

  ///@type {Number}
  height = Struct.getIfType(this.config, "height", Number, 2048.0)

  ///@type {Number}
  pixelWidth = Struct.getIfType(this.config, "pixelWidth", Number, GRID_SERVICE_PIXEL_WIDTH)

  ///@type {Number}
  pixelHeight = Struct.getIfType(this.config, "pixelHeight", Number, GRID_SERVICE_PIXEL_HEIGHT)

  ///@type {GridView}
  view = new GridView({
    worldWidth: this.width, 
    worldHeight: this.height,
  })
  ///@description (set camera on middle bottom)
  this.view.x = (this.width - this.view.width) / 2.0
  this.view.y = this.height - this.view.height

  ///@type {TaskExecutor}
  executor = new TaskExecutor(this)

  ///@type {GridProperties}
  properties = new GridProperties(Struct.getIfType(this.config, "properties", Struct))

  ///@private
  ///@type {Number}
  uidPointer = toInt(Struct.getIfType(config, "uidPointer", Number, 0)) 
  
  ///@type {Struct}
  targetLocked = {
    x: this.view.x + (this.view.width / 2.0),
    y: this.view.y + (this.view.height / 2.0),
    isLockedX: false,
    isLockedY: false,
    lockX: null,
    lockY: null,
    snapH: floor(this.view.x / (this.view.width / 2.0)) * (this.view.width / 2.0),
    snapV: floor(this.view.y / (this.view.height / 2.0)) * (this.view.height / 2.0),
    setX: function(x) {
      this.x = x
      return this
    },
    setY: function(y) {
      this.y = y
      return this
    },
    updateMovement: function(gridService) {
      var angle = DeltaTime.apply(gridService.movement.angle.update().get() / 500.0)
      var spd = DeltaTime.apply(gridService.movement.speed.update().get())
      this.setX(this.x + Math.fetchCircleX(spd, angle))
      this.setY(this.y + Math.fetchCircleY(spd, angle))

      return this
    },
    updateLock: function(gridService) {
      var view = gridService.view
      var follow = view.follow
      var horizontal = gridService.properties.borderHorizontalLength / 2.0
      var vertical = gridService.properties.borderVerticalLength / 2.0
      var player = Beans.get(BeanVisuController).playerService.player
      var isPlayer = Core.isType(player, Player) 
      if (isPlayer) {
        this.setX(clamp(player.x, follow.xMargin, view.worldWidth - follow.xMargin))
        this.setY(clamp(player.y, follow.yMargin, view.worldHeight - follow.yMargin))
      }
      
      if (this.isLockedX) {
        this.lockX = Optional.is(this.lockX) 
          ? this.lockX 
          : (floor(view.x / view.width) * view.width) + 0.5 
        var xMin = (this.lockX + (view.width / 2.0)) - horizontal + follow.xMargin
        var xMax = (this.lockX + (view.width / 2.0)) + horizontal - follow.xMargin
        var xMinOffset = xMin < 0 ? abs(xMin) : 0.0
        var xMaxOffset = xMax > view.worldWidth ? xMax - view.worldWidth : 0.0
        xMin = clamp(xMin - xMaxOffset, 0.0, view.worldWidth)
        xMax = clamp(xMax + xMinOffset, 0.0, view.worldWidth)
        this.setX(clamp(this.x, xMin, xMax))
        this.snapH = clamp(this.lockX + xMinOffset - xMaxOffset, 0.0, view.worldWidth)
      } else {
        this.lockX = null
        this.snapH = floor(view.x / (view.width / 2.0)) * (view.width / 2.0)
      }
  
      if (this.isLockedY) {
        this.lockY = Optional.is(this.lockY) 
          ? this.lockY
          : floor(view.y / view.height) * view.height
        var yMin = (this.lockY + (view.height / 2.0)) - vertical + follow.yMargin
        var yMax = (this.lockY + (view.height / 2.0)) + vertical - follow.yMargin
        var yMinOffset = yMin < 0 ? abs(yMin) : 0.0
        var yMaxOffset = yMax > view.worldHeight ? yMax - view.worldHeight : 0.0
        yMin = clamp(yMin - yMaxOffset, 0.0, view.worldHeight)
        yMax = clamp(yMax + yMinOffset, 0.0, view.worldHeight)
        this.setY(clamp(this.y, yMin, yMax))
        this.snapV = clamp(this.lockY + yMinOffset - yMaxOffset, 0.0, view.worldHeight)
      } else {
        this.lockY = null
        this.snapV = floor(view.y / (view.height / 2.0)) * (view.height / 2.0)
      }

      if (isPlayer) {
        player.x = clamp(player.x, 0.0, view.worldWidth)
        player.y = clamp(player.y, 0.0, view.worldHeight)
      }

      view.setFollowTarget(this).update()

      return this
    },
    update: function(gridService) {
      return gridService.movement.enable
        ? this.updateMovement(gridService)
        : this.updateLock(gridService)
    },
  }

  ///@type {Struct}
  movement = {
    enable: false,
    angle: new NumberTransformer({
      value: 90.0,
      target: 1.0,
      duration: 148.333333,
      ease: EaseType.LINEAR,
    }),
    speed: new NumberTransformer({
      value: 0.0,
      target: 1.0,
      duration: 1.666667,
      ease: EaseType.LINEAR,
    }),
  }
  
  avgCircular = {
    buffer: IntStream.map(0, GAME_FPS, function(index, idx, value) {
      return value
    }, GAME_FPS),
    pointer: 0,
    value: GAME_FPS,
    add: function(value) {
      this.pointer += 1
      if (this.pointer >= this.buffer.size()) {
        this.pointer = 0
        this.value = round(this.get())
      }

      this.buffer.set(this.pointer, value)
      return this
    },
    reset: function() {
      this.buffer.forEach(function(value, index, buffer) {
        buffer.set(index, GAME_FPS)
      }, this.buffer)
      return this
    },
    get: function() {
      var sum = {
        value: 0,
        count: 0,
      }

      this.buffer.forEach(function(value, index, sum) {
        sum.value += value
        sum.count = max(sum.count, index + 1)
      }, sum)

      return sum.value / sum.count
    },
  }

  ///@type {Struct}
  avgTime = {
    value: 0,
    count: 0,
    add: function(value) {
      this.value += value
      this.count += 1
      return this
    },
    reset: function() {
      this.value = 0
      this.count = 0
      return this
    },
    get: function() {
      return this.value / this.count
    }
  }

  ///@type {Struct}
  textureGroups = {
    map: new Map(String, Number),
    getIndex: function(item) {
      var value = this.map.get(item.sprite.getName())
      if (value == null) {
        value = this.map.size()
        this.map.set(item.sprite.getName(), value)
      }

      return value
    },
    compareItems: function(a, b) {
      return this.getIndex(a) - this.getIndex(b)
    },
    sortItems: function(items) {
      items.setContainer(GMArray.sort(items.getContainer(), this.compareItems))
    },
  }
  
  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "transform-property": Callable.run(Struct.get(EVENT_DISPATCHERS, "transform-property")),
    "fade-sprite": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-sprite")),
    "fade-color": Callable.run(Struct.get(EVENT_DISPATCHERS, "fade-color")),
    "clear-grid": function(event) {
      this.view.x = (this.width - this.view.width) / 2.0
      this.view.y = this.height - this.view.height

      this.targetLocked.x = this.view.x + (this.view.width / 2.0)
      this.targetLocked.y = this.view.y + (this.view.height / 2.0)
      this.targetLocked.isLockedX = false
      this.targetLocked.isLockedY = false
      this.targetLocked.lockX = null
      this.targetLocked.lockY = null

      this.properties = new GridProperties(Struct.getIfType(this.config, "properties", Struct)).init(this)
    },
  }))

  ///@private
  ///@return {String}
  generateUID = function() {
    if (this.uidPointer >= MAX_INT_64 - 1) {
      Logger.warn("GridService", $"Reached maximum available value for uidPointer ('{MAX_INT_64}'). Reset uidPointer to '0'")
      this.uidPointer = int64(0)
    }
    this.uidPointer++
    return md5_string_utf8(string(this.uidPointer))
  }

  ///@type {String}
  hechan = choose("texture_hechan_3", "texture_hechan_4")

  ///@param {?Number} [duration]
  ///@return {GridService}
  init = function(duration = null) {
    var task = new Task("init-foreground")
      .setTimeout(10.0)
      .setState({
        duration: duration,
      })
      .whenUpdate(function(executor) {
        var controller = Beans.get(BeanVisuController)

        var lastX = null
        var lastY = null
        var scale = 1.0 + (random(1.0) * 0.25 * choose(1.0, -1.0))
        var angle = random(7.5) * choose(1.0, -1.0)
        var lastTask = controller.visuRenderer.gridRenderer.overlayRenderer.foregrounds.getLast()
        if (Core.isType(lastTask, Task) && Core.isType(lastTask.state, Map)) {
          lastX = lastTask.state.get("x") + (GuiWidth() * 0.1) + random(GuiWidth() * 0.3)
          lastY = lastTask.state.get("y")
          if (lastX > GuiWidth() * 1.125) {
            lastX -= (GuiWidth() * 0.85) + random(GuiWidth() * 0.5)
          }
          if (sign(lastY) >= 0) {
            lastY -= random(abs(lastY) + random(GuiHeight() / 3.0))
          } else {
            lastY += random(abs(lastY) + random(GuiHeight() / 3.0))
          }
        }

        controller.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse({
            name: "texture_hechan_3_abstract",
            alpha: 0.5,
            blend: GMArray.getRandom([
              "#FFFFFF",
              "#194ba8ff",
              "#1472c4ff",
              "#820745ff",
              "#383269ff",
            ]),
          }),
          collection: controller.visuRenderer.gridRenderer.overlayRenderer.backgrounds,
          type: WallpaperType.BACKGROUND,
          fadeInDuration: 2.0 + random(2.0),
          fadeOutDuration: 2.0 + random(2.0),
          angle: 90.0,
          speed: 1.33 + random(3.66),
          blendModeSource: BlendModeExt.SRC_ALPHA,
          blendModeTarget: BlendModeExt.ONE,
          blendEquation: BlendEquation.SUBTRACT,
          blendEquationAlpha: BlendEquation.ADD,
          executor: executor,
          tiled: true,
          replace: random(1.0) > 0.5,
          x: lastX,
          y: lastY,
          xScale: scale,
          yScale: scale,
        }))

        controller.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse({
            name: "texture_hechan_3_background",
            alpha: 0.75,
            //blend: "#FFFFFF",
            blend: GMArray.getRandom([
              "#FFFFFF",
              "#194ba8ff",
              "#1472c4ff",
              "#680f6bff",
              "#891769ff",
            ]),
          }),
          collection: controller.visuRenderer.gridRenderer.overlayRenderer.backgrounds,
          type: WallpaperType.BACKGROUND,
          fadeInDuration: 2.0 + random(2.0),
          fadeOutDuration: 2.0 + random(2.0),
          angle: 180.0 + angle,
          speed: 1.25 + (random(1.0) * 0.7),
          blendModeSource: BlendModeExt.SRC_ALPHA,
          blendModeTarget: BlendModeExt.ONE,
          blendEquation: BlendEquation.ADD,
          blendEquationAlpha: BlendEquation.ADD,
          executor: executor,
          tiled: true,
          replace: false,
          x: lastX,
          y: lastY,
          xScale: scale,
          yScale: scale,
        }))

        controller.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse({
            name: controller.gridService.hechan,
            alpha: 0.75 + random(1.0) * 0.25,
            blend: GMArray.getRandom([
              "#FFFFFF",
              "#56f68eff",
              "#929efbff",
              "#fc80fcff",
            ]),
          }),
          collection: controller.visuRenderer.gridRenderer.overlayRenderer.foregrounds,
          type: WallpaperType.FOREGROUND,
          fadeInDuration: 4.0 + random(2.0),
          fadeOutDuration: 4.0 + random(2.0),
          angle: angle,
          speed: 0.13 + random(0.66),
          blendModeSource: BlendModeExt.SRC_ALPHA,
          blendModeTarget: BlendModeExt.ONE,
          blendEquation: BlendEquation.ADD,
          blendEquationAlpha: BlendEquation.ADD,
          executor: executor,
          tiled: random(1.0) > 0.75,
          replace: random(1.0) > 0.5,
          lifespan: Struct.get(this.state, "duration"),
          x: lastX,
          y: lastY,
          xScale: scale,
          yScale: scale,
        }))

        controller.gridService.hechan = controller.gridService.hechan == "texture_hechan_3"
          ? "texture_hechan_4"
          : "texture_hechan_3"
        this.fullfill()
      })
    Beans.get(BeanVisuController).executor.add(task)
    
    return this
  }

    ///@param {?Number} [duration]
  ///@return {GridService}
  loadingScreen = function(duration = null) {
    var task = new Task("init-foreground")
      .setTimeout(10.0)
      .setState({
        duration: duration,
      })
      .whenUpdate(function(executor) {
        var controller = Beans.get(BeanVisuController)

        var lastX = null
        var lastY = null
        var scale = 1.0 + (random(1.0) * 0.25 * choose(1.0, -1.0))
        var angle = random(7.5) * choose(1.0, -1.0)
        var lastTask = controller.visuRenderer.gridRenderer.overlayRenderer.foregrounds.getLast()
        if (Core.isType(lastTask, Task) && Core.isType(lastTask.state, Map)) {
          lastX = lastTask.state.get("x") + (random(GuiWidth() / 2.0) * choose(1.0, 1.0, -1.0))
          lastY = lastTask.state.get("y")
          if (sign(lastY) >= 0) {
            lastY -= random(abs(lastY) + random(GuiHeight() / 3.0))
          } else {
            lastY += random(abs(lastY) + random(GuiHeight() / 3.0))
          }
        }

        controller.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse({
            name: "texture_hechan_3_abstract",
            alpha: 0.4,
            blend: GMArray.getRandom([
              "#FFFFFF",
              "#f0e92b",
              "#31944d",
              "#FFFFFF",
              "#b51943",
              "#3f056b",
              "#FFFFFF", 
              "#138774",
              "#f02b2b"
            ]),
          }),
          collection: controller.visuRenderer.gridRenderer.overlayRenderer.backgrounds,
          type: WallpaperType.BACKGROUND,
          fadeInDuration: 0.5 + random(0.25),
          fadeOutDuration: 0.5 + random(0.25),
          angle: 90.0,
          speed: 1.33 + random(3.66),
          blendModeSource: BlendModeExt.SRC_ALPHA,
          blendModeTarget: BlendModeExt.ONE,
          blendEquation: BlendEquation.SUBTRACT,
          blendEquationAlpha: BlendEquation.ADD,
          executor: executor,
          tiled: true,
          replace: random(1.0) > 0.5,
          x: lastX,
          y: lastY,
          xScale: scale,
          yScale: scale,
        }))
        //this.fullfill()
        //return null;
        controller.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse({
            name: "texture_hechan_3_background",
            alpha: 0.9,
            //blend: "#FFFFFF",
            blend: GMArray.getRandom([
              "#FFFFFF",
              "#2f0080",
              "#87135d",
              "#FFFFFF",
              "#134787",
              "#138774",
              "#FFFFFF", 
              "#138774",
              "#f02b2b"
            ]),
          }),
          collection: controller.visuRenderer.gridRenderer.overlayRenderer.backgrounds,
          type: WallpaperType.BACKGROUND,
          fadeInDuration: 0.5 + random(0.25),
          fadeOutDuration: 0.5 + random(0.25),
          angle: 180.0 + angle,
          speed: 1.25 + (random(1.0) * 0.7),
          blendModeSource: BlendModeExt.SRC_ALPHA,
          blendModeTarget: BlendModeExt.ONE,
          blendEquation: BlendEquation.ADD,
          blendEquationAlpha: BlendEquation.ADD,
          executor: executor,
          tiled: true,
          replace: false,
          x: lastX,
          y: lastY,
          xScale: scale,
          yScale: scale,
        }))

        controller.send(new Event("fade-sprite", {
          sprite: SpriteUtil.parse({
            name: "texture_hechan_3",
            alpha: 0.75 + random(1.0) * 0.25,
            blend: GMArray.getRandom([
              "#FFFFFF",
              "#ed6d9c",
              "#FFFFFF",
              "#887aff",
              "#FFFFFF",
              "#96facf",
              "#FFFFFF",
              "#fff875",
              "#FFFFFF", 
              "#edb8ff"
            ]),
          }),
          collection: controller.visuRenderer.gridRenderer.overlayRenderer.foregrounds,
          type: WallpaperType.FOREGROUND,
          fadeInDuration: 0.75 + random(0.5),
          fadeOutDuration: 0.75 + random(0.5),
          angle: angle,
          speed: 0.13 + random(0.66),
          blendModeSource: BlendModeExt.SRC_ALPHA,
          blendModeTarget: BlendModeExt.ONE,
          blendEquation: BlendEquation.ADD,
          blendEquationAlpha: BlendEquation.ADD,
          executor: executor,
          tiled: true,
          replace: random(1.0) > 0.75,
          lifespan: Struct.get(this.state, "duration"),
          x: lastX,
          y: lastY,
          xScale: scale,
          yScale: scale,
        }))
        this.fullfill()
      })
    Beans.get(BeanVisuController).executor.add(task)
    
    return this
  }

  ///@param {Bullet} bullet
  ///@param {Number} key
  ///@param {Struct} acc
  moveBullet = function(bullet, key, acc) {
    bullet.move()
    if (bullet.producer == Player) {
      acc.chunkService.update(bullet)
    }
    
    var view = acc.view
    var length = Math.fetchLength(
      bullet.x, bullet.y,
      view.x + (view.width / 2.0), 
      view.y + (view.height / 2.0)
    )

    if (length > GRID_ITEM_FRUSTUM_RANGE) {
      bullet.signal("kill")
    }
  }

  ///@param {Shroom} shroom
  ///@param {Number} key
  ///@param {Struct} acc
  moveShroom = function(shroom, key, acc) {
    shroom.move()
    acc.chunkService.update(shroom)
    
    var view = acc.view
    var length = Math.fetchLength(
      shroom.x, shroom.y,
      view.x + (view.width / 2.0), 
      view.y + (view.height / 2.0)
    )

    if (length > GRID_ITEM_FRUSTUM_RANGE) {
      shroom.signal("kill")
    }
  }

  ///@private
  ///@return {GridService}
  moveGridItems = function() {
    var controller = Beans.get(BeanVisuController)
    var view = controller.gridService.view
    controller.bulletService.bullets.forEach(this.moveBullet, {
      view: view,
      chunkService: controller.bulletService.chunkService,
    })

    controller.shroomService.shrooms.forEach(this.moveShroom, {
      view: view,
      chunkService: controller.shroomService.chunkService,
    })

    var player = controller.playerService.player
    if (Core.isType(player, Player)) {
      player.move()
    }
    return this
  }

  ///@param {Bullet} bullet
  ///@param {Number} index
  ///@param {VisuController} controller
  bulletCollision = function(bullet, index, controller) {
    static playerBullet = function(shroom, index, bullet) {
      if (shroom.collide(bullet)) {
        shroom.signal("bulletCollision", bullet)
        shroom.signal("damage", true)
        shroom.healthPoints = clamp(shroom.healthPoints - bullet.damage, 0, 9999.9)
        bullet.signal("shroomCollision", shroom)
      }
    }
    static shroomBullet = function(player, bullet) {
      if (bullet.fadeIn >= 1.0 && player.collide(bullet)) {
        player.signal("bulletCollision", bullet)
        bullet.signal("playerCollision", player)
      }
    }
    static playerLambda = function(key, index, acc) {
      acc.chunkService.get(key).forEach(acc.playerBullet, acc.bullet)
    }

    switch (bullet.producer) {
      case Player:
        bullet.chunkPosition.keys.forEach(playerLambda, {
          chunkService: controller.shroomService.chunkService,
          playerBullet: playerBullet,
          bullet: bullet,
        })
        //controller.shroomService.shrooms.forEach(playerBullet, bullet)
        break
      case Shroom:
        shroomBullet(controller.playerService.player, bullet)
        break
      default:
        Logger.warn("GridService", "Found invalid bullet producer")
        break
    }
  }

  ///@param {Bullet} bullet
  ///@param {Number} index
  ///@param {VisuController} controller
  bulletCollisionNoPlayer = function(bullet, index, controller) { }

  ///@param {Shroom} shroom
  ///@param {Number} index
  ///@param {Player} player
  shroomCollision = function(shroom, index, player) {
    if (shroom.fadeIn >= 1.0 && shroom.collide(player)) {
      player.signal("shroomCollision", shroom)
      shroom.signal("playerCollision", player)
      shroom.signal("damage", true)
      shroom.healthPoints = clamp(shroom.healthPoints - 1.0, 0, 9999.9)
    }
  }

  ///@param {Shroom} shroom
  ///@param {Number} index
  ///@param {Player} player
  shroomCollisionGodMode = function(shroom, index, player) {
    if (shroom.collide(player)) {
      shroom.signal("playerCollision", player)
      shroom.signal("kill")
    }
  }

  ///@param {Shroom} shroom
  ///@param {Number} index
  ///@param {?Player} player
  shroomCollisionNoPlayer = function(shroom, index, player) { }

  ///@private
  ///@return {GridService}
  signalGridItemsCollision = function() {
    var controller = Beans.get(BeanVisuController)
    var player = controller.playerService.player
    var isPlayer = Core.isType(player, Player)
  
    controller.bulletService.bullets.forEach(
      isPlayer
        ? this.bulletCollision
        : this.bulletCollisionNoPlayer,
      controller
    )
     
    controller.shroomService.shrooms.forEach(
      isPlayer
        ? (player.stats.godModeCooldown > 0.0 
          ? this.shroomCollisionGodMode 
          : this.shroomCollision)
        : this.shroomCollisionNoPlayer, 
      player
    )
    
    return this
  }

  ///@private
  ///@return {GridService}
  updateGridItems = function() {
    var controller = Beans.get(BeanVisuController)
    this.moveGridItems()
    this.signalGridItemsCollision()
    controller.playerService.update(this)
    controller.shroomService.update(this)
    controller.bulletService.update(this)
    return this
  }

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {GridService}
  update = function() {
    this.properties.update(this)
    this.dispatcher.update()
    this.executor.update()
    this.targetLocked.update(this)
    this.updateGridItems()
    
    return this
  }

  this.executor.add(new Task("init")
    .setTimeout(3.0)
    .whenUpdate(function(executor) {
      executor.context.init()
      this.fullfill()
    }))

  this.properties.init(this)
}


function PathTrack() constructor {

  ///@type {GMPath}
  path = test_path

  ///@type {Number}
  length = 0.0

  ///@type {Number}
  step = 0.5

  ///@type {Number}
  size = 1.0

  ///@type {Number}
  size2 = 1.0

  ///@type {?VertexBuffer}
  vertexBuffer = null

  ///@type {DebugNumericKeyboardValue}
  keyLength = new DebugNumericKeyboardValue({
    name: "length",
    value: this.length,
    factor: 0.2 * GAME_FPS,
    minValue: 0.0,
    keyIncrement: ord("T"),
    keyDecrement: ord("G"),
    pressed: true,
  })

  ///@type {DebugNumericKeyboardValue}
  keyStep = new DebugNumericKeyboardValue({
    name: "step",
    value: this.step,
    factor: 0.1,
    minValue: 0.016,
    keyIncrement: ord("Y"),
    keyDecrement: ord("H"),
    pressed: true,
  })

  
  ///@type {DebugNumericKeyboardValue}
  keySize = new DebugNumericKeyboardValue({
    name: "size",
    value: this.size,
    factor: 0.1,
    minValue: 0.1,
    keyIncrement: ord("U"),
    keyDecrement: ord("J"),
    pressed: true,
  })

  update = function() {
    var length = this.keyLength.update().value
    var step = this.keyStep.update().value
    var size = this.keySize.update().value
    if (this.length != length || this.step != step || this.size != size) {
      this.length = length
      this.step = step
      this.size = size
      this.build(this.length)
    }

    return this
  }

  build = function(length) {
    if (this.vertexBuffer != null) {
      this.vertexBuffer.free()
    }

    this.length = length
    this.keyLength.value = length
    var vertexes = new Array(DefaultVertex)
    var col1 = ColorUtil.parse("#f70925") // red
    var col2 = ColorUtil.parse("#74f709") // green
    var col3 = ColorUtil.parse("#3d09f7") // blue
    var col4 = ColorUtil.parse("#f2df10") // yellow
    var col5 = ColorUtil.parse("#f709d7") // fuchsia
    var col6 = ColorUtil.parse("#3bbbf7") // sea
    var width = GRID_SERVICE_PIXEL_WIDTH * this.size
    var height = GRID_SERVICE_PIXEL_HEIGHT * this.size
    for (var index = 0; index < this.length; index += this.step) {
      var current = index / this.length
      var currentX = round(path_get_x(this.path, current) * GRID_SERVICE_PIXEL_WIDTH)
      var currentY = round(path_get_y(this.path, current) * GRID_SERVICE_PIXEL_HEIGHT)
      var currentZ = round(path_get_speed(this.path, current))

      var next = (index + this.step) / this.length
      var nextX = round(path_get_x(this.path, next) * GRID_SERVICE_PIXEL_WIDTH)
      var nextY = round(path_get_y(this.path, next) * GRID_SERVICE_PIXEL_HEIGHT)
      var nextZ = round(path_get_speed(this.path, next))

      var next2 = (index + this.step + this.step) / this.length
      var next2X = round(path_get_x(this.path, next2) * GRID_SERVICE_PIXEL_WIDTH)
      var next2Y = round(path_get_y(this.path, next2) * GRID_SERVICE_PIXEL_HEIGHT)
      var next2Z = round(path_get_speed(this.path, next2))

      next2Z = nextZ
      nextZ = round((currentZ + next2Z) / 2.0)

      var angle = Math.fetchPointsAngle(currentX, currentY, nextX, nextY)
      var angle2 = Math.fetchPointsAngle(nextX, nextY, next2X, next2Y)

      var v1x = currentX
      var v1y = currentY
      var v2x = v1x - Math.fetchCircleX(width, Math.normalizeAngle(angle + 180.0))
      var v2y = v1y - Math.fetchCircleY(height, Math.normalizeAngle(angle + 180.0))
      var v3x = v2x - Math.fetchCircleX(width, Math.normalizeAngle(angle + 90.0))
      var v3y = v2y - Math.fetchCircleY(height, Math.normalizeAngle(angle + 90.0))
      var v4x = nextX
      var v4y = nextY
      var v5x = v4x - Math.fetchCircleX(width, Math.normalizeAngle(angle2 + 180.0))
      var v5y = v4y - Math.fetchCircleY(height, Math.normalizeAngle(angle2 + 180.0))
      var v6x = v5x - Math.fetchCircleX(width, Math.normalizeAngle(angle2 + 90.0))
      var v6y = v5y - Math.fetchCircleY(height, Math.normalizeAngle(angle2 + 90.0))

      //vertexes
      //  .add(new DefaultVertex(v1x, v1y, currentZ, 0, 0, 1, 0, 0, col1, 1.0))
      //  .add(new DefaultVertex(v2x, v2y, currentZ, 0, 0, 1, 1, 0, col1, 1.0)) //col2
      //  .add(new DefaultVertex(v3x, v3y, currentZ, 0, 0, 1, 1, 1, col3, 1.0))
      //  .add(new DefaultVertex(v4x, v4y, next2Z, 0, 0, 1, 1, 1, col1, 1.0))
      //  .add(new DefaultVertex(v3x, v3y, currentZ, 0, 0, 1, 1, 0, col3, 1.0))
      //  .add(new DefaultVertex(v2x, v2y, currentZ, 0, 0, 1, 0, 0, col1, 1.0)) //col2
      //  .add(new DefaultVertex(v3x, v3y, currentZ, 0, 0, 1, 1, 1, col3, 1.0))
      //  .add(new DefaultVertex(v4x, v4y, next2Z, 0, 0, 1, 1, 0, col1, 1.0))
      //  .add(new DefaultVertex(v6x, v6y, next2Z, 0, 0, 1, 0, 0, col3, 1.0))

      vertexes
        .add(new DefaultVertex(v1x, v1y, currentZ,  0, 0, 1,  0, 0, col1, 1.0))
        .add(new DefaultVertex(v2x, v2y, currentZ,  0, 0, 1,  1, 0, col2, 1.0)) //col1
        .add(new DefaultVertex(v3x, v3y, currentZ,  0, 0, 1,  1, 1, col3, 1.0))
        .add(new DefaultVertex(v4x, v4y, next2Z,    0, 0, 1,  1, 1, col1, 1.0))
        .add(new DefaultVertex(v3x, v3y, currentZ,  0, 0, 1,  1, 0, col3, 1.0))
        .add(new DefaultVertex(v2x, v2y, currentZ,  0, 0, 1,  0, 0, col2, 1.0)) //col1
        .add(new DefaultVertex(v3x, v3y, currentZ,  0, 0, 1,  1, 1, col3, 1.0))
        .add(new DefaultVertex(v4x, v4y, next2Z,    0, 0, 1,  1, 0, col1, 1.0))
        .add(new DefaultVertex(v6x, v6y, next2Z,    0, 0, 1,  0, 0, col3, 1.0))
        .add(new DefaultVertex(v2x, v2y, currentZ,  0, 0, 1,  0, 0, col2, 1.0))
        .add(new DefaultVertex(v5x, v5y, next2Z,    0, 0, 1,  1, 0, col2, 1.0))
        .add(new DefaultVertex(v4x, v4y, next2Z,    0, 0, 1,  1, 1, col1, 1.0))
    }

    this.vertexBuffer = new DefaultVertexBuffer(vertexes).build()
    return this
  }
}