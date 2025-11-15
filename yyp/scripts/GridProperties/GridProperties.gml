///@package io.alkapivo.visu.service.grid

///@param {?Struct} [config]
function GridProperties(config = null) constructor {

  ///@type {Number}
  speed = Struct.getIfType(config, "speed", Number, 1.0)

  #region channels
  ///@type {Number}
  channels = Struct.getIfType(config, "channels", Number, 3.0)

  ///@type {Color}
  channelsPrimaryColor = ColorUtil.parse(Struct.get(config, "channelsPrimaryColor"), "#ff12ac")

  ///@type {Color}
  channelsSecondaryColor = ColorUtil.fromHex(Struct.get(config, "channelsSecondaryColor"), "#7daaff")

  ///@type {Number}
  channelsPrimaryAlpha = Struct.getIfType(config, "channelsPrimaryAlpha", Number, 0.0)

  ///@type {Number}
  channelsSecondaryAlpha = Struct.getIfType(config, "channelsSecondaryAlpha", Number, 0.0)

  ///@type {Number}
  channelsPrimaryThickness = Struct.getIfType(config, "channelsPrimaryThickness", Number, 4.0)

  ///@type {Number}
  channelsSecondaryThickness = Struct.getIfType(config, "channelsSecondaryThickness", Number, 4.0)

  ///@type {String}
  channelsPrimaryTextureLine = Struct.getIfType(config, "channelsPrimaryTextureLine", String, "MAGIC_1")

  ///@type {String}
  channelsSecondaryTextureLine = Struct.getIfType(config, "channelsSecondaryTextureLine", String, "MAGIC_1")

  ///@type {String}
  channelsMode = Struct.getIfType(config, "channelsMode", String, "SINGLE")
  #endregion

  #region separators
  ///@type {Number}
  separators = Assert.isType(Struct
    .getDefault(config, "separators", 2.0), Number)

  ///@type {Color}
  separatorsPrimaryColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "separatorsPrimaryColor ", "#4a3adaff")), Color)

  ///@type {Color}
  separatorsSecondaryColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "separatorsSecondaryColor ", "#7daaff")), Color)

  ///@type {Number}
  separatorsPrimaryAlpha = Assert.isType(Struct
    .getDefault(config, "separatorsPrimaryAlpha", 0.0), Number)

  ///@type {Number}
  separatorsSecondaryAlpha = Assert.isType(Struct
    .getDefault(config, "separatorsSecondaryAlpha", 0.0), Number)  

  ///@type {Number}
  separatorsPrimaryThickness = Assert.isType(Struct
      .getDefault(config, "separatorsPrimaryThickness", 10), Number)

  ///@type {Number}
  separatorsSecondaryThickness = Assert.isType(Struct
    .getDefault(config, "separatorsSecondaryThickness", 10), Number)

  ///@type {String}
  separatorsPrimaryTextureLine = Struct.getIfType(config, "separatorsPrimaryTextureLine", String, "MAGIC_1")

  ///@type {String}
  separatorsSecondaryTextureLine = Struct.getIfType(config, "separatorsSecondaryTextureLine", String, "MAGIC_1")

  ///@type {String}
  separatorsMode = Assert.isType(Struct
    .getDefault(config, "separatorsMode", "SINGLE"), String)
  #endregion

  #region borders
  ///@type {Color}
  borderVerticalColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "borderVerticalColor ", "#ff0000")), Color)

  ///@type {Number}
  borderVerticalAlpha = Assert.isType(Struct
    .getDefault(config, "borderVerticalAlpha", 0.0), Number)

  ///@type {Number}
  borderVerticalThickness = Assert.isType(Struct
      .getDefault(config, "borderVerticalThickness", 16), Number)

  ///@type {Color}
  borderHorizontalColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "borderHorizontalColor ", "#ff0000")), Color)

  ///@type {Number}
  borderHorizontalAlpha = Assert.isType(Struct
    .getDefault(config, "borderHorizontalAlpha", 0.0), Number)  

  ///@type {Number}
  borderHorizontalThickness = Assert.isType(Struct
    .getDefault(config, "borderHorizontalThickness", 16), Number)

  ///@type {Number}
  borderHorizontalLength = Assert.isType(Struct
    .getDefault(config, "borderHorizontalLength", 2), Number)

  ///@type {Number}
  borderVerticalLength = Assert.isType(Struct
    .getDefault(config, "borderVerticalLength", 2), Number)
  #endregion
  
  #region enable/disable rendering
  ///@type {Boolean}
  renderGrid = Assert.isType(Struct
    .getDefault(config, "renderGrid", true), Boolean)
  
  ///@type {Boolean}
  renderElements = Assert.isType(Struct
    .getDefault(config, "renderElements", true), Boolean)

  ///@type {Boolean}
  renderBullets = Assert.isType(Struct
    .getDefault(config, "renderBullets", true), Boolean)

  ///@type {Boolean}
  renderShrooms = Assert.isType(Struct
    .getDefault(config, "renderShrooms", true), Boolean)

  ///@type {Boolean}
  renderCoins = Assert.isType(Struct
    .getDefault(config, "renderCoins", true), Boolean)

  ///@type {Boolean}
  renderPlayer = Struct.getIfType(config, "renderPlayer", Boolean, true)

  ///@type {Boolean}
  renderBackground = Assert.isType(Struct
    .getDefault(config, "renderBackground", true), Boolean)

  ///@type {Boolean}
  renderVideo = Assert.isType(Struct
    .getDefault(config, "renderVideo", true), Boolean)

  ///@type {Boolean}
  renderVideoAfter = Assert.isType(Struct
    .getDefault(config, "renderVideoAfter", false), Boolean)

  ///@type {Boolean}
  renderForeground = Assert.isType(Struct
    .getDefault(config, "renderForeground", true), Boolean)

  ///@type {Boolean}
  renderGridShaders = Assert.isType(Struct
    .getDefault(config, "renderGridShaders", true), Boolean)

  ///@type {Boolean}
  renderBackgroundShaders = Assert.isType(Struct
    .getDefault(config, "renderBackgroundShaders", true), Boolean)

  ///@type {Boolean}
  renderCombinedShaders = Assert.isType(Struct
    .getDefault(config, "renderCombinedShaders", true), Boolean)

  ///@type {Boolean}
  renderParticles = Assert.isType(Struct
    .getDefault(config, "renderParticles", true), Boolean)

  ///@type {Boolean}
  renderSubtitles = Assert.isType(Struct
    .getDefault(config, "renderSubtitles", true), Boolean)

  ///@type {Boolean}
  renderBackgroundGlitch = Struct.getIfType(config, "renderBackgroundGlitch", Boolean, true)

  ///@type {Boolean}
  renderGridGlitch = Struct.getIfType(config, "renderGridGlitch", Boolean, true)
  
  ///@type {Boolean}
  renderCombinedGlitch = Struct.getIfType(config, "renderCombinedGlitch", Boolean, true)
  #endregion

  #region focus-grid
  ///@type {Number}
  renderSupportGrid = Struct.getIfType(config, "renderSupportGrid",  Boolean, false)

  ///@type {Number}
  supportGridTreshold = Struct.getIfType(config, "supportGridTreshold", Number, 8.0)

  ///@type {Number}
  supportColorAlpha = Struct.getIfType(config, "supportColorAlpha", Number, 0.0)

  ///@type {Number}
  supportGridAlpha = Struct.getIfType(config, "supportGridAlpha", Number, 0.0)

  ///@type {Number}
  supportFocusAlpha = Struct.getIfType(config, "supportFocusAlpha", Number, 0.0)

  ///@type {Color}
  supportColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "supportColor", "#ffffff")), Color)

  ///@type {Color}
  supportGridColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "supportGridColor", "#ffffff")), Color)

  ///@type {BlendConfig}
  supportBlendConfig = new BlendConfig(Struct.getIfType(config, "supportBlendConfig", Struct))
  #endregion

  ///@type {Color}
  gridClearColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "gridClearColor", "#400421")), Color)

  ///@type {Boolean}
  gridClearFrame = Assert.isType(Struct
    .getDefault(config, "gridClearFrame", true), Boolean)

  ///@type {Number}
  gridClearFrameAlpha = Assert.isType(Struct
    .getDefault(config, "gridClearFrameAlpha", 0.0), Number)

  ///@type {BlendConfig}
  gridBlendConfig = new BlendConfig(Struct
    .getIfType(config, "gridBlendConfig", Struct))

  ///@type {Color}
  /*
  shaderClearColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "shaderClearColor", "#00000000")), Color)

  ///@type {Boolean}
  shaderClearFrame = Assert.isType(Struct
    .getDefault(config, "shaderClearFrame", true), Boolean)

  ///@type {Number}
  shaderClearFrameAlpha = Assert.isType(Struct
    .getDefault(config, "shaderClearFrameAlpha", 0.0), Number)
  */
  
  ///@type {Number}
  videoAlpha = Assert.isType(Struct
    .getDefault(config, "videoAlpha", 1.0), Number)

  ///@type {Color}
  videoBlendColor = Assert.isType(ColorUtil.fromHex(Struct
    .getDefault(config, "videoBlendColor", "#ffffff")), Color)
  
  ///@type {BlendConfig}
  videoBlendConfig = new BlendConfig(Struct.getIfType(config, "videoBlendConfig", Struct))

  ///@type {Boolean}
  playerShadowEnable = Struct.getIfType(config, "playerShadowEnable", Boolean, true)

  ///@type {Struct}
  depths = {
    gridZ: 2045,
    particleZ: 2100,//2047,
    bulletZ: 2048,
    shroomZ: 2049,
    coinZ: 2047,
    playerZ: 2051,
  }
  
  ///@type {Number}
  bulletTime = Struct.getIfType(config, "bulletTime", Number, GRID_SERVICE_BULLET_TIME)

  ///@private
  ///@type {Timer}
  separatorTimer = new Timer(FRAME_MS, { amount: this.speed / GRID_ITEM_SPEED_SCALE, loop: Infinity })

  ///@param {Struct} context
  ///@return {GridProperties}
  init = function(context) {
    var properties = this
    var pump = context.dispatcher
    var executor = context.executor
    pump.send(new Event("transform-property", {
      key: "channelsPrimaryAlpha",
      container: properties,
      executor: executor,
      transformer: new NumberTransformer({
        value: 0.0,
        target: 0.8,
        ease: EaseType.LINEAR,
        duration: 0.8,
      })
    }))
    pump.send(new Event("transform-property", {
      key: "channelsSecondaryAlpha",
      container: properties,
      executor: executor,
      transformer: new NumberTransformer({
        value: 0.0,
        target: 0.6,
        ease: EaseType.LINEAR,
        duration: 0.8,
      })
    }))
    pump.send(new Event("transform-property", {
      key: "separatorsPrimaryAlpha",
      container: properties,
      executor: executor,
      transformer: new NumberTransformer({
        value: 0.0,
        target: 0.65,
        ease: EaseType.LINEAR,
        duration: 0.8,
      })
    }))
    pump.send(new Event("transform-property", {
      key: "separatorsSecondaryAlpha",
      container: properties,
      executor: executor,
      transformer: new NumberTransformer({
        value: 0.0,
        target: 0.5,
        ease: EaseType.LINEAR,
        duration: 0.8,
      })
    }))

    return this
  }

  ///@param {GridService} gridService
  ///@return {GridProperties}
  update = function(gridService) {
    this.separatorTimer.duration = ((gridService.view.height * 2.0) / this.separators)
    this.separatorTimer.update()
    this.separatorTimer.amount = (this.speed / GRID_ITEM_SPEED_SCALE) - (gridService.view.derivativeY)
    //this.separatorTimer.amount = (this.speed / GRID_ITEM_SPEED_SCALE) - DeltaTime.apply(gridService.view.derivativeY)

    this.gridClearColor.alpha = this.gridClearFrameAlpha
    //this.shaderClearColor.alpha = this.shaderClearFrameAlpha

    //if (keyboard_check(ord("K"))) {
    //  this.bulletTime = Math.transformNumber(GRID_SERVICE_BULLET_TIME, 0.5, 0.02)
    //  Core.print("bulletTime", this.bulletTime)
    //} else {
    //  this.bulletTime = Math.transformNumber(GRID_SERVICE_BULLET_TIME, 1.0, 0.02)
    //}

    GRID_SERVICE_BULLET_TIME = this.bulletTime
    return this
  }
}

