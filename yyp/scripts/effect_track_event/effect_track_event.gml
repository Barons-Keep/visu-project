///@package io.alkapivo.visu.service.track

///@enum
function _ShaderPipelineType(): Enum() constructor {
  BACKGROUND = "BACKGROUND"
  GRID = "GRID"
  COMBINED = "COMBINED"
}
global.__ShaderPipelineType = new _ShaderPipelineType()
#macro ShaderPipelineType global.__ShaderPipelineType


///@enum
function _GlitchType(): Enum() constructor {
  BACKGROUND = "BACKGROUND"
  GRID = "GRID"
  COMBINED = "COMBINED"
}
global.__GlitchType = new _GlitchType()
#macro GlitchType global.__GlitchType


///@type {Boolean}
#macro TRACK_EVENT_DEFAULT_HIDDEN_VALUE false

///@static
///@type {Struct}
global.__effect_track_event = {
  "brush_effect_shader": {
    parse: function(data) {
      var template = Struct.parse.text(data, "ef-shd_template", "shader-default")
      if (Core.getRuntimeType() == RuntimeType.GXGAMES
          && Struct.contains(SHADERS_WASM, template)) {
        var wasmTemplate = Struct.get(SHADERS_WASM, eventData.template)
        Logger.debug("Track", $"Override shader '{template}' with '{wasmTemplate}'")
        template = wasmTemplate
      }
      
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "ef-shd_hide": Struct.parse.boolean(data, "ef-shd_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-shd_template": template,
        "ef-shd_duration": Struct.parse.number(data, "ef-shd_duration", 5.0, 0.0, 9999.9),
        "ef-shd_fade-in": Struct.parse.number(data, "ef-shd_fade-in", 1.0, 0.0, 9999.9),
        "ef-shd_fade-out": Struct.parse.number(data, "ef-shd_fade-out", 1.0, 0.0, 9999.9),
        "ef-shd_alpha": Struct.parse.normalizedNumber(data, "ef-shd_alpha", 1.0),
        "ef-shd_pipeline": Struct.parse.enumerable(data, "ef-shd_pipeline", ShaderPipelineType, ShaderPipelineType.BACKGROUND),
        "ef-shd_use-merge-cfg": Struct.parse.boolean(data, "ef-shd_use-merge-cfg"),
        "ef-shd_hide-merge-cfg": Struct.parse.boolean(data, "ef-shd_hide-merge-cfg", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-shd_merge-cfg": Struct.getIfType(data, "ef-shd_merge-cfg", Struct, { }),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      static getPipeline = function(data, key) {
        var controller = Beans.get(BeanVisuController)
        var pipeline = Struct.get(data, key)
        switch (pipeline) {
          case ShaderPipelineType.BACKGROUND: return controller.shaderBackgroundPipeline
          case ShaderPipelineType.GRID: return controller.shaderPipeline
          case ShaderPipelineType.COMBINED: return controller.shaderCombinedPipeline
          default: 
            Logger.warn("Track", $"Found unsupported pipeline: {pipeline}. Return default: 'shaderBackgroundPipeline'")
            return controller.shaderBackgroundPipeline
        }
      }

      ///@description feature effect.shader.spawn
      getPipeline(data, "ef-shd_pipeline").send(new Event("spawn-shader", {
        template: Struct.get(data, "ef-shd_template"),
        duration: Struct.get(data, "ef-shd_duration"),
        fadeIn: Struct.get(data, "ef-shd_fade-in"),
        fadeOut: Struct.get(data, "ef-shd_fade-out"),
        alphaMax: Struct.get(data, "ef-shd_alpha"),
        mergeProperties: Struct.get(data, "ef-shd_use-merge-cfg") 
          ? Struct.get(data, "ef-shd_merge-cfg") 
          : null,
      }))
    },
  },
  "brush_effect_glitch": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "ef-glt_hide": Struct.parse.boolean(data, "ef-glt_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-glt_hide-cfg": Struct.parse.boolean(data, "ef-glt_hide-cfg", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-glt_hide-line": Struct.parse.boolean(data, "ef-glt_hide-line", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-glt_hide-jumb": Struct.parse.boolean(data, "ef-glt_hide-jumb", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-glt_hide-shd": Struct.parse.boolean(data, "ef-glt_hide-shd", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-glt_use-fade-out": Struct.parse.boolean(data, "ef-glt_use-fade-out"),
        "ef-glt_fade-out": Struct.parse.number(data, "ef-glt_fade-out", 0.01, 0.0, 1.0),
        "ef-glt_glitch": Struct.parse.enumerable(data, "ef-glt_glitch", GlitchType, GlitchType.COMBINED),
        "ef-glt_use-config": Struct.parse.boolean(data, "ef-glt_use-config"),
        "ef-glt_line-spd": Struct.parse.number(data, "ef-glt_line-spd", 0.01, 0.0, 0.5),
        "ef-glt_line-shift": Struct.parse.number(data, "ef-glt_line-shift", 0.004, 0.0, 0.05),
        "ef-glt_line-res": Struct.parse.number(data, "ef-glt_line-res", 1.0, 0.0, 3.0),
        "ef-glt_line-v-shift": Struct.parse.number(data, "ef-glt_line-v-shift", 0.0, 0.0, 1.0),
        "ef-glt_line-drift": Struct.parse.number(data, "ef-glt_line-drift", 0.1, 0.0, 1.0),
        "ef-glt_jumb-spd": Struct.parse.number(data, "ef-glt_jumb-spd", 1.0, 0.0, 25.0),
        "ef-glt_jumb-shift": Struct.parse.number(data, "ef-glt_jumb-shift", 0.15, 0.0, 1.0),
        "ef-glt_jumb-res": Struct.parse.number(data, "ef-glt_jumb-res", 0.2, 0.0, 1.0),
        "ef-glt_jumb-chaos": Struct.parse.number(data, "ef-glt_jumb-chaos", 0.2, 0.0, 1.0),
        "ef-glt_shd-dispersion": Struct.parse.number(data, "ef-glt_shd-dispersion", 0.0025, 0.0, 0.5),
        "ef-glt_shd-ch-shift": Struct.parse.number(data, "ef-glt_shd-ch-shift", 0.004, 0.0, 0.05),
        "ef-glt_shd-noise": Struct.parse.number(data, "ef-glt_shd-noise", 0.5, 0.0, 1.0),
        "ef-glt_shd-shakiness": Struct.parse.number(data, "ef-glt_shd-shakiness", 0.5, 0.0, 10.0),
        "ef-glt_shd-rng-seed": Struct.parse.number(data, "ef-glt_shd-rng-seed", 0.0, 0.0, 1.0),
        "ef-glt_shd-intensity": Struct.parse.number(data, "ef-glt_shd-intensity", 1.0, 0.0, 5.0),
      }
    },
    run: function(data, channel) {
      static getGlitch = function(data, key) {
        var controller = Beans.get(BeanVisuController)
        var gridRenderer = controller.visuRenderer.gridRenderer
        var glitch = Struct.get(data, key)
        switch (glitch) {
          case GlitchType.BACKGROUND: return gridRenderer.backgroundGlitchService
          case GlitchType.GRID: return gridRenderer.gridGlitchService
          case GlitchType.COMBINED: return gridRenderer.combinedGlitchService
          default: 
            Logger.warn("Track", $"Found unsupported glitch: {glitch}. Return default: 'combinedGlitchService'")
            return gridRenderer.combinedGlitchService
        }
      }

      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var pump = getGlitch(data, "ef-glt_glitch").dispatcher

      ///@description feature TODO effect.glitch.config
      if (Struct.get(data, "ef-glt_use-config")) {
        pump.execute(new Event("load-config", {
          lineSpeed: {
            defValue: Struct.get(data, "ef-glt_line-spd"),
            minValue: 0.0,
            maxValue: 0.5,
          },
          lineShift: {
            defValue: Struct.get(data, "ef-glt_line-shift"),
            minValue: 0.0,
            maxValue: 0.05,
          },
          lineResolution: {
            defValue: Struct.get(data, "ef-glt_line-res"),
            minValue: 0.0,
            maxValue: 3.0,
          },
          lineVertShift: {
            defValue: Struct.get(data, "ef-glt_line-v-shift"),
            minValue: 0.0,
            maxValue: 1.0,
          },
          lineDrift: {
            defValue: Struct.get(data, "ef-glt_line-drift"),
            minValue: 0.0,
            maxValue: 1.0,
          },
          jumbleSpeed: {
            defValue: Struct.get(data, "ef-glt_jumb-spd"),
            minValue: 0.0,
            maxValue: 25.0,
          },
          jumbleShift: {
            defValue: Struct.get(data, "ef-glt_jumb-shift"),
            minValue: 0.0,
            maxValue: 1.0,
          },
          jumbleResolution: {
            defValue: Struct.get(data, "ef-glt_jumb-res"),
            minValue: 0.0,
            maxValue: 1.0,
          },
          jumbleness: {
            defValue: Struct.get(data, "ef-glt_jumb-chaos"),
            minValue: 0.0,
            maxValue: 1.0,
          },
          dispersion: {
            defValue: Struct.get(data, "ef-glt_shd-dispersion"),
            minValue: 0.0,
            maxValue: 0.5,
          },
          channelShift: {
            defValue: Struct.get(data, "ef-glt_shd-ch-shift"),
            minValue: 0.0,
            maxValue: 0.05,
          },
          noiseLevel: {
            defValue: Struct.get(data, "ef-glt_shd-noise"),
            minValue: 0.0,
            maxValue: 1.0,
          },
          shakiness: {
            defValue: Struct.get(data, "ef-glt_shd-shakiness"),
            minValue: 0.0,
            maxValue: 10.0,
          },
          rngSeed: {
            defValue: Struct.get(data, "ef-glt_shd-rng-seed"),
            minValue: 0.0,
            maxValue: 1.0,
          },
          intensity: {
            defValue: Struct.get(data, "ef-glt_shd-intensity"),
            minValue: 0.0,
            maxValue: 5.0,
          },
        }))
      }

      ///@description feature TODO effect.glitch.spawn
      pump.execute(new Event("spawn-glitch", { 
        factor: (Struct.get(data, "ef-glt_use-fade-out")  ///@todo NumberTransformer
          ? (Struct.get(data, "ef-glt_fade-out") / 100.0) 
          : 0.0),
        rng: !Struct.get(data, "ef-glt_use-config"),
      }))
    },
  },
  "brush_effect_particle": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "ef-part_hide": Struct.parse.boolean(data, "ef-part_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-part_preview": Struct.parse.boolean(data, "ef-part_preview"),
        "ef-part_template": Struct.parse.text(data, "ef-part_template", "particle-default"),
        "ef-part_hide-area": Struct.parse.boolean(data, "ef-part_hide-area", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-part_area": Struct.parse.rectangle(data, "ef-part_area", { width: 1.0, height: 1.0 }),
        "ef-part_amount": Struct.parse.integer(data, "ef-part_amount", 1, 1, 999),
        "ef-part_duration": Struct.parse.number(data, "ef-part_duration", 0.0, 0, 999.9),
        "ef-part_interval": Struct.parse.number(data, "ef-part_interval", 0.0, 0, 999.9),
        "ef-part_shape": Struct.parse.enumerableKey(data, "ef-part_shape", 
          ParticleEmitterShape, ParticleEmitterShape.RECTANGLE),
        "ef-part_distribution": Struct.parse.enumerableKey(data, "ef-part_distribution",
          ParticleEmitterDistribution, ParticleEmitterDistribution.LINEAR),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var particleService = controller.particleService
      var area = Struct.get(data, "ef-part_area")

      ///@description feature TODO effect.particle.spawn
      particleService.spawnParticleEmitter(
        "main",
        Struct.get(data, "ef-part_template"),
        (area.getX() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
        (area.getY() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
        (area.getX() + area.getWidth() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
        (area.getY() + area.getHeight() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
        Struct.get(data, "ef-part_duration"),
        Struct.get(data, "ef-part_amount"),
        Struct.get(data, "ef-part_interval"),
        ParticleEmitterShape.get(Struct.get(data, "ef-part_shape")),
        ParticleEmitterDistribution.get(Struct.get(data, "ef-part_distribution"))
      )
      
      /*
      particleService.send(particleService
        .factoryEventSpawnParticleEmitter(
          {
            particleName: Struct.get(data, "ef-part_template"),
            beginX: (area.getX() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
            beginY: (area.getY() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
            endX: (area.getX() + area.getWidth() + 0.5) * GRID_SERVICE_PIXEL_WIDTH,
            endY: (area.getY() + area.getHeight() + 0.5) * GRID_SERVICE_PIXEL_HEIGHT,
            duration: Struct.get(data, "ef-part_duration"),
            amount: Struct.get(data, "ef-part_amount"),
            interval: Struct.get(data, "ef-part_interval"),
            shape: ParticleEmitterShape.get(Struct.get(data, "ef-part_shape")),
            distribution: ParticleEmitterDistribution.get(Struct.get(data, "ef-part_distribution")),
          }, 
        ))
      */
    },
  },
  "brush_effect_config": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "ef-cfg_hide-render": Struct.parse.boolean(data, "ef-cfg_hide-render", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-cfg_hide-cls": Struct.parse.boolean(data, "ef-cfg_hide-cls", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-cfg_hide-cfg": Struct.parse.boolean(data, "ef-cfg_hide-cfg", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-cfg_hide-shd-cls-col": Struct.parse.boolean(data, "ef-cfg_hide-shd-cls-col", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-cfg_hide-shd-cls-alpha": Struct.parse.boolean(data, "ef-cfg_hide-shd-cls-alpha", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-cfg_hide-particle-z": Struct.parse.boolean(data, "ef-cfg_hide-particle-z", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "ef-cfg_use-render-shd-bkg": Struct.parse.boolean(data, "ef-cfg_use-render-shd-bkg"),
        "ef-cfg_render-shd-bkg": Struct.parse.boolean(data, "ef-cfg_render-shd-bkg"),
        "ef-cfg_cls-shd-bkg": Struct.parse.boolean(data, "ef-cfg_cls-shd-bkg"),
        "ef-cfg_use-render-shd-gr": Struct.parse.boolean(data, "ef-cfg_use-render-shd-gr"),
        "ef-cfg_render-shd-gr": Struct.parse.boolean(data, "ef-cfg_render-shd-gr"),
        "ef-cfg_cls-shd-gr": Struct.parse.boolean(data, "ef-cfg_cls-shd-gr"),
        "ef-cfg_use-render-shd-all": Struct.parse.boolean(data, "ef-cfg_use-render-shd-all"),
        "ef-cfg_render-shd-all": Struct.parse.boolean(data, "ef-cfg_render-shd-all"),
        "ef-cfg_cls-shd-all": Struct.parse.boolean(data, "ef-cfg_cls-shd-all"),
        "ef-cfg_use-render-bkg-glt": Struct.parse.boolean(data, "ef-cfg_use-render-bkg-glt"),
        "ef-cfg_render-bkg-glt": Struct.parse.boolean(data, "ef-cfg_render-bkg-glt"),
        "ef-cfg_cls-bkg-glt": Struct.parse.boolean(data, "ef-cfg_cls-bkg-glt"),
        "ef-cfg_use-render-gr-glt": Struct.parse.boolean(data, "ef-cfg_use-render-gr-glt"),
        "ef-cfg_render-gr-glt": Struct.parse.boolean(data, "ef-cfg_render-gr-glt"),
        "ef-cfg_cls-gr-glt": Struct.parse.boolean(data, "ef-cfg_cls-gr-glt"),
        "ef-cfg_use-render-glt": Struct.parse.boolean(data, "ef-cfg_use-render-glt"),
        "ef-cfg_render-glt": Struct.parse.boolean(data, "ef-cfg_render-glt"),
        "ef-cfg_cls-glt": Struct.parse.boolean(data, "ef-cfg_cls-glt"),
        "ef-cfg_use-render-part": Struct.parse.boolean(data, "ef-cfg_use-render-part"),
        "ef-cfg_render-part": Struct.parse.boolean(data, "ef-cfg_render-part"),
        "ef-cfg_cls-part": Struct.parse.boolean(data, "ef-cfg_cls-part"),
        "ef-cfg_use-cls-frame": Struct.parse.boolean(data, "ef-cfg_use-cls-frame"),
        "ef-cfg_cls-frame": Struct.parse.boolean(data, "ef-cfg_cls-frame"),
        "ef-cfg_use-cls-frame-col": Struct.parse.boolean(data, "ef-cfg_use-cls-frame-col"),
        "ef-cfg_cls-frame-col": Struct.parse.color(data, "ef-cfg_cls-frame-col"),
        "ef-cfg_cls-frame-col-spd": Struct.parse.number(data, "ef-cfg_cls-frame-col-spd", 1.0, 0.0, 999.9),
        "ef-cfg_cls-frame-alpha": Struct.parse.normalizedNumberTransformer(data, "ef-cfg_cls-frame-alpha"),
        "ef-cfg_use-cls-frame-alpha": Struct.parse.boolean(data, "ef-cfg_use-cls-frame-alpha"),
        "ef-cfg_change-cls-frame-alpha": Struct.parse.boolean(data, "ef-cfg_change-cls-frame-alpha"),
        "ef-cfg_use-particle-z": Struct.parse.boolean(data, "ef-cfg_use-particle-z", false),
        "ef-cfg_particle-z": Struct.parse.numberTransformer(data, "ef-cfg_particle-z", {
          value: 2045,
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "ef-cfg_change-particle-z": Struct.parse.boolean(data, "ef-cfg_change-particle-z", false),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var gridService = controller.gridService
      var properties = gridService.properties
      var pump = gridService.dispatcher
      var executor = gridService.executor
      
      ///@description feature TODO effect.shader.bkg.render
      Visu.resolveBooleanTrackEvent(data,
        "ef-cfg_use-render-shd-bkg",
        "ef-cfg_render-shd-bkg",
        "renderBackgroundShaders",
        properties)

      ///@description feature TODO effect.shader.grid.render
      Visu.resolveBooleanTrackEvent(data,
        "ef-cfg_use-render-shd-gr",
        "ef-cfg_render-shd-gr",
        "renderGridShaders",
        properties)

      ///@description feature TODO effect.shader.all.render
      Visu.resolveBooleanTrackEvent(data,
        "ef-cfg_use-render-shd-all",
        "ef-cfg_render-shd-all",
        "renderCombinedShaders",
        properties)

      ///@description feature TODO effect.particle.clear
      Visu.resolveSendEventTrackEvent(data,
        "ef-cfg_cls-part",
        "clear-particles",
        null,
        controller.particleService.dispatcher)

      ///@description feature TODO effect.shader.all.render
      Visu.resolveBooleanTrackEvent(data,
        "ef-cfg_use-cls-frame",
        "ef-cfg_cls-frame",
        "shaderClearFrame",
        properties)

      ///@description feature TODO effect.shader.frame.color
      Visu.resolveColorTransformerTrackEvent(data, 
        "ef-cfg_use-cls-frame-col",
        "ef-cfg_cls-frame-col",
        "ef-cfg_cls-frame-col-spd",
        "shaderClearColor",
        properties, pump, executor)

      ///@description feature TODO effect.shader.frame.alpha
      Visu.resolveNumberTransformerTrackEvent(data, 
        "ef-cfg_use-cls-frame-alpha",
        "ef-cfg_cls-frame-alpha",
        "ef-cfg_change-cls-frame-alpha",
        "shaderClearFrameAlpha",
        properties, pump, executor)

      ///@description feature TODO shader-pipeline.background.clear
      Visu.resolveSendEventTrackEvent(data, 
        "ef-cfg_cls-shd-bkg",
        "clear-shaders",
        null,
        controller.shaderBackgroundPipeline.dispatcher)

      ///@description feature TODO shader-pipeline.grid.clear
      Visu.resolveSendEventTrackEvent(data, 
        "ef-cfg_cls-shd-gr",
        "clear-shaders",
        null,
        controller.shaderPipeline.dispatcher)

      ///@description feature TODO shader-pipeline.all.clear
      Visu.resolveSendEventTrackEvent(data, 
        "ef-cfg_cls-shd-all",
        "clear-shaders",
        null,
        controller.shaderCombinedPipeline.dispatcher)

      ///@description feature TODO grid.z
      Visu.resolveNumberTransformerTrackEvent(data, 
        "ef-cfg_use-particle-z",
        "ef-cfg_particle-z",
        "ef-cfg_change-particle-z",
        "particleZ",
        properties.depths, pump, executor)

      ///@description feature TODO effect.glitch.bkg.render
      Visu.resolveBooleanTrackEvent(data,
        "ef-cfg_use-render-bkg-glt",
        "ef-cfg_render-bkg-glt",
        "renderBackgroundGlitch",
        properties)

      ///@description feature TODO effect.glitch.bkg.clear
      Visu.resolveExecuteEventTrackEvent(data,
        "ef-cfg_cls-bkg-glt",
        "clear-glitch",
        null,
        controller.visuRenderer.gridRenderer.backgroundGlitchService.dispatcher)
        
      ///@description feature TODO effect.glitch.grid.render
      Visu.resolveBooleanTrackEvent(data,
        "ef-cfg_use-render-gr-glt",
        "ef-cfg_render-gr-glt",
        "renderGridGlitch",
        properties)

      ///@description feature TODO effect.glitch.grid.clear
      Visu.resolveExecuteEventTrackEvent(data,
        "ef-cfg_cls-gr-glt",
        "clear-glitch",
        null,
        controller.visuRenderer.gridRenderer.gridGlitchService.dispatcher)
      
      ///@description feature TODO effect.glitch.combined.render
      Visu.resolveBooleanTrackEvent(data,
        "ef-cfg_use-render-glt",
        "ef-cfg_render-glt",
        "renderCombinedGlitch",
        properties)

      ///@description feature TODO effect.glitch.combined.clear
      Visu.resolveExecuteEventTrackEvent(data,
        "ef-cfg_cls-glt",
        "clear-glitch",
        null,
        controller.visuRenderer.gridRenderer.combinedGlitchService.dispatcher)
    },
  },
}
#macro effect_track_event global.__effect_track_event