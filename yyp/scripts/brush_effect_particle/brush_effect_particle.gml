///@package io.alkapivo.visu.editor.service.brush.effect

///@param {Struct} json
///@return {Struct}
function brush_effect_particle(json) {
  return {
    name: "brush_effect_particle",
    store: new Map(String, Struct, {
      "ef-part_hide": {
        type: Boolean,
        value: Struct.get(json, "ef-part_hide"),
      },
      "ef-part_preview": {
        type: Boolean,
        value: Struct.get(json, "ef-part_preview"),
      },
      "ef-part_template": {
        type: String,
        value: Struct.get(json, "ef-part_template"),
        passthrough: UIUtil.passthrough.getCallbackValue(),
        data: {
          callback: Beans.get(BeanVisuController).particleTemplateExists,
          defaultValue: "particle-default",
        },
      },
      "ef-part_hide-area": {
        type: Boolean,
        value: Struct.get(json, "ef-part_hide-area"),
      },
      "ef-part_area": {
        type: Rectangle,
        value: Struct.get(json, "ef-part_area"),
        passthrough: function(value) {
          value.x = clamp(value.x, -5.0, 5.0)
          value.y = clamp(value.y, -5.0, 5.0)
          value.z = clamp(value.z, 0.0, 10.0)
          value.a = clamp(value.a, 0.0, 10.0)
          return value
        }
      },
      "ef-part_amount": {
        type: Number,
        value: Struct.get(json, "ef-part_amount"),
        passthrough: UIUtil.passthrough.getClampedStringInteger(),
        data: new Vector2(1, 999),
      },
      "ef-part_duration": {
        type: Number,
        value: Struct.get(json, "ef-part_duration"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "ef-part_interval": {
        type: Number,
        value: Struct.get(json, "ef-part_interval"),
        passthrough: UIUtil.passthrough.getClampedStringNumber(),
        data: new Vector2(0.0, 999.9),
      },
      "ef-part_shape": {
        type: String,
        value: Struct.get(json, "ef-part_shape"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: ParticleEmitterShape.keys(),
      },
      "ef-part_distribution": {
        type: String,
        value: Struct.get(json, "ef-part_distribution"),
        passthrough: UIUtil.passthrough.getArrayValue(),
        data: ParticleEmitterDistribution.keys(),
      },
    }),
    components: new Array(Struct, [
      VETitleComponent("ef-part_properties", {
        label: { text: "Properties" },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-part_hide" },
        },
      }),
      VETextInputComponent("ef-part_template", {
        hidden: { key: "ef-part_hide" },
        store: { key: "ef-part_template" },
        value: { text: "Template" },
      }),
      VELineHComponent("ef-part_template-line-h", {
        hidden: { key: "ef-part_hide" },
      }),
      VETitleComponent("ef-part_area-title", {
        hidden: { key: "gr-c_hide-side" },
        enable: { key: "gr-c_use-side-col" },
        label: { 
          text: "Emitter",
          updateCustom: function() {
            this.preRender()
            if (Core.isType(this.context.updateTimer, Timer)) {
              var inspectorType = this.context.state.get("inspectorType")
              switch (inspectorType) {
                case VEEventInspector:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  if (shroomService.particleAreaEvent != null) {
                    shroomService.particleAreaEvent.timeout = ceil(this.context.updateTimer.duration * 60)
                  }
                  break
                case VEBrushToolbar:
                  var shroomService = Beans.get(BeanVisuController).shroomService
                  if (shroomService.particleArea != null) {
                    shroomService.particleArea.timeout = ceil(this.context.updateTimer.duration * 60)
                  }
                  break
              }
            }
          },
          preRender: function() {
            var store = null
            if (Core.isType(this.context.state.get("brush"), VEBrush)) {
              store = this.context.state.get("brush").store
            }
            
            if (Core.isType(this.context.state.get("event"), VEEvent)) {
              store = this.context.state.get("event").store
            }

            if (!Optional.is(store) || !store.getValue("ef-part_preview")) {
              return
            }

            var area = store.getValue("ef-part_area")
            if (!Core.isType(area, Rectangle)) {
              return
            }

            var inspectorType = this.context.state.get("inspectorType")
            switch (inspectorType) {
              case VEEventInspector:
                var shroomService = Beans.get(BeanVisuController).shroomService
                shroomService.particleAreaEvent = {
                  topLeft: shroomService.factorySpawner({
                    x: area.getX() + 0.5,
                    y: area.getY() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                  }),
                  topRight: shroomService.factorySpawner({
                    x: area.getX() + area.getWidth() + 0.5,
                    y: area.getY() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                  }),
                  bottomLeft: shroomService.factorySpawner({
                    x: area.getX() + 0.5,
                    y: area.getY() + area.getHeight() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                  }),
                  bottomRight: shroomService.factorySpawner({
                    x: area.getX() + area.getWidth() + 0.5,
                    y: area.getY() + area.getHeight() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_bazyl" }),
                  }),
                  timeout: 5.0,
                }
                break
              case VEBrushToolbar:
                var shroomService = Beans.get(BeanVisuController).shroomService
                shroomService.particleArea = {
                  topLeft: shroomService.factorySpawner({
                    x: area.getX() + 0.5,
                    y: area.getY() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_baron" }),
                  }),
                  topRight: shroomService.factorySpawner({
                    x: area.getX() + area.getWidth() + 0.5,
                    y: area.getY() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_baron" }),
                  }),
                  bottomLeft: shroomService.factorySpawner({
                    x: area.getX() + 0.5,
                    y: area.getY() + area.getHeight() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_baron" }),
                  }),
                  bottomRight: shroomService.factorySpawner({
                    x: area.getX() + area.getWidth() + 0.5,
                    y: area.getY() + area.getHeight() + 0.5,
                    sprite: SpriteUtil.parse({ name: "texture_baron" }),
                  }),
                  timeout: 5.0,
                }
                break
            }
          },
        },
        input: { },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_show" },
          spriteOff: { name: "visu_texture_checkbox_hide" },
          store: { key: "ef-part_hide-area" },
        },
      }),
      VENumberInputComponent("ef-part_amount", {
        hidden: { key: "ef-part_hide-area" },
        store: { key: "ef-part_amount" },
        value: {
          text: "Amount",
          factor: 1.0,
          GMTF_DECIMAL: 0,
          stick: {
            factor: 1.0,
            step: 10.0,
          },
        },
        checkbox: { },
      }),
      VENumberInputComponent("ef-part_duration", {
        hidden: { key: "ef-part_hide-area" },
        store: { key: "ef-part_duration" },
        value: {
          text: "Duration",
          factor: 0.01,
          stick: { factor: 0.01 },
        },
        checkbox: { },
      }),
      VENumberInputComponent("ef-part_interval", {
        hidden: { key: "ef-part_hide-area" },
        store: { key: "ef-part_interval" },
        value: {
          text: "Interval",
          factor: 0.001,
          stick: { factor: 0.001 },
        },
        checkbox: { },
      }),
      VELineHComponent("ef-part_interval-line-h", {
        hidden: { key: "ef-part_hide-area" },
      }),
      VESpinSelectComponent("ef-part_shape", {
        hidden: { key: "ef-part_hide-area" },
        store: { key: "ef-part_shape" },
        layout: { margin: { top: 2, bottom: 2 } },
        label: { text: "Shape" },
      }),
      VESpinSelectComponent("ef-part_distribution", {
        hidden: { key: "ef-part_hide-area" },
        store: { key: "ef-part_distribution" },
        layout: { margin: { top: 2, bottom: 2 } },
        label: { text: "Distribution" },
      }),
      VELineHComponent("ef-part_distribution-line-h", {
        hidden: { key: "ef-part_hide-area" },
      }),
      VETitleComponent("ef-part_preview", {
        background: VETheme.color.side,
        hidden: { key: "ef-part_hide-area" },
        enable: { key: "ef-part_preview" },
        label: { text: "Show emitter" },
        checkbox: {
          spriteOn: { name: "visu_texture_checkbox_on" },
          spriteOff: { name: "visu_texture_checkbox_off" },
          store: { key: "ef-part_preview" },
        },
        input: { },
      }),
      {
        name: "ef-part_area",
        template: VEComponents.get("vec4-slider-increase"),
        layout: VELayouts.get("vec4"),
        config: { 
          layout: { 
            type: UILayoutType.VERTICAL,
            margin: { top: 4 },
          },
          x: {
            label: {
              text: "X",
              hidden: { key: "ef-part_hide-area" },
            },
            field: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            slider: {
              snapValue: 0.01 / 10.0,
              minValue: -5.0,
              maxValue: 5.0,
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            decrease: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: -0.01,
            },
            increase: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: 0.01,
            },
          },
          y: {
            label: {
              text: "Y",
              hidden: { key: "ef-part_hide-area" },
            },
            field: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            slider: {
              snapValue: 0.01 / 10.0,
              minValue: -5.0,
              maxValue: 5.0,
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            decrease: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: -0.01,
            },
            increase: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: 0.01,
            },
          },
          z: {
            label: {
              text: "Width",
              hidden: { key: "ef-part_hide-area" },
            },
            field: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            slider: {
              snapValue: 0.01 / 10.0,
              minValue: 0.0,
              maxValue: 10.0,
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            decrease: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: -0.01,
            },
            increase: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: 0.01,
            },
          },
          a: {
            label: {
              text: "Height",
              hidden: { key: "ef-part_hide-area" },
            },
            field: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            slider: {
              snapValue: 0.01 / 10.0,
              minValue: 0.0,
              maxValue: 10.0,
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
            },
            decrease: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: -0.01,
            },
            increase: {
              store: { key: "ef-part_area" },
              hidden: { key: "ef-part_hide-area" },
              factor: 0.01,
            },
          },
        },
      },
    ]),
  }
}