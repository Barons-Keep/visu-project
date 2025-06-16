///@package com.alkapivo.visu.renderer.grid

function GridRenderer() constructor {

  ///@type {GridOverlayRenderer}
  overlayRenderer = new GridOverlayRenderer(this)

  ///@type {GridCamera}
  camera = new GridCamera()

  ///@type {Color}
  playerShadowColor = new Color(1.0, 1.0, 1.0)

  ///@private
  ///@type {Surface}
  backgroundSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@private
  ///@type {Surface}
  gridSurface = new Surface({ width: GuiWidth(), height: GuiHeight(), depth: false })

  ///@private
  ///@type {Surface}
  focusGridSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@private
  ///@type {Surface}
  gameSurface = new Surface({ width: GuiWidth(), height: GuiHeight() })

  ///@private
  ///@type {Surface}
  shaderSurface = new Surface({ 
    width: ceil(GuiWidth() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)), 
    height: ceil(GuiHeight() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)),
  })

  ///@private
  ///@type {Surface}
  shaderBackgroundSurface = new Surface({ 
    width: ceil(GuiWidth() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)), 
    height: ceil(GuiHeight() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)),
  })
  
  ///@private
  ///@type {Surface}
  shaderCombinedSurface = new Surface({ 
    width: ceil(GuiWidth() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)), 
    height: ceil(GuiHeight() / Visu.settings.getValue("visu.graphics.shader-quality", 1.0)),
  })

  ///@private
  ///@type {BKTGlitchService}
  backgroundGlitchService = new BKTGlitchService()

  ///@private
  ///@type {BKTGlitchService}
  gridGlitchService = new BKTGlitchService()

  ///@private
  ///@type {BKTGlitchService}
  combinedGlitchService = new BKTGlitchService()

  ///@private
  ///@type {Timer}
  ///@description Z demo
  playerZTimer = new Timer(pi * 2, { loop: Infinity }) 

  ///@private
  ///@type {Struct}
  player2DCoords = { x: 0, y: 0 }

  ///@private
  ///@type {Sprite}
  playerHintPointer = Assert.isType(SpriteUtil.parse({ name: "texture_bullet" }), Sprite)

  ///@private
  ///@type {Font}
  playerHintFont = Assert.isType(FontUtil.parse({ name: "font_inter_24_regular" }), Font)

  ///@private
  ///@param {Texture}
  textureLine = new Texture(texture_grid_line_alpha)

  ///@private
  ///@param {Texture}
  textureLineSpawners = new Texture(texture_grid_line_default)

  ///@private
  ///@type {?Number}
  channelXStart = null

  ///@private
  ///@type {Struct}
  blendModes = {
    source: BlendModeExt.ZERO,
    target: BlendModeExt.ZERO,
    equation: BlendEquation.ADD,
    blendModesExt: BlendModeExt.keys(),
    blendEquation: BlendEquation.keys(),
    sourceKey: new DebugNumericKeyboardValue({
      name: "sourceKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 10,
      keyIncrement: ord("T"),
      keyDecrement: ord("G"),
      pressed: true,
    }),
    targetKey: new DebugNumericKeyboardValue({
      name: "targetKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 10,
      keyIncrement: ord("Y"),
      keyDecrement: ord("H"),
      pressed: true,
    }),
    equationKey: new DebugNumericKeyboardValue({
      name: "equationKey",
      value: 0,
      factor: 1,
      minValue: 0,
      maxValue: 4,
      keyIncrement: ord("U"),
      keyDecrement: ord("J"),
      pressed: true,
    }),
    update: function() {
      var sourceIndex = this.sourceKey.update().value
      var targetIndex = this.targetKey.update().value
      var equationIndex = this.equationKey.update().value

      var source = BlendModeExt.get(this.blendModesExt.get(sourceIndex))
      var target = BlendModeExt.get(this.blendModesExt.get(targetIndex))
      var equation = BlendEquation.get(this.blendEquation.get(equationIndex))

      if (source != this.source 
          || target != this.target 
          || equation != this.equation) {
        Core.print(
          $"# {irandom(99) + 99}|", 
          "Source:", this.blendModesExt.get(sourceIndex), 
          "Target:", this.blendModesExt.get(targetIndex), 
          "Equation:", this.blendEquation.get(equationIndex)
        )
      }

      this.source = source
      this.target = target
      this.equation = equation
      /*
      GPU.set.blendModeExt(this.blendModes.source, this.blendModes.target)
      GPU.set.blendEquation(this.blendModes.equation)

      GPU.reset.blendMode()
      GPU.reset.blendEquation()
      */
    }
  }

  ///@type {?PathTrack}
  pathTrack = null;//new PathTrack().build(3.0 * GAME_FPS)

  ///@private
  ///@return {GridRenderer}
  init = function() {
    application_surface_enable(false)
    application_surface_draw_enable(false)
    
    gpu_set_ztestenable(false)
    gpu_set_zwriteenable(false)
    gpu_set_zfunc(cmpfunc_lessequal)
    gpu_set_alphatestenable(false)
    gpu_set_alphatestref(0)
    //gpu_set_ztestenable(true)
    //gpu_set_zwriteenable(true)
    //gpu_set_zfunc(cmpfunc_lessequal)
    //gpu_set_alphatestenable(true)
    //gpu_set_alphatestref(0)
    gpu_set_cullmode(cull_counterclockwise)

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {PlayerService} playerService
  ///@param {Number} baseX
  ///@param {Number} baseY
  ///@return {GridRenderer}
  debugRenderPlayer = function(gridService, playerService, baseX, baseY) { 
    var player = playerService.player
    if (!gridService.properties.renderPlayer
      || !Core.isType(player, Player)) {
      this.player2DCoords.x = null
      this.player2DCoords.y = null
      return this
    }

    var useBlendAsZ = false
    if (useBlendAsZ) {
      var _x = (player.x - (player.sprite.texture.width / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH
      var _y = (player.y - (player.sprite.texture.height / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT)  - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var blend = player.sprite.getBlend()
      var alpha = player.sprite.getAlpha()
      var angle = player.sprite.getAngle()
      shader_set(shader_gml_use_blend_as_z)
      shader_set_uniform_f(shader_get_uniform(shader_gml_use_blend_as_z, "size"), 1024.0)
        player.sprite
          .setBlend((sin(this.playerZTimer.update().time) * 0.5 + 0.5) * 255)
          .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0))
          .setAngle(angle - 90)
          .render(_x, _y)
          .setBlend(blend)
          .setAlpha(alpha)
          .setAngle(angle)
        
        GPU.render.rectangle(
          (player.x - ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (player.y - ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          (player.x + ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (player.y + ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
          false, 
          c_lime
        )
      shader_reset()
    } else {
      var _x = (player.x - ((player.sprite.texture.width * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
      var _y = (player.y - ((player.sprite.texture.height * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var alpha = player.sprite.getAlpha()
      var angle = player.sprite.getAngle()
      player.sprite
        .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0))
        .setAngle(angle - 90.0)
        .render(_x, _y)
        .setAlpha(alpha)
        .setAngle(angle)
      this.player2DCoords = Math.project3DCoordsOn2D(_x + baseX, _y + baseY, gridService.properties.depths.playerZ, this.camera.viewMatrix, this.camera.projectionMatrix, this.gridSurface.width, this.gridSurface.height)
      
      GPU.render.rectangle(
        (player.x - ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (player.y - ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (player.x + ((player.mask.getWidth() * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (player.y + ((player.mask.getHeight() * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_lime
      )
      
    }
    
    return this
  }
  
  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  debugRenderShrooms = function(gridService, shroomService) {
    static debugRenderShroom = function(shroom, index, gridService) {
      var alpha = shroom.sprite.getAlpha()
      shroom.sprite
        .setAlpha(alpha * shroom.fadeIn)
        .render(
          (shroom.x - ((shroom.sprite.texture.width * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((shroom.sprite.texture.offsetX * shroom.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (shroom.y - ((shroom.sprite.texture.height * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((shroom.sprite.texture.offsetY * shroom.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
        .setAlpha(alpha)
    }
    static debugRenderShroomMask = function(shroom, index, gridService) {
      GPU.render.rectangle(
        (shroom.x - ((shroom.mask.getWidth() * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (shroom.y - ((shroom.mask.getHeight() * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (shroom.x + ((shroom.mask.getWidth() * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (shroom.y + ((shroom.mask.getHeight() * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_red
      )
    }

    if (!gridService.properties.renderElements 
      || !gridService.properties.renderShrooms) {
      return this
    }

    shroomService.shrooms.forEach(debugRenderShroom, gridService)
    shroomService.shrooms.forEach(debugRenderShroomMask, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  debugRenderBullets = function(gridService, bulletService) {
    static debugRenderBullet = function(bullet, index, gridService) {
      bullet.sprite
        .setAngle(bullet.angle)
        .render(
          (bullet.x - ((bullet.sprite.texture.width * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((bullet.sprite.texture.offsetX * bullet.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (bullet.y - ((bullet.sprite.texture.height * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((bullet.sprite.texture.offsetY * bullet.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
    }
    static debugRenderBulletMask = function(bullet, index, gridService) {
      GPU.render.rectangle(
        (bullet.x - ((bullet.mask.getWidth() * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (bullet.y - ((bullet.mask.getHeight() * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (bullet.x + ((bullet.mask.getWidth() * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (bullet.y + ((bullet.mask.getHeight() * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_blue
      )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderBullets) {
      return this
    }

    bulletService.bullets.forEach(debugRenderBullet, gridService)
    bulletService.bullets.forEach(debugRenderBulletMask, gridService)
    return this
  }

  //@private
  ///@param {GridService} gridService
  ///@param {CoinService} coinService
  ///@return {GridRenderer}
  debugRenderCoins = function(gridService, coinService) {
    static debugRenderCoin = function(coin, index, gridService) {
      coin.sprite.render(
        (coin.x - ((coin.sprite.texture.width * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((coin.sprite.texture.offsetX * coin.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (coin.y - ((coin.sprite.texture.height * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((coin.sprite.texture.offsetY * coin.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      )
    }
    static debugRenderCoinMask = function(coin, index, gridService) {
      GPU.render.rectangle(
        (coin.x - ((coin.mask.getWidth() * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (coin.y - ((coin.mask.getHeight() * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        (coin.x + ((coin.mask.getWidth() * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
        (coin.y + ((coin.mask.getHeight() * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT,
        false, 
        c_orange
      )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderCoins) {
      return this
    }

    coinService.coins.forEach(debugRenderCoin, gridService)
    coinService.coins.forEach(debugRenderCoinMask, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {ShroomService} shroomService
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  editorRenderSpawners = function(gridService, shroomService, layout) {
    var spawner = shroomService.spawner
    if (Core.isType(spawner, Struct)) {
      spawner.sprite.render(
        spawner.x * GRID_SERVICE_PIXEL_WIDTH, 
        spawner.y * GRID_SERVICE_PIXEL_HEIGHT
      )

      shroomService.spawner.timeout--
      if (shroomService.spawner.timeout <= 0) {
        shroomService.spawner = null
      }
    }

    var spawnerEvent = shroomService.spawnerEvent
    if (Core.isType(spawnerEvent, Struct)) {
      spawnerEvent.sprite.render(
        spawnerEvent.x * GRID_SERVICE_PIXEL_WIDTH,
        spawnerEvent.y * GRID_SERVICE_PIXEL_HEIGHT
      )

      shroomService.spawnerEvent.timeout--
      if (shroomService.spawnerEvent.timeout <= 0) {
        shroomService.spawnerEvent = null
      }
    }

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {ShroomService} shroomService
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  editorRenderParticleArea = function(gridService, shroomService, layout) {
    var lineThickness = 5.0
    var lineAlpha = 0.8
    var backgroundAlpha = 0.6
    var colorBrush = c_fuchsia
    var colorEvent = c_blue
    var particleArea = shroomService.particleArea
    if (Core.isType(particleArea, Struct)) {
      GPU.render.rectangle(
        particleArea.topLeft.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleArea.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleArea.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
        false, colorBrush, colorBrush, colorBrush, colorBrush, backgroundAlpha
      )

      GPU.render.texturedLine(
        particleArea.topLeft.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleArea.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleArea.topRight.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleArea.topRight.y * GRID_SERVICE_PIXEL_HEIGHT, 
        lineThickness, lineAlpha, colorBrush
      )

      GPU.render.texturedLine(
        particleArea.topRight.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleArea.topRight.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleArea.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
        lineThickness, lineAlpha, colorBrush
      )

      GPU.render.texturedLine(
        particleArea.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
        particleArea.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
        lineThickness, lineAlpha, colorBrush
      )

      GPU.render.texturedLine(
        particleArea.topLeft.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleArea.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleArea.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleArea.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
        lineThickness, lineAlpha, colorBrush
      )

      shroomService.particleArea.timeout--
      if (shroomService.particleArea.timeout <= 0) {
        shroomService.particleArea = null
      }
    }

    var particleAreaEvent = shroomService.particleAreaEvent
    if (Core.isType(particleAreaEvent, Struct)) {
      GPU.render.rectangle(
        particleAreaEvent.topLeft.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleAreaEvent.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleAreaEvent.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
        false, colorEvent, colorEvent, colorEvent, colorEvent, backgroundAlpha
      )

      GPU.render.texturedLine(
        particleAreaEvent.topLeft.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleAreaEvent.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleAreaEvent.topRight.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleAreaEvent.topRight.y * GRID_SERVICE_PIXEL_HEIGHT, 
        lineThickness, lineAlpha, colorEvent
      )

      GPU.render.texturedLine(
        particleAreaEvent.topRight.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleAreaEvent.topRight.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleAreaEvent.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
        lineThickness, lineAlpha, colorEvent
      )

      GPU.render.texturedLine(
        particleAreaEvent.bottomRight.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.bottomRight.y * GRID_SERVICE_PIXEL_HEIGHT,
        particleAreaEvent.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
        lineThickness, lineAlpha, colorEvent
      )

      GPU.render.texturedLine(
        particleAreaEvent.topLeft.x * GRID_SERVICE_PIXEL_WIDTH, 
        particleAreaEvent.topLeft.y * GRID_SERVICE_PIXEL_HEIGHT, 
        particleAreaEvent.bottomLeft.x * GRID_SERVICE_PIXEL_WIDTH,
        particleAreaEvent.bottomLeft.y * GRID_SERVICE_PIXEL_HEIGHT,
        lineThickness, lineAlpha, colorEvent
      )

      shroomService.particleAreaEvent.timeout--
      if (shroomService.particleAreaEvent.timeout <= 0) {
        shroomService.particleAreaEvent = null
      }
    }

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {ShroomService} shroomService
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  editorRenderSubtitlesArea = function(gridService, shroomService, layout) {
    var _x = layout.x()
    var _y = layout.y()
    var width = layout.width()
    var height = layout.height()
    var subtitlesArea = shroomService.subtitlesArea
    if (Core.isType(subtitlesArea, Struct)) {
      GPU.render.rectangle(
        _x + subtitlesArea.topLeft.x * width, 
        _y + subtitlesArea.topLeft.y * height, 
        _x + subtitlesArea.bottomRight.x * width,
        _y + subtitlesArea.bottomRight.y * height,
        false, c_lime, c_lime, c_lime, c_lime, 0.33
      )

      GPU.render.texturedLine(
        _x + subtitlesArea.topLeft.x * width, 
        _y + subtitlesArea.topLeft.y * height, 
        _x + subtitlesArea.topRight.x * width, 
        _y + subtitlesArea.topRight.y * height, 
        4.0, 0.66, c_lime
      )

      GPU.render.texturedLine(
        _x + subtitlesArea.topRight.x * width, 
        _y + subtitlesArea.topRight.y * height, 
        _x + subtitlesArea.bottomRight.x * width,
        _y + subtitlesArea.bottomRight.y * height,
        4.0, 0.66, c_lime
      )

      GPU.render.texturedLine(
        _x + subtitlesArea.bottomRight.x * width,
        _y + subtitlesArea.bottomRight.y * height,
        _x + subtitlesArea.bottomLeft.x * width,
        _y + subtitlesArea.bottomLeft.y * height,
        4.0, 0.66, c_lime
      )

      GPU.render.texturedLine(
        _x + subtitlesArea.topLeft.x * width, 
        _y + subtitlesArea.topLeft.y * height, 
        _x + subtitlesArea.bottomLeft.x * width,
        _y + subtitlesArea.bottomLeft.y * height,
        4.0, 0.66, c_lime
      )

      shroomService.subtitlesArea.timeout--
      if (shroomService.subtitlesArea.timeout <= 0) {
        shroomService.subtitlesArea = null
      }
    }

    var subtitlesAreaEvent = shroomService.subtitlesAreaEvent
    if (Core.isType(subtitlesAreaEvent, Struct)) {
      GPU.render.rectangle(
        _x + subtitlesAreaEvent.topLeft.x * width, 
        _y + subtitlesAreaEvent.topLeft.y * height, 
        _x + subtitlesAreaEvent.bottomRight.x * width,
        _y + subtitlesAreaEvent.bottomRight.y * height,
        false, c_red, c_red, c_red, c_red, 0.33
      )

      GPU.render.texturedLine(
        _x + subtitlesAreaEvent.topLeft.x * width, 
        _y + subtitlesAreaEvent.topLeft.y * height, 
        _x + subtitlesAreaEvent.topRight.x * width, 
        _y + subtitlesAreaEvent.topRight.y * height, 
        4.0, 0.66, c_red
      )

      GPU.render.texturedLine(
        _x + subtitlesAreaEvent.topRight.x * width, 
        _y + subtitlesAreaEvent.topRight.y * height, 
        _x + subtitlesAreaEvent.bottomRight.x * width,
        _y + subtitlesAreaEvent.bottomRight.y * height,
        4.0, 0.66, c_red
      )

      GPU.render.texturedLine(
        _x + subtitlesAreaEvent.bottomRight.x * width,
        _y + subtitlesAreaEvent.bottomRight.y * height,
        _x + subtitlesAreaEvent.bottomLeft.x * width,
        _y + subtitlesAreaEvent.bottomLeft.y * height,
        4.0, 0.66, c_red
      )

      GPU.render.texturedLine(
        _x + subtitlesAreaEvent.topLeft.x * width, 
        _y + subtitlesAreaEvent.topLeft.y * height, 
        _x + subtitlesAreaEvent.bottomLeft.x * width,
        _y + subtitlesAreaEvent.bottomLeft.y * height,
        4.0, 0.66, c_red
      )

      shroomService.subtitlesAreaEvent.timeout--
      if (shroomService.subtitlesAreaEvent.timeout <= 0) {
        shroomService.subtitlesAreaEvent = null
      }
    }

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@return {GridRenderer}
  gridRenderSeparators = function(gridService) {
    var properties = gridService.properties
    var view = gridService.view
    if (!properties.renderGrid) || (properties.separators <= 0) {
      return this
    }

    var separators = properties.separators
    var primaryColor = properties.separatorsPrimaryColor.toGMColor()
    var primaryAlpha = properties.separatorsPrimaryAlpha
    var primaryThickness = properties.separatorsPrimaryThickness
    var secondaryColor = properties.separatorsSecondaryColor.toGMColor()
    var secondaryAlpha = properties.separatorsSecondaryAlpha
    var secondaryThickness = gridService.properties.separatorsSecondaryThickness
    var separatorHeight = (view.height * 2) / separators
    var time = gridService.properties.separatorTimer.time
    var offset = 2.0
    var separatorsSize = separators * 3
    var secondaryTreshold = separatorsSize / 3
    var duration = gridService.properties.separatorTimer.duration
    var borderRatio = clamp(1.0 - (time / duration), 0.0, 1.0)
    var size = floor(separatorsSize)
    var primaryBegin = round(secondaryTreshold)
    var primaryEnd = round(size - secondaryTreshold)
    var mode = gridService.properties.separatorsMode
    switch (mode) {
      case "SINGLE":
        for (var index = -1 * primaryBegin; index < size; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6.0 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          var _alpha = index < 0.0 ? ((primaryBegin - abs(index)) / primaryBegin) * primaryAlpha : primaryAlpha
          _alpha = index > primaryEnd ? (size - index) / (size - primaryEnd) * primaryAlpha : _alpha
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            primaryThickness,
            _alpha, 
            primaryColor,
            this.textureLine
          )
        }
        break
      case "DUAL":
        for (var index = -1 * primaryBegin; index <= primaryBegin; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6.0 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          var _alpha = index == (-1 * primaryBegin) ? secondaryAlpha * (1.0 - borderRatio) : secondaryAlpha
          if (index + 1 > primaryBegin) {
            _alpha = secondaryAlpha * borderRatio
          } else if (index < 0.0) {
            _alpha = ((primaryBegin - abs(index)) / primaryBegin) * _alpha
          }
    
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            secondaryThickness, 
            _alpha, 
            secondaryColor,
            this.textureLine
          )
        }
    
        for (var index = primaryEnd; index <= size; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          var _alpha = index == primaryEnd ? secondaryAlpha * (1.0 - borderRatio) : secondaryAlpha
          if (index + 1 > size) {
            _alpha = secondaryAlpha * borderRatio
          }
    
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            secondaryThickness, 
            _alpha, 
            secondaryColor,
            this.textureLine
          )
        }
    
        for (var index = primaryBegin; index <= primaryEnd; index++) {
          var beginX = -4.0 * GRID_SERVICE_PIXEL_WIDTH
          var beginY = ((-6 * view.height) + (index * separatorHeight) + offset + time) * GRID_SERVICE_PIXEL_HEIGHT
          var endX = (view.width + 4.0) * GRID_SERVICE_PIXEL_WIDTH
          var endY = beginY
          //var alpha = index == primaryBegin ? primaryAlpha * (1.0 - borderRatio) : primaryAlpha
          //if (index + 1 > primaryEnd) {
          //  alpha = primaryAlpha * borderRatio
          //}
          var alpha = primaryAlpha
    
          var thickness = index == primaryBegin ? primaryThickness * (1.0 - borderRatio) : primaryThickness
          if (index + 1 > primaryEnd) {
            thickness = primaryThickness * borderRatio
          }
    
          GPU.render.texturedLineSimple(
            beginX, beginY, 
            endX, endY, 
            thickness,//max(thickness, secondaryThickness), 
            alpha, 
            primaryColor,
            this.textureLine
          )
        }
        break
    }
   
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@return {GridRenderer}
  gridRenderChannels = function(gridService) {
    var properties = gridService.properties
    if (!gridService.properties.renderGrid || properties.channels <= 0) {
      return this
    }

    var primaryColor = properties.channelsPrimaryColor.toGMColor()
    var primaryAlpha = properties.channelsPrimaryAlpha
    var primaryThickness = properties.channelsPrimaryThickness
    var secondaryColor = properties.channelsSecondaryColor.toGMColor()
    var secondaryAlpha = properties.channelsSecondaryAlpha
    var secondaryThickness = properties.channelsSecondaryThickness
    var mode = properties.channelsMode
    
    var view = gridService.view
    var viewX = view.x
    var viewWidth = view.width
    var viewHeight = view.height
    var channels = properties.channels
    var channelPxWidth = (viewWidth / channels) * GRID_SERVICE_PIXEL_WIDTH
    var viewBorder = 5
    var viewCurrent = floor(viewX / viewWidth)
    var viewXOffset = viewX - viewCurrent
    var viewXStart = (viewCurrent - viewBorder) * GRID_SERVICE_PIXEL_WIDTH
    var viewXFinish = (viewCurrent + 2.0 + viewBorder) * GRID_SERVICE_PIXEL_WIDTH
    if (this.channelXStart == null) {
      this.channelXStart = viewXStart
    } else {
      if (viewXStart < this.channelXStart) {
        this.channelXStart = this.channelXStart - (channelPxWidth * ((this.channelXStart - viewXStart) div channelPxWidth))
      } else if (viewXStart > this.channelXStart) {
        this.channelXStart = this.channelXStart + (channelPxWidth * ((viewXStart - this.channelXStart) div channelPxWidth))
      }
      viewXStart = this.channelXStart
    }

    var size = (viewXFinish - viewXStart) div channelPxWidth
    var offset = floor(viewX * GRID_SERVICE_PIXEL_WIDTH) - this.channelXStart
    var indexLeft = floor((floor(viewX * GRID_SERVICE_PIXEL_WIDTH) - this.channelXStart) / channelPxWidth)
    var indexFactor = ((floor(viewX * GRID_SERVICE_PIXEL_WIDTH) - this.channelXStart) / channelPxWidth) - indexLeft
    var indexRight = indexLeft + floor(channels)
    var indexMiddle = indexLeft + floor(abs(indexRight - indexLeft) / 2.0)
    switch (mode) {
      case "SINGLE":
        for (var index = 0; index <= size; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index <= indexLeft) {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha * clamp((index - (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), primaryColor, this.textureLine)
          } else if (index > indexRight) {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha * clamp((size - index + (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), primaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha, primaryColor, this.textureLine)
          }
        }
        break
      case "DUAL":
        for (var index = 0; index <= indexLeft; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexLeft) {
            var factor = 1.0 - indexFactor
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * (1.0 - factor), secondaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * clamp((index - (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), secondaryColor, this.textureLine)
          }
        }
        
        for (var index = indexRight; index <= size; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexRight) {
            var factor = indexFactor
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * (1.0 - factor), secondaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, secondaryThickness, secondaryAlpha * clamp((size - index + (channels * viewXOffset)) / (channels * viewBorder), 0.0, 1.0), secondaryColor, this.textureLine)
          }
        }
    
        for (var index = indexLeft; index < indexMiddle; index++) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexLeft && indexLeft != indexRight) {
            var factor = 1.0 - indexFactor
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else if (index == indexRight) {
            var factor = indexFactor
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha, primaryColor, this.textureLine)
          }
        }
    
        for (var index = indexRight; index >= indexMiddle; index--) {
          var beginX = this.channelXStart + (index * channelPxWidth) - (viewX * GRID_SERVICE_PIXEL_WIDTH)
          var beginY = -6.0 * GRID_SERVICE_PIXEL_HEIGHT
          var endX = beginX
          var endY = (viewHeight + 6.0) * GRID_SERVICE_PIXEL_HEIGHT
          if (index == indexLeft && indexLeft != indexRight) {
            var factor = 1.0 - indexFactor
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else if (index == indexRight) {
            var factor = indexFactor
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness * factor, primaryAlpha, primaryColor, this.textureLine)
          } else {
            GPU.render.texturedLineSimple(beginX, beginY, endX, endY, primaryThickness, primaryAlpha, primaryColor, this.textureLine)
          }
        }
        break
    }

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@return {GridRenderer}
  gridRenderBorders = function(gridService) {
    static renderTop = function(gridService) {
      var locked = gridService.targetLocked
      var isLockedY = locked.isLockedY
      var lockY = locked.lockY
      if (!isLockedY || !Optional.is(lockY)) {
        return
      }

      var view = gridService.view
      var vertical = gridService.properties.borderVerticalLength / 2.0
      var yMin = (lockY + (view.height / 2.0)) - vertical
      var yMax = (lockY + (view.height / 2.0)) + vertical
      var yMinOffset = yMin < 0 ? abs(yMin) : 0.0
      var yMaxOffset = yMax > view.worldHeight ? yMax - view.worldHeight : 0.0
      yMin = clamp(yMin - yMaxOffset, 0.0, view.worldHeight)
      yMax = clamp(yMax + yMinOffset, 0.0, view.worldHeight)

      var beginX = -3.0 * GRID_SERVICE_PIXEL_WIDTH
      var beginY = (clamp(yMin, 0.0, view.worldHeight) - view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var endX = (3.0 + view.width) * GRID_SERVICE_PIXEL_WIDTH
      var endY = beginY

      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderVerticalThickness, 
        gridService.properties.borderVerticalAlpha,
        gridService.properties.borderVerticalColor.toGMColor(),
        this.textureLine
      )
    }

    static renderBottom = function(gridService) {
      var locked = gridService.targetLocked
      var isLockedY = locked.isLockedY
      var lockY = locked.lockY

      var view = gridService.view
      var vertical = gridService.properties.borderVerticalLength / 2.0
      var yMin = isLockedY && Optional.is(lockY) ? (lockY + (view.height / 2.0)) - vertical : 0.0
      var yMax = isLockedY && Optional.is(lockY) ? (lockY + (view.height / 2.0)) + vertical : 0.0
      var yMinOffset = yMin < 0 ? abs(yMin) : 0.0
      var yMaxOffset = yMax > view.worldHeight ? yMax - view.worldHeight : 0.0
      yMin = clamp(yMin - yMaxOffset, 0.0, view.worldHeight)
      yMax = clamp(yMax + yMinOffset, 0.0, view.worldHeight)

      var beginX = -3.0 * GRID_SERVICE_PIXEL_WIDTH
      var beginY = isLockedY && Optional.is(lockY)
        ? (yMax - view.y) * GRID_SERVICE_PIXEL_HEIGHT
        : clamp((view.worldHeight - view.y), 0.0, view.worldHeight) * GRID_SERVICE_PIXEL_HEIGHT
      var endX = (3.0 + view.width) * GRID_SERVICE_PIXEL_WIDTH
      var endY = beginY

      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderVerticalThickness, 
        gridService.properties.borderVerticalAlpha,
        gridService.properties.borderVerticalColor.toGMColor(),
        this.textureLine
      )
    }

    static renderRight = function(gridService) {
      var locked = gridService.targetLocked
      var isLockedX = locked.isLockedX
      var lockX = locked.lockX
      if (!isLockedX || !Optional.is(lockX)) {
        return
      }

      var view = gridService.view
      var horizontal = gridService.properties.borderHorizontalLength / 2.0
      var beginX = (lockX + (view.width / 2.0) + horizontal - view.x) * GRID_SERVICE_PIXEL_WIDTH
      var beginY = -3.0 * GRID_SERVICE_PIXEL_HEIGHT
      var endX = beginX
      var endY = (5.0 + view.height) * GRID_SERVICE_PIXEL_HEIGHT

      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderHorizontalThickness, 
        gridService.properties.borderHorizontalAlpha,
        gridService.properties.borderHorizontalColor.toGMColor(),
        this.textureLine
      )
    }

    static renderLeft = function(gridService) {
      var locked = gridService.targetLocked
      var isLockedX = locked.isLockedX
      var lockX = locked.lockX
      if (!isLockedX || !Optional.is(lockX)) {
        return
      }

      var view = gridService.view
      var horizontal = gridService.properties.borderHorizontalLength / 2.0
      var beginX = (lockX + (view.width / 2.0) - horizontal - view.x) * GRID_SERVICE_PIXEL_WIDTH
      var beginY = -3.0 * GRID_SERVICE_PIXEL_HEIGHT
      var endX = beginX
      var endY = (5.0 + view.height) * GRID_SERVICE_PIXEL_HEIGHT

      GPU.render.texturedLineSimple(
        beginX, beginY, endX, endY, 
        gridService.properties.borderHorizontalThickness, 
        gridService.properties.borderHorizontalAlpha,
        gridService.properties.borderHorizontalColor.toGMColor(),
        this.textureLine
      )
    }
    
    if (!gridService.properties.renderGrid) {
      return this
    }

    renderTop(gridService)
    renderBottom(gridService)
    renderLeft(gridService)
    renderRight(gridService)

    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {PlayerService} playerService
  ///@param {Number} baseX
  ///@param {Number} baseY
  ///@return {GridRenderer}
  entityRenderPlayer = function(gridService, playerService, baseX, baseY) { 
    var player = playerService.player
    if (!gridService.properties.renderPlayer
      || !Core.isType(player, Player)) {
      this.player2DCoords.x = null
      this.player2DCoords.y = null
      return this
    }

    var alpha = player.sprite.getAlpha()
    var angle = player.sprite.getAngle()
    var scaleX = player.sprite.getScaleX()
    var scaleY = player.sprite.getScaleY()
    var scaleFactor = clamp(player.stats.godModeCooldown, 1.0, 10.0)
    var useBlendAsZ = false
    if (useBlendAsZ) {
      shader_set(shader_gml_use_blend_as_z)
      shader_set_uniform_f(shader_get_uniform(shader_gml_use_blend_as_z, "size"), 1024.0)
      var _x = (player.x - (player.sprite.texture.width / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH
      var _y = (player.y - (player.sprite.texture.height / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT)  - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      var blend = player.sprite.getBlend()
      player.sprite
        .setBlend((sin(this.playerZTimer.update().time) * 0.5 + 0.5) * 255)
        .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0) * player.fadeIn)
        .setAngle(angle - 90.0 - (360.0 * player.stats.godModeCooldown))
        .setScaleX(scaleX * scaleFactor)
        .setScaleY(scaleY * scaleFactor)
        .render(_x, _y)
        .setBlend(blend)
        .setAlpha(alpha)
        .setAngle(angle)
        .setScaleX(scaleX)
        .setScaleY(scaleY)
      shader_reset()
    } else {
      var focus = Struct.get(player.gameMode, "focus") == true
      var focusCooldown = Struct.get(player.gameMode, "focusCooldown")
      var focusTime = Struct.get(focusCooldown, "time")
      var focusDuration = Struct.get(focusCooldown, "duration")
      var focusFactor = Optional.is(focusTime) && Optional.is(focusDuration) ? focusTime / focusDuration : 0.0

      var _x = (player.x - ((player.sprite.texture.width * player.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((player.sprite.texture.offsetX * player.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
      var _y = (player.y - ((player.sprite.texture.height * player.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((player.sprite.texture.offsetY * player.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT

      var _swing = (sin(this.playerZTimer.update().time * 5.0) + 1.0) / 2.0

      var _scaleX = ((player.sprite.getWidth() * player.sprite.getScaleX()) / sprite_get_width(texture_player_shadow)) * (3.0 + (1.5 * focusFactor)) * (scaleFactor + _swing)
      var _scaleY = ((player.sprite.getHeight() * player.sprite.getScaleY()) / sprite_get_height(texture_player_shadow)) * (3.0 + (1.5 * focusFactor)) * (scaleFactor + _swing)
      var _alpha = alpha * player.fadeIn * 0.75
      if (_alpha > 0 && player.sprite.texture.asset != texture_empty) {
        draw_sprite_ext(texture_player_shadow, 0, _x, _y, _scaleX, _scaleY, 0.0, this.playerShadowColor.toGMColor(), _alpha)
      }
      
      player.sprite
        .setAlpha(alpha * ((cos(player.stats.godModeCooldown * 15.0) + 2.0) / 3.0) * player.fadeIn)
        .setAngle(angle - 90.0 - (360.0 * player.stats.godModeCooldown))
        .setScaleX(scaleX * scaleFactor)
        .setScaleY(scaleY * scaleFactor)
        .render(_x, _y)
        .setAlpha(alpha)
        .setAngle(angle)
        .setScaleX(scaleX)
        .setScaleY(scaleY)
      this.player2DCoords = Math.project3DCoordsOn2D(_x + baseX, _y + baseY, gridService.properties.depths.playerZ, this.camera.viewMatrix, this.camera.projectionMatrix, this.gridSurface.width, this.gridSurface.height)
    }
    
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  entityRenderShrooms = function(gridService, shroomService) {
    static renderShroom = function(shroom, index, gridService) {
      var alpha = shroom.sprite.getAlpha()
      shroom.sprite
        .setAlpha(alpha * shroom.fadeIn)
        .render(
          (shroom.x - ((shroom.sprite.texture.width * shroom.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((shroom.sprite.texture.offsetX * shroom.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH)  - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (shroom.y - ((shroom.sprite.texture.height * shroom.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((shroom.sprite.texture.offsetY * shroom.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
        .setAlpha(alpha)
    }

    if (!gridService.properties.renderElements 
      || !gridService.properties.renderShrooms) {
      return this
    }

    shroomService.shrooms.forEach(renderShroom, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {BulletService} bulletService
  ///@return {GridRenderer}
  entityRenderBullets = function(gridService, bulletService) {
    static renderBullet = function(bullet, index, gridService) {
      bullet.sprite
        .setAngle(bullet.angle - 90.0)
        .render(
          (bullet.x - ((bullet.sprite.texture.width * bullet.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((bullet.sprite.texture.offsetX * bullet.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (bullet.y - ((bullet.sprite.texture.height * bullet.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((bullet.sprite.texture.offsetY * bullet.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderBullets) {
      return this
    }

    bulletService.bullets.forEach(renderBullet, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {CoinService} coinService
  ///@return {GridRenderer}
  entityRenderCoins = function(gridService, coinService) {
    static renderCoin = function(coin, index, gridService) {
      coin.sprite
        .render(
          (coin.x - ((coin.sprite.texture.width * coin.sprite.scaleX) / (2.0 * GRID_SERVICE_PIXEL_WIDTH)) + ((coin.sprite.texture.offsetX * coin.sprite.scaleX) / GRID_SERVICE_PIXEL_WIDTH) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH,
          (coin.y - ((coin.sprite.texture.height * coin.sprite.scaleY) / (2.0 * GRID_SERVICE_PIXEL_HEIGHT)) + ((coin.sprite.texture.offsetY * coin.sprite.scaleY) / GRID_SERVICE_PIXEL_HEIGHT) - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
        )
    }
    
    if (!gridService.properties.renderElements
        || !gridService.properties.renderCoins) {
      return this
    }

    coinService.coins.forEach(renderCoin, gridService)
    return this
  }

  ///@private
  ///@param {GridService} gridService
  ///@param {ParticleService} particleService
  ///@return {GridRenderer}
  layerRenderParticles = function(gridService, particleService) {
    if (!gridService.properties.renderParticles) {
      return this
    }

    particleService.systems.get("main").render()
    return this
  }

  renderParticles = function(gridService, shroomService, particleService, layout) {
    var width = layout.width()
    var height = layout.height()
    var properties = gridService.properties
    var depths = properties.depths
    var camera = this.camera
    var gmCamera = camera.get()
    var cameraAngle = camera.angle + (sin(camera.breathTimer2.time) * BREATH_TIMER_FACTOR_2)
    var cameraPitch = camera.pitch + (sin(camera.breathTimer1.time) * BREATH_TIMER_FACTOR_1)
    var xto = camera.x + (sin(camera.breathTimer2.time) * GRID_SERVICE_PIXEL_WIDTH * -1.0)
    var yto = camera.y
    var zto = camera.z
    var xfrom = xto + dcos(cameraAngle) * dcos(cameraPitch)
    var yfrom = yto - dsin(cameraAngle) * dcos(cameraPitch)
    var zfrom = zto - dsin(cameraPitch)
    var baseX = GRID_SERVICE_PIXEL_WIDTH + GRID_SERVICE_PIXEL_WIDTH * 0.5
    var baseY = GRID_SERVICE_PIXEL_HEIGHT + GRID_SERVICE_PIXEL_HEIGHT * 0.5
    camera.viewMatrix = matrix_build_lookat(
      xfrom, yfrom, zfrom, 
      xto, yto, zto, 
      0, 0, 1
    )

    ///@todo extract parameters
    camera.projectionMatrix = matrix_build_projection_perspective_fov(
      -60, 
      -1 * (width / height), 
      1, 
      32000 
    ) 

    camera_set_view_mat(gmCamera, camera.viewMatrix)
    camera_set_proj_mat(gmCamera, camera.projectionMatrix)
    camera_apply(gmCamera)
    
    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.particleZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    
    var editor = Beans.get(BeanVisuEditorController)
    if (Optional.is(editor) && editor.renderUI) {
      this.editorRenderParticleArea(gridService, shroomService, layout)
    }
    
    this.layerRenderParticles(gridService, particleService)

    matrix_set(matrix_world, matrix_build_identity())

    return this
  }
  
  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderBackgroundSurface = function(layout) {
    static renderParticles = function(context, gridService, shroomService, particleService, properties, layout, width, height) {
      var depths = properties.depths
      var camera = context.camera
      var gmCamera = camera.get()
      var cameraAngle = camera.angle + (sin(camera.breathTimer2.time) * BREATH_TIMER_FACTOR_2)
      var cameraPitch = camera.pitch + (sin(camera.breathTimer1.time) * BREATH_TIMER_FACTOR_1)
      var xto = camera.x + (sin(camera.breathTimer2.time) * GRID_SERVICE_PIXEL_WIDTH * -1.0)
      var yto = camera.y
      var zto = camera.z
      var xfrom = xto + dcos(cameraAngle) * dcos(cameraPitch)
      var yfrom = yto - dsin(cameraAngle) * dcos(cameraPitch)
      var zfrom = zto - dsin(cameraPitch)
      var baseX = GRID_SERVICE_PIXEL_WIDTH + GRID_SERVICE_PIXEL_WIDTH * 0.5
      var baseY = GRID_SERVICE_PIXEL_HEIGHT + GRID_SERVICE_PIXEL_HEIGHT * 0.5
      camera.viewMatrix = matrix_build_lookat(
        xfrom, yfrom, zfrom, 
        xto, yto, zto, 
        0, 0, 1
      )

      ///@todo extract parameters
      camera.projectionMatrix = matrix_build_projection_perspective_fov(
        -60, 
        -1 * (width / height), 
        1, 
        32000 
      ) 

      camera_set_view_mat(gmCamera, camera.viewMatrix)
      camera_set_proj_mat(gmCamera, camera.projectionMatrix)
      camera_apply(gmCamera)
      
      matrix_set(matrix_world, matrix_build(
        baseX, baseY, depths.particleZ, 
        0, 0, 0, 
        1, 1, 1
      ))
      
      var editor = Beans.get(BeanVisuEditorController)
      if (Optional.is(editor) && editor.renderUI) {
        context.editorRenderParticleArea(gridService, shroomService, layout)
      }
      
      context.layerRenderParticles(gridService, particleService)

      matrix_set(matrix_world, matrix_build_identity())
    }

    var controller = Beans.get(BeanVisuController)
    var gridService = controller.gridService
    var shroomService = controller.shroomService
    var particleService = controller.particleService
    var properties = gridService.properties
    var width = layout.width()
    var height = layout.height()

    GPU.render.clear(properties.gridClearColor, 0.0)

    if (properties.renderVideoAfter) {
      if (properties.renderBackground) {
        this.overlayRenderer.renderBackgrounds(width, height)
      }
        
      if (properties.renderVideo) {
        this.overlayRenderer.renderVideo(width, height, properties.videoAlpha,
          properties.videoBlendColor.toGMColor(), properties.videoBlendConfig)
      }
    } else {
      if (properties.renderVideo) {
        this.overlayRenderer.renderVideo(width, height, properties.videoAlpha,
          properties.videoBlendColor.toGMColor(), properties.videoBlendConfig)
      }
    
      if (properties.renderBackground) {
        this.overlayRenderer.renderBackgrounds(width, height)
      }
    }

    //if (Visu.settings.getValue("visu.graphics.particle")) {
    //  renderParticles(this, gridService, shroomService, particleService, properties, layout, width, height)
    //}

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGridSurface = function(layout) {
    var width = layout.width()
    var height = layout.height()
    var renderDebugMasks = Visu.settings.getValue("visu.debug.render-entities-mask", false)
    var renderDebugChunks = Visu.settings.getValue("visu.debug.render-debug-chunks", false)
    var _renderPlayer = this.entityRenderPlayer
    var _renderShrooms = this.entityRenderShrooms
    var _renderBullets = this.entityRenderBullets
    var _renderCoins = this.entityRenderCoins
    if (renderDebugMasks) {
      _renderPlayer = this.debugRenderPlayer
      _renderShrooms = this.debugRenderShrooms
      _renderBullets = this.debugRenderBullets
      _renderCoins = this.debugRenderCoins
    }
    
    var controller = Beans.get(BeanVisuController)
    var gridService = controller.gridService
    var properties = gridService.properties
    var bulletService = controller.bulletService
    var playerService = controller.playerService
    var shroomService = controller.shroomService
    var coinService = controller.coinService
    var particleService = controller.particleService

    if (properties.gridClearFrame) {
      var tempAlpha = properties.gridClearColor.alpha
      properties.gridClearColor.alpha = properties.gridClearFrameAlpha
      GPU.render.clear(properties.gridClearColor)
      properties.gridClearColor.alpha = tempAlpha
    } else {
      GPU.set.blendMode(BlendMode.SUBTRACT)
        .render.fillColor(
          width,
          height,
          properties.gridClearColor.toGMColor(),
          properties.gridClearFrameAlpha
        )
        .reset.blendMode()
    }

    var depths = properties.depths
    var camera = this.camera
    var gmCamera = camera.get()
    var cameraAngle = camera.angle + (sin(camera.breathTimer2.time) * BREATH_TIMER_FACTOR_2)
    var cameraPitch = camera.pitch + (sin(camera.breathTimer1.time) * BREATH_TIMER_FACTOR_1)
    var xto = camera.x + (sin(camera.breathTimer2.time) * GRID_SERVICE_PIXEL_WIDTH * -1.0)
    var yto = camera.y
    var zto = camera.z
    var xfrom = xto + dcos(cameraAngle) * dcos(cameraPitch)
    var yfrom = yto - dsin(cameraAngle) * dcos(cameraPitch)
    var zfrom = zto - dsin(cameraPitch)
    var baseX = GRID_SERVICE_PIXEL_WIDTH + GRID_SERVICE_PIXEL_WIDTH * 0.5
    var baseY = GRID_SERVICE_PIXEL_HEIGHT + GRID_SERVICE_PIXEL_HEIGHT * 0.5
    camera.viewMatrix = matrix_build_lookat(
      xfrom, yfrom, zfrom, 
      xto, yto, zto, 
      0, 0, 1
    )
    ///@todo extract parameters
    camera.projectionMatrix = matrix_build_projection_perspective_fov(
      -60, 
      -1 * (width / height), 
      1, 
      32000 
    ) 
    camera_set_view_mat(gmCamera, camera.viewMatrix)
    camera_set_proj_mat(gmCamera, camera.projectionMatrix)
    camera_apply(gmCamera)

    var _baseX = gridService.targetLocked.isLockedX && Optional.is(gridService.targetLocked.lockX)
      ? (gridService.targetLocked.lockX - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH
      : 0.0
    matrix_set(matrix_world, matrix_build(
      baseX + _baseX, baseY, depths.gridZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    this.gridRenderChannels(gridService)

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.gridZ + 1, 
      0, 0, 0, 
      1, 1, 1
    ))
    this.gridRenderSeparators(gridService)

    gpu_set_ztestenable(true)
    gpu_set_zwriteenable(true)
    gpu_set_alphatestenable(true)
    if (this.pathTrack != null) {
      var xxx = (((gridService.width - gridService.view.width) / 2.0) - gridService.view.x) * GRID_SERVICE_PIXEL_WIDTH
      var yyy = (gridService.height - gridService.view.y) * GRID_SERVICE_PIXEL_HEIGHT
      matrix_set(matrix_world, matrix_build(
        baseX + xxx, baseY + yyy, depths.coinZ - 1, 
        0, 0, 0,
        1, 1, 1
      ))
      vertex_submit(this.pathTrack.vertexBuffer.buffer, pr_trianglelist, -1)
    }

    //if (Visu.settings.getValue("visu.graphics.particle")) {
    //  matrix_set(matrix_world, matrix_build(
    //    baseX, baseY, depths.particleZ, 
    //    0, 0, 0, 
    //    1, 1, 1
    //  ))
    //
    //  var editor = Beans.get(BeanVisuEditorController)
    //  if (Optional.is(editor) && editor.renderUI) {
    //    this.editorRenderParticleArea(gridService, shroomService, layout)
    //  }
    //
    //  this.layerRenderParticles(gridService, particleService)
    //}

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.coinZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    _renderCoins(gridService, coinService)

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.shroomZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    _renderShrooms(gridService, shroomService)

    //var x2d = (baseX + MouseUtil.getMouseX()) 
    //var y2d = (baseY + MouseUtil.getMouseY())
    //var coords3d = Math.project2DCoordsOn3D(x2d, y2d, camera.viewMatrix, camera.projectionMatrix, width, height)
    //Core.print("xy2d", x2d, y2d, "xyz3d", coords3d)
    //matrix_set(matrix_world, matrix_build(
    //  coords3d[0], coords3d[1], coords3d[2],
    //  0, 0, 0, 
    //  1, 1, 1
    //))
    //draw_sprite(texture_baron, 0, x2d, y2d)
    
    if (renderDebugChunks) {
      shroomService.chunkService.chunks.forEach(function(chunk, key, view) {
        var arr = String.split(key, "_")
        var xx = ((real(arr.get(0)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.x) * GRID_SERVICE_PIXEL_WIDTH
        var yy = ((real(arr.get(1)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.y) * GRID_SERVICE_PIXEL_HEIGHT
        draw_sprite_ext(
          texture_white, 
          0.0, 
          xx,
          yy, 
          ((GRID_SERVICE_PIXEL_WIDTH * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.9,
          ((GRID_SERVICE_PIXEL_HEIGHT * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.9,
          0.0,
          chunk.size() > 0 ? c_red : c_white,
          0.6
        )
      }, gridService.view)

      bulletService.chunkService.chunks.forEach(function(chunk, key, view) {
        var arr = String.split(key, "_")
        var xx = ((real(arr.get(0)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.x) * GRID_SERVICE_PIXEL_WIDTH
        var yy = ((real(arr.get(1)) * GRID_ITEM_CHUNK_SERVICE_SIZE) - view.y) * GRID_SERVICE_PIXEL_HEIGHT
        draw_sprite_ext(
          texture_white, 
          0.0, 
          xx + 128, 
          yy + 128, 
          ((GRID_SERVICE_PIXEL_WIDTH * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.75,
          ((GRID_SERVICE_PIXEL_HEIGHT * GRID_ITEM_CHUNK_SERVICE_SIZE) / 64) * 0.75,
          0.0,
          chunk.size() > 0 ? c_lime : c_white,
          0.6
        )
      }, gridService.view)
    }
    
    this.editorRenderSpawners(gridService, shroomService, layout)
    gpu_set_ztestenable(false)
    gpu_set_zwriteenable(false)
    gpu_set_alphatestenable(false)

    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.bulletZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    _renderBullets(gridService, bulletService)
    
    matrix_set(matrix_world, matrix_build(
      baseX, baseY, depths.playerZ, 
      0, 0, 0, 
      1, 1, 1
    ))
    this.gridRenderBorders(gridService)
    _renderPlayer(gridService, playerService, baseX, baseY)

    matrix_set(matrix_world, matrix_build_identity())

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderFocusGridSurface = function(layout) {
    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    var size = max(
      (properties.renderGridShaders && Visu.settings.getValue("visu.graphics.main-shaders")
        ? controller.shaderPipeline.executor.tasks.size()
        : 0),
      (properties.renderCombinedShaders && Visu.settings.getValue("visu.graphics.combined-shaders")
        ? controller.shaderCombinedPipeline.executor.tasks.size()
        : 0)
    )

    GPU.render.clear(properties.gridClearColor, 0.0)

    if (!properties.renderSupportGrid || properties.supportGridTreshold > size) {
      return this
    }

    this.gridSurface.renderStretched(
      this.focusGridSurface.width,
      this.focusGridSurface.height,
      0,
      0,
      properties.supportGridAlpha,
      properties.supportGridBlendColor.toGMColor(),
      properties.supportGridBlendConfig
    )

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderBackgroundGlitch = function(layout) {
    this.backgroundSurface.renderStretched(layout.width(), layout.height())
    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGridGlitch = function(layout) {
    this.gridSurface.renderStretched(layout.width(), layout.height())
    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderCombinedGlitch = function(layout) {
    this.combinedSurface.renderStretched(layout.width(), layout.height())
    return this
  }


  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGameSurface = function(layout) {
    var controller = Beans.get(BeanVisuController)
    var gridService = controller.gridService
    var properties = gridService.properties
    var width = layout.width()
    var height = layout.height()
    var enableGlitch = Visu.settings.getValue("visu.graphics.bkt-glitch")

    GPU.render.clear(properties.gridClearColor)

    if (enableGlitch && properties.renderBackgroundGlitch) {
      this.backgroundGlitchService.renderOn(this.renderBackgroundGlitch, layout)
    } else {
      this.renderBackgroundGlitch(layout)
    }

    if (enableGlitch && properties.renderGridGlitch) {
      this.gridGlitchService.renderOn(this.renderGridGlitch, layout)
    } else {
      this.renderGridGlitch(layout)
    }

    if (properties.renderForeground) {
      this.overlayRenderer.renderForegrounds(layout.width(), layout.height())
    }

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderShaderBackgroundSurface = function(layout) {
    static renderBackgroundShader = function(task, index, gridRenderer) {
      GPU.set.surface(gridRenderer.shaderBackgroundSurface)
      gridRenderer.backgroundSurface.renderStretched(
        gridRenderer.shaderSurface.width, 
        gridRenderer.shaderSurface.height, 
        0, 
        0,
        task.state.getDefault("alpha", 1.0)
      )
      GPU.reset.surface()
    }

    static postRenderBackgroundShader = function(task, index, gridRenderer) {
      GPU.set.surface(gridRenderer.backgroundSurface)
      gridRenderer.shaderBackgroundSurface.renderStretched(
        gridRenderer.backgroundSurface.width, 
        gridRenderer.backgroundSurface.height, 
        0, 
        0,
        1.0
      )
      GPU.reset.surface()
    }
    
    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    if (!properties.renderBackgroundShaders 
        || !Visu.settings.getValue("visu.graphics.bkg-shaders")) {
      return this
    }

    var width = this.shaderSurface.width
    var height = this.shaderSurface.height
    var shaderPipeline = controller.shaderBackgroundPipeline

    GPU.set.surface(this.shaderBackgroundSurface)
    GPU.render.clear(properties.gridClearColor, 0.0)
    GPU.reset.surface()

    shaderPipeline
      .setWidth(width)
      .setHeight(height)
      .render(renderBackgroundShader, this, null, postRenderBackgroundShader)

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderShaderSurface = function(layout) {
    static renderGridShader = function(task, index, gridRenderer) {
      GPU.set.surface(gridRenderer.shaderSurface)
      gridRenderer.gridSurface.renderStretched(
        gridRenderer.shaderSurface.width, 
        gridRenderer.shaderSurface.height, 
        0, 
        0,
        task.state.getDefault("alpha", 1.0)
      )
      GPU.reset.surface()
    }

    static postRenderGridShader = function(task, index, gridRenderer) {
      GPU.set.surface(gridRenderer.gridSurface)
      gridRenderer.shaderSurface.renderStretched(
        gridRenderer.gridSurface.width, 
        gridRenderer.gridSurface.height, 
        0, 
        0,
        1.0
      )
      GPU.reset.surface()
    }

    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    if (!properties.renderGridShaders 
        || !Visu.settings.getValue("visu.graphics.main-shaders")) {
      return this
    }

    var width = this.shaderSurface.width
    var height = this.shaderSurface.height
    var shaderPipeline = controller.shaderPipeline

    if (properties.shaderClearFrame) {
      var tempAlpha = properties.shaderClearColor.alpha
      properties.shaderClearColor.alpha = properties.shaderClearFrameAlpha
      GPU.render.clear(properties.shaderClearColor)
      properties.shaderClearColor.alpha = tempAlpha
    } else {
      GPU.set.blendMode(BlendMode.SUBTRACT)
      GPU.render.fillColor(
        width,
        height,
        properties.shaderClearColor.toGMColor(),
        properties.shaderClearFrameAlpha
      )
      GPU.reset.blendMode()
    }

    shaderPipeline
      .setWidth(width)
      .setHeight(height)
      .render(renderGridShader, this, null, postRenderGridShader)

    return this;
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderShaderCombinedSurface = function(layout) {
    static renderCombinedShader = function(task, index, gridRenderer) {
      GPU.set.surface(gridRenderer.shaderCombinedSurface)
      gridRenderer.gameSurface.renderStretched(
        gridRenderer.shaderCombinedSurface.width, 
        gridRenderer.shaderCombinedSurface.height, 
        0, 
        0,
        task.state.getDefault("alpha", 1.0)
      )
      GPU.reset.surface()
    }
    
    static postRenderCombinedShader = function(task, index, gridRenderer) {
      GPU.set.surface(gridRenderer.gameSurface)
      gridRenderer.shaderCombinedSurface.renderStretched(
        gridRenderer.gameSurface.width, 
        gridRenderer.gameSurface.height, 
        0, 
        0,
        1.0
      )
      GPU.reset.surface()
    }
    
    var controller = Beans.get(BeanVisuController)
    var properties = controller.gridService.properties
    if (!properties.renderCombinedShaders
        || !Visu.settings.getValue("visu.graphics.combined-shaders")) {
      return this
    }

    var width = this.shaderCombinedSurface.width
    var height = this.shaderCombinedSurface.height
    var shaderPipeline = controller.shaderCombinedPipeline

    GPU.render.clear(properties.shaderClearColor, 0.0)

    shaderPipeline
      .setWidth(width)
      .setHeight(height)
      .render(renderCombinedShader, this, null, postRenderCombinedShader)

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGUIGameSurface = function(layout) {
    this.gameSurface.renderStretched(
      layout.width(),
      layout.height(),
      layout.x(),
      layout.y()
    )

    return this
  }

  ///@private
  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGUIFocusGridSurface = function(layout) {
    this.focusGridSurface.renderStretched(
      layout.width(),
      layout.height(),
      layout.x(),
      layout.y()
    )

    return this
  }

  ///@private
  ///@param {PlayerService} playerService
  ///@param {UILayout} layout
  ///@return {GrindRenderer}
  renderPlayerHint = function(playerService, layout) {
    var width = layout.width()
    var height = layout.height()
    if ((this.player2DCoords.x != null && this.player2DCoords.y != null) 
      && (this.player2DCoords.x < 0 
        || this.player2DCoords.x > width 
        || this.player2DCoords.y < 0 
        || this.player2DCoords.y > height)) {
      var configX = layout.x()
      var configY = layout.y()
      var player = playerService.player
      var _x = clamp(this.player2DCoords.x, player.sprite.getWidth() - player.sprite.texture.offsetX, width - player.sprite.getWidth() + player.sprite.texture.offsetX)
      var _y = clamp(this.player2DCoords.y, player.sprite.getHeight() - player.sprite.texture.offsetY, height - player.sprite.getHeight() + player.sprite.texture.offsetY)
      var alpha = player.sprite.getAlpha()
      player.sprite
        .setAlpha(alpha * 0.5)
        .render(configX + _x, configY + _y)
        .setAlpha(alpha)

      var angle = Math.fetchPointsAngle(_x, _y, this.player2DCoords.x, this.player2DCoords.y)
      this.playerHintPointer
        .setAngle(angle)
        .setAlpha(0.8)
        .render(
          configX + _x + Math.fetchCircleX(player.sprite.getWidth() / 3, angle),
          configY + _y + Math.fetchCircleY(player.sprite.getHeight() / 3, angle)
        )
      
      var length = round(Math.fetchLength(_x, _y, this.player2DCoords.x, this.player2DCoords.y))
      GPU.render.text(
        configX + _x,
        configY + _y,
        string(length),
        1.0,
        0.0,
        1.0,
        c_white,
        this.playerHintFont, 
        HAlign.CENTER,
        VAlign.CENTER,
        c_black,
        1.0
      )
    }

    return this
  }

  ///@return {GridRenderer}
  clear = function() {
    this.camera.free()
    this.camera = new GridCamera()
    this.overlayRenderer.clear()
    return this
  }

  ///@param {UILayout} layout
  ///@return {GridRenderer}
  update = function(layout) {
    //this.blendModes.update()
    this.camera.update(layout)
    this.overlayRenderer.update()

    var width = layout.width()
    var height = layout.height()
    this.backgroundGlitchService.update(width, height)
    this.gridGlitchService.update(width, height)
    this.combinedGlitchService.update(width, height)

    if (this.pathTrack != null) {
      this.pathTrack.update()
    }
    
    return this
  }

  ///@param {UILayout} layout
  ///@return {GridRenderer}
  render = function(layout) {
    static updatePlayerShadowColor = function(context, layout) {
      var controller = Beans.get(BeanVisuController)
      var properties = controller.gridService.properties
      var middleSurface = (properties.renderBackgroundShaders
          && Visu.settings.getValue("visu.graphics.bkg-shaders")
          && controller.shaderBackgroundPipeline.executor.tasks.size() > 0)
        ? context.shaderBackgroundSurface.asset
        : context.backgroundSurface.asset

      if (!surface_exists(middleSurface)) {
        return
      }

      var playerService = controller.playerService
      var player = playerService.player
      var width = layout.width()
      var height = layout.height()
      var configX = layout.x()
      var configY = layout.y()
      var _x = configX + (width / 2.0)
      var _y = configY + (height / 2.0)
      var player = playerService.player
      if (Optional.is(player) 
          && Optional.is(player2DCoords.x) 
          && Optional.is(player2DCoords.y)) {
        _x = configX + clamp(
          context.player2DCoords.x, 
          player.sprite.getWidth() - player.sprite.texture.offsetX, 
          width - player.sprite.getWidth() + player.sprite.texture.offsetX
        )
        _y = configY + clamp(
          context.player2DCoords.y,
          player.sprite.getHeight() - player.sprite.texture.offsetY,
          height - player.sprite.getHeight() + player.sprite.texture.offsetY
        )
      }

      if (middleSurface == context.shaderBackgroundSurface.asset) {
        _x = _x * (context.shaderBackgroundSurface.width / context.backgroundSurface.width)
        _y = _y * (context.shaderBackgroundSurface.height / context.backgroundSurface.height)
      }

      var middleColor = surface_getpixel(middleSurface, _x, _y)
      context.playerShadowColor.red = lerp(context.playerShadowColor.red, 1.0 - (color_get_red(middleColor) / 255.0), 0.1)
      context.playerShadowColor.green = lerp(context.playerShadowColor.green, 1.0 - (color_get_green(middleColor) / 255.0), 0.1)
      context.playerShadowColor.blue = lerp(context.playerShadowColor.blue, 1.0 - (color_get_blue(middleColor) / 255.0), 0.1)
    }
    
    static renderParticles = function(context, layout) {
      var controller = Beans.get(BeanVisuController)
      if (controller.gridService.properties.renderParticles
          && Visu.settings.getValue("visu.graphics.particle")) {
        GPU.set.surface(context.backgroundSurface)
        context.renderParticles(
          controller.gridService,
          controller.shroomService,
          controller.particleService,
          layout
        )
        GPU.reset.surface()
      }
    }

    var shaderQuality = Visu.settings.getValue("visu.graphics.shader-quality", 1.0)
    var width = ceil(layout.width())
    var height = ceil(layout.height())
    var shaderWidth = ceil(width * shaderQuality)
    var shaderHeight = ceil(height * shaderQuality)
    
    this.backgroundSurface
      .update(width, height)
      .renderOn(this.renderBackgroundSurface, layout, true)
    
    this.gridSurface
      .update(width, height)
      .renderOn(this.renderGridSurface, layout, true)

    this.focusGridSurface
      .update(width, height)
      .renderOn(this.renderFocusGridSurface, layout, true)

    this.shaderBackgroundSurface
      .update(shaderWidth, shaderHeight)
      .renderOn(this.renderShaderBackgroundSurface, layout, false)
    
    this.shaderSurface
      .update(shaderWidth, shaderHeight)
      .renderOn(this.renderShaderSurface, layout, false)
    
    renderParticles(this, layout)

    this.gameSurface
      .update(width, height)
      .renderOn(this.renderGameSurface, layout, true)

    this.shaderCombinedSurface
      .update(shaderWidth, shaderHeight)
      .renderOn(this.renderShaderCombinedSurface, layout, false)

    updatePlayerShadowColor(this, layout)

    return this
  }

  ///@param {UILayout} layout
  ///@return {GridRenderer}
  renderGUI = function(layout) {
    var controller = Beans.get(BeanVisuController)
    if (Visu.settings.getValue("visu.debug.render-surfaces")) {
      GPU.render.clear(controller.gridService.properties.gridClearColor, 1.0)
      this.backgroundSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, 0.0, 0.0)
      this.gridSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, GuiWidth() / 2.0, 0.0)
      this.shaderBackgroundSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, 0.0, GuiHeight() / 2.0)
      this.shaderSurface.renderStretched(GuiWidth() / 2.0, GuiHeight() / 2.0, GuiWidth() / 2.0, GuiHeight() / 2.0)
      return this
    }

    var properties = controller.gridService.properties
    if (properties.renderCombinedGlitch
        && Visu.settings.getValue("visu.graphics.bkt-glitch")) {
      this.combinedGlitchService.renderOn(this.renderGUIGameSurface, layout)
    } else {
      this.renderGUIGameSurface(layout)
    }

    if (properties.renderSupportGrid) {
      this.renderGUIFocusGridSurface(layout)
    }

    if (Visu.settings.getValue("visu.interface.player-hint")) {
      this.renderPlayerHint(controller.playerService, layout)
    }

    var editor = Beans.get(BeanVisuEditorController)
    if (Optional.is(editor) && editor.renderUI) {
      this.editorRenderSubtitlesArea(controller.gridService, controller.shroomService, layout)
    }

    return this
  }

  ///@return {GridRenderer}
  free = function() {
    this.backgroundSurface.free()
    this.gridSurface.free()
    this.focusGridSurface.free()
    this.gameSurface.free()
    this.shaderSurface.free()
    this.shaderBackgroundSurface.free()
    this.shaderCombinedSurface.free()
    return this
  }

  this.init()
}

