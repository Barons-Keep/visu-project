
///@type {Number}
#macro SHROOM_SPAWN_AMOUNT 50

///@type {Number}
#macro SHROOM_SPAWN_SIZE 8

///@type {Struct}
global.__entity_track_event = {
  "brush_entity_shroom": {
    parse: function(data) {
      var emitterConfig = Struct.getIfType(data, "en-shr_em-cfg", Struct)
      if (emitterConfig == null) {
        emitterConfig = {
          amount: 1,
          duration: 0,
          //arrays: 1,
          arrays: {
            value: 1,
            target: 1,
            duration: 0,
            ease: "LINEAR",
          },
          //perArray: 1,
          perArray: {
            value: 1,
            target: 1,
            duration: 0,
            ease: "LINEAR",
          },
          angle: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          angleRng: 0,
          //angleRng: {
          //  value: 0,
          //  target: 0,
          //  duration: 0,
          //  ease: "LINEAR",
          //},
          //angleStep: 0,
          angleStep: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          //anglePerArray: 0,
          anglePerArray: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          anglePerArrayRng: 0,
          //anglePerArrayRng: {
          //  value: 0,
          //  target: 0,
          //  duration: 0,
          //  ease: "LINEAR",
          //},
          //anglePerArrayStep: 0,
          anglePerArrayStep: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          speed: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          speedRng: 0,
          //speedRng: {
          //  value: 0,
          //  target: 0,
          //  duration: 0,
          //  ease: "LINEAR",
          //},
          offset: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          offsetX: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          offsetY: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          wiggleFrequency: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          wiggleAmplitude: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
        }
      }

      var oldEmitter = null
      if (Struct.get(data, "en-shr_em-use-cfg") == false) {
        oldEmitter = {
          "en-shr_em-amount": Struct.parse.number(data, "en-shr_em-amount", 1.0),
          "en-shr_em-arrays": Struct.parse.number(data, "en-shr_em-arrays", 1.0),
          "en-shr_em-angle": Struct.parse.numberTransformer(data, "en-shr_em-angle", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-shr_em-use-angle": Struct.parse.boolean(data, "en-shr_em-use-angle"),
          "en-shr_em-change-angle": Struct.parse.boolean(data, "en-shr_em-change-angle"),
          "en-shr_em-angle-rng": Struct.parse.number(data, "en-shr_em-angle-rng"),
          "en-shr_em-use-angle-rng": Struct.parse.boolean(data, "en-shr_em-use-angle-rng"),
          "en-shr_em-angle-step": Struct.parse.number(data, "en-shr_em-angle-step"),
          "en-shr_em-per-array": Struct.parse.number(data, "en-shr_em-per-array", 1.0),
          "en-shr_em-per-array-dir": Struct.parse.numberTransformer(data, "en-shr_em-per-array-dir", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-shr_em-use-per-array-dir": Struct.parse.boolean(data, "en-shr_em-use-per-array-dir"),
          "en-shr_em-change-per-array-dir": Struct.parse.boolean(data, "en-shr_em-change-per-array-dir"),
          "en-shr_em-use-per-array-rng": Struct.parse.boolean(data, "en-shr_em-use-per-array-rng"),
          "en-shr_em-per-array-rng": Struct.parse.number(data, "en-shr_em-per-array-rng"),
          "en-shr_em-per-array-step": Struct.parse.number(data, "en-shr_em-per-array-step"),
          "en-shr_em-spd": Struct.parse.numberTransformer(data, "en-shr_em-spd", {
            clampValue: { from: 0, to: 99.9 },
            clampTarget: { from: 0, to: 99.9 },
          }),
          "en-shr_em-use-spd": Struct.parse.boolean(data, "en-shr_em-use-spd"),
          "en-shr_em-change-spd": Struct.parse.boolean(data, "en-shr_em-change-spd"),
          "en-shr_em-use-spd-rng": Struct.parse.boolean(data, "en-shr_em-use-spd-rng"),
          "en-shr_em-spd-rng": Struct.parse.number(data, "en-shr_em-spd-rng", 0.0),
          "en-shr_em-duration": Struct.parse.number(data, "en-shr_em-duration", 0.0),
          "en-shr_em-offset-x": Struct.parse.numberTransformer(data, "en-shr_em-offset-x", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-shr_em-use-offset-x": Struct.parse.boolean(data, "en-shr_em-use-offset-x"),
          "en-shr_em-change-offset-x": Struct.parse.boolean(data, "en-shr_em-change-offset-x"),
          "en-shr_em-offset-y": Struct.parse.numberTransformer(data, "en-shr_em-offset-y", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-shr_em-use-offset-y": Struct.parse.boolean(data, "en-shr_em-use-offset-y"),
          "en-shr_em-change-offset-y": Struct.parse.boolean(data, "en-shr_em-change-offset-y"),
          "en-shr_em-wiggle-freq": Struct.parse.numberTransformer(data, "en-shr_em-wiggle-freq", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-shr_em-use-wiggle-freq": Struct.parse.boolean(data, "en-shr_em-use-wiggle-freq"),
          "en-shr_em-change-wiggle-freq": Struct.parse.boolean(data, "en-shr_em-change-wiggle-freq"),
          "en-shr_em-wiggle-amp": Struct.parse.numberTransformer(data, "en-shr_em-wiggle-amp", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-shr_em-use-wiggle-amp": Struct.parse.boolean(data, "en-shr_em-use-wiggle-amp"),
          "en-shr_em-change-wiggle-amp": Struct.parse.boolean(data, "en-shr_em-change-wiggle-amp"),
        }
      }

      return Struct.append({
        "icon": Struct.parse.sprite(data, "icon"),
        "en-shr_hide": Struct.parse.boolean(data, "en-shr_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-spawn": Struct.parse.boolean(data, "en-shr_hide-spawn", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-inherit": Struct.parse.boolean(data, "en-shr_hide-inherit", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em": Struct.parse.boolean(data, "en-shr_hide-em", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),

        "en-shr_hide-em-cfg": Struct.parse.boolean(data, "en-shr_hide-em-cfg", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em-angle": Struct.parse.boolean(data, "en-shr_hide-em-angle", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em-per-array": Struct.parse.boolean(data, "en-shr_hide-em-per-array", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em-spd": Struct.parse.boolean(data, "en-shr_hide-em-spd", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em-offset-x": Struct.parse.boolean(data, "en-shr_hide-em-offset-x", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em-offset-y": Struct.parse.boolean(data, "en-shr_hide-em-offset-y", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em-wiggle-freq": Struct.parse.boolean(data, "en-shr_hide-em-wiggle-freq", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-shr_hide-em-wiggle-amp": Struct.parse.boolean(data, "en-shr_hide-em-wiggle-amp", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),

        "en-shr_preview": Struct.parse.boolean(data, "en-shr_preview"),
        "en-shr_template": Struct.parse.text(data, "en-shr_template", "shroom-default"),
        "en-shr_use-lifespan": Struct.parse.boolean(data, "en-shr_use-lifespan", false),
        "en-shr_lifespan": Struct.parse.number(data, "en-shr_lifespan", 15.0),
        "en-shr_use-hp": Struct.parse.boolean(data, "en-shr_use-hp", false),
        "en-shr_hp": Struct.parse.number(data, "en-shr_hp", 1.0),
        "en-shr_spd": Struct.parse.number(data, "en-shr_spd", 10.0, 0.0, 99.9),
        "en-shr_spd-grid": Struct.parse.boolean(data, "en-shr_spd-grid"),
        "en-shr_use-spd-rng": Struct.parse.boolean(data, "en-shr_use-spd-rng"),
        "en-shr_spd-rng": Struct.parse.number(data, "en-shr_spd-rng", 0.0, 0.0, 99.9),
        "en-shr_dir": Struct.parse.number(data, "en-shr_dir", 270.0, 0.0, 360.0),
        "en-shr_use-dir-rng": Struct.parse.boolean(data, "en-shr_use-dir-rng"),
        "en-shr_dir-rng": Struct.parse.number(data, "en-shr_dir-rng", 0.0, 0.0, 360.0),
        "en-shr_x": Struct.parse.number(data, "en-shr_x", 0.0, 
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0), 
          SHROOM_SPAWN_AMOUNT / 2.0),
        "en-shr_snap-x": Struct.parse.boolean(data, "en-shr_snap-x"),
        "en-shr_use-rng-x": Struct.parse.boolean(data, "en-shr_use-rng-x"),
        "en-shr_rng-x": Struct.parse.number(data, "en-shr_rng-x", 0.0, 
          0.0,
          SHROOM_SPAWN_AMOUNT),
        "en-shr_y": Struct.parse.number(data, "en-shr_y", 0.0,
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0),
          SHROOM_SPAWN_AMOUNT / 2.0),
        "en-shr_snap-y": Struct.parse.boolean(data, "en-shr_snap-y"),
        "en-shr_use-rng-y": Struct.parse.boolean(data, "en-shr_use-rng-y"),
        "en-shr_rng-y": Struct.parse.number(data, "en-shr_rng-y", 0.0,
          0.0,
          SHROOM_SPAWN_AMOUNT),
        "en-shr_use-inherit": Struct.parse.boolean(data, "en-shr_use-inherit"),
        "en-shr_inherit": Struct.getIfType(data, "en-shr_inherit", GMArray, [ ]),
        "en-shr_use-texture": Struct.parse.boolean(data, "en-shr_use-texture"),
        "en-shr_texture": Struct.parse.sprite(data, "en-shr_texture"),
        "en-shr_use-mask": Struct.parse.boolean(data, "en-shr_use-mask"),
        "en-shr_mask": Struct.parse.rectangle(data, "en-shr_mask"),
        "en-shr_use-em": Struct.parse.boolean(data, "en-shr_use-em"),
        "en-shr_em-cfg": emitterConfig,
        "en-shr_em-use-cfg": Struct.parse.boolean(data, "en-shr_em-use-cfg", true),
      }, oldEmitter, false)
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var spd = abs(Struct.get(data, "en-shr_spd")
        + (Struct.get(data, "en-shr_use-spd-rng")
          ? (random(Struct.get(data, "en-shr_spd-rng") / 2.0)
            * choose(1.0, -1.0))
          : 0.01))
        + (Struct.get(data, "en-shr_spd-grid")
          ? controller.gridService.properties.speed
          : 0.0)
      var angle = Math.normalizeAngle(Struct.get(data, "en-shr_dir")
        + (Struct.get(data, "en-shr_use-dir-rng")
          ? (random(Struct.get(data, "en-shr_dir-rng") / 2.0)
          * choose(1.0, -1.0))
        : 0.0)),
      var spawnX = Struct.get(data, "en-shr_x")
        * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
        + 0.5
        + (Struct.get(data, "en-shr_use-rng-x")
          ? (random(Struct.get(data, "en-shr_rng-x") / 2.0)
            * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0)
      var snapH = Struct.getDefault(data, "en-shr_snap-x", false)
      var spawnY = Struct.get(data, "en-shr_y")
        * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
        - 0.5
        + (Struct.get(data, "en-shr_use-rng-y")
          ? (random(Struct.get(data, "en-shr_rng-y") / 2.0)
            * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0)
      var snapV = Struct.getDefault(data, "en-shr_snap-y", false)
      var lifespan = Struct.get(data, "en-shr_use-lifespan") ? Struct.get(data, "en-shr_lifespan") : null
      var hp = Struct.get(data, "en-shr_use-hp") ? Struct.get(data, "en-shr_hp") : null
      var inherit = Struct.get(data, "en-shr_use-inherit") ? Struct.get(data, "en-shr_inherit") : null
      var template = Struct.get(data, "en-shr_template")
      if (Struct.get(data, "en-shr_use-em")) {
        var emitterConfig = (Struct.get(data, "en-shr_em-use-cfg") == false)
          ? {
            amount: Struct.get(data, "en-shr_em-amount"),
            arrays: Struct.get(data, "en-shr_em-arrays"),
            angle: Struct.get(data, "en-shr_em-use-angle")
              ? (Struct.get(data, "en-shr_em-change-angle")
                ? Struct.get(data, "en-shr_em-angle").serialize()
                : Struct.get(Struct.get(data, "en-shr_em-angle").serialize(), "value"))
              : 0.0,
            angleRng: Struct.get(data, "en-shr_em-use-angle-rng")
              ? Struct.get(data, "en-shr_em-angle-rng")
              : 0.0,
            angleStep: Struct.get(data, "en-shr_em-angle-step"),
            perArray: Struct.get(data, "en-shr_em-per-array"),
            anglePerArray: Struct.get(data, "en-shr_em-use-per-array-dir")
              ? (Struct.get(data, "en-shr_em-change-per-array-dir")
                ? Struct.get(data, "en-shr_em-per-array-dir").serialize()
                : Struct.get(Struct.get(data, "en-shr_em-per-array-dir").serialize(), "value"))
              : 0.0,
            anglePerArrayRng: Struct.get(data, "en-shr_em-use-per-array-rng")
              ? Struct.get(data, "en-shr_em-per-array-rng")
              : 0.0,
            anglePerArrayStep: Struct.get(data, "en-shr_em-per-array-step"),
            speed: Struct.get(data, "en-shr_em-use-spd")
              ? (Struct.get(data, "en-shr_em-change-spd")
                ? Struct.get(data, "en-shr_em-spd").serialize()
                : Struct.get(Struct.get(data, "en-shr_em-spd").serialize(), "value"))
              : 0.0,
            speedRng: Struct.get(data, "en-shr_em-use-spd-rng")
              ? Struct.get(data, "en-shr_em-spd-rng")
              : 0.0,
            duration: Struct.get(data, "en-shr_em-duration"),
            offsetX: Struct.get(data, "en-shr_em-use-offset-x")
              ? (Struct.get(data, "en-shr_em-change-offset-x")
                ? Struct.get(data, "en-shr_em-offset-x").serialize()
                : Struct.get(Struct.get(data, "en-shr_em-offset-x").serialize(), "value"))
              : 0.0,
            offsetY: Struct.get(data, "en-shr_em-use-offset-y")
              ? (Struct.get(data, "en-shr_em-change-offset-y")
                ? Struct.get(data, "en-shr_em-offset-y").serialize()
                : Struct.get(Struct.get(data, "en-shr_em-offset-y").serialize(), "value"))
              : 0.0,
            wiggleFrequency: Struct.get(data, "en-shr_em-use-wiggle-freq")
              ? (Struct.get(data, "en-shr_em-change-wiggle-freq")
                ? Struct.get(data, "en-shr_em-wiggle-freq").serialize()
                : Struct.get(Struct.get(data, "en-shr_em-wiggle-freq").serialize(), "value"))
              : 0.0,
            wiggleAmplitude: Struct.get(data, "en-shr_em-use-wiggle-amp")
              ? (Struct.get(data, "en-shr_em-change-wiggle-amp")
                ? Struct.get(data, "en-shr_em-wiggle-amp").serialize()
                : Struct.get(Struct.get(data, "en-shr_em-wiggle-amp").serialize(), "value"))
              : 0.0,
          } : Struct.get(data, "en-shr_em-cfg")

        controller.shroomService.spawnShroomEmitter({
          name: template,
          spawnX: spawnX,
          spawnY: spawnY,
          angle: angle,
          speed: spd,
          snapH: snapH,
          snapV: snapV,
          lifespan: lifespan,
          hp: hp,
          inherit: inherit
        }, emitterConfig)
      } else {
        controller.shroomService.spawnShroom(
          template,
          spawnX,
          spawnY,
          angle,
          spd,
          snapH,
          snapV,
          lifespan,
          hp,
          inherit
        )
      }
      

      ///@description ecs
      /*
      var controller = Beans.get(BeanVisuController)
      controller.gridECS.add(new GridEntity({
        type: GridEntityType.ENEMY,
        position: { 
          x: controller.gridService.view.x
            + (Struct.get(data, "en-shr_x") 
              * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) 
              + 0.5),
          y: controller.gridService.view.y
            + (Struct.get(data, "en-shr_y") 
              * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) 
              - 0.5),
        },
        velocity: { 
          speed: Struct.get(data, "en-shr_spd") / 1000, 
          angle: Struct.get(data, "en-shr_dir"),
        },
        renderSprite: { name: "texture_baron" },
      }))
      */
    },
  },
  "brush_entity_bullet": {
    parse: function(data) {
      var emitterConfig = Struct.getIfType(data, "en-blt_em-cfg", Struct)
      if (emitterConfig == null) {
        emitterConfig = {
          amount: 1,
          duration: 0,
          //arrays: 1,
          arrays: {
            value: 1,
            target: 1,
            duration: 0,
            ease: "LINEAR",
          },
          //perArray: 1,
          perArray: {
            value: 1,
            target: 1,
            duration: 0,
            ease: "LINEAR",
          },
          angle: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          angleRng: 0,
          //angleRng: {
          //  value: 0,
          //  target: 0,
          //  duration: 0,
          //  ease: "LINEAR",
          //},
          //angleStep: 0,
          angleStep: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          //anglePerArray: 0,
          anglePerArray: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          anglePerArrayRng: 0,
          //anglePerArrayRng: {
          //  value: 0,
          //  target: 0,
          //  duration: 0,
          //  ease: "LINEAR",
          //},
          //anglePerArrayStep: 0,
          anglePerArrayStep: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          speed: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          speedRng: 0,
          //speedRng: {
          //  value: 0,
          //  target: 0,
          //  duration: 0,
          //  ease: "LINEAR",
          //},
          offset: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          offsetX: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          offsetY: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          wiggleFrequency: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
          wiggleAmplitude: {
            value: 0,
            target: 0,
            duration: 0,
            ease: "LINEAR",
          },
        }
      }

      var oldEmitter = null
      if (Struct.get(data, "en-blt_em-use-cfg") == false) {
        oldEmitter = {
          "en-blt_em-amount": Struct.parse.number(data, "en-blt_em-amount", 1.0),
          "en-blt_em-arrays": Struct.parse.number(data, "en-blt_em-arrays", 1.0),
          "en-blt_em-angle": Struct.parse.numberTransformer(data, "en-blt_em-angle", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-blt_em-use-angle": Struct.parse.boolean(data, "en-blt_em-use-angle"),
          "en-blt_em-change-angle": Struct.parse.boolean(data, "en-blt_em-change-angle"),
          "en-blt_em-angle-rng": Struct.parse.number(data, "en-blt_em-angle-rng"),
          "en-blt_em-use-angle-rng": Struct.parse.boolean(data, "en-blt_em-use-angle-rng"),
          "en-blt_em-angle-step": Struct.parse.number(data, "en-blt_em-angle-step"),
          "en-blt_em-per-array": Struct.parse.number(data, "en-blt_em-per-array", 1.0),
          "en-blt_em-per-array-dir": Struct.parse.numberTransformer(data, "en-blt_em-per-array-dir", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-blt_em-use-per-array-dir": Struct.parse.boolean(data, "en-blt_em-use-per-array-dir"),
          "en-blt_em-change-per-array-dir": Struct.parse.boolean(data, "en-blt_em-change-per-array-dir"),
          "en-blt_em-use-per-array-rng": Struct.parse.boolean(data, "en-blt_em-use-per-array-rng"),
          "en-blt_em-per-array-rng": Struct.parse.number(data, "en-blt_em-per-array-rng"),
          "en-blt_em-per-array-step": Struct.parse.number(data, "en-blt_em-per-array-step"),
          "en-blt_em-spd": Struct.parse.numberTransformer(data, "en-blt_em-spd", {
            clampValue: { from: 0, to: 99.9 },
            clampTarget: { from: 0, to: 99.9 },
          }),
          "en-blt_em-use-spd": Struct.parse.boolean(data, "en-blt_em-use-spd"),
          "en-blt_em-change-spd": Struct.parse.boolean(data, "en-blt_em-change-spd"),
          "en-blt_em-use-spd-rng": Struct.parse.boolean(data, "en-blt_em-use-spd-rng"),
          "en-blt_em-spd-rng": Struct.parse.number(data, "en-blt_em-spd-rng", 0.0),
          "en-blt_em-duration": Struct.parse.number(data, "en-blt_em-duration", 0.0),
          "en-blt_em-offset-x": Struct.parse.numberTransformer(data, "en-blt_em-offset-x", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-blt_em-use-offset-x": Struct.parse.boolean(data, "en-blt_em-use-offset-x"),
          "en-blt_em-change-offset-x": Struct.parse.boolean(data, "en-blt_em-change-offset-x"),
          "en-blt_em-offset-y": Struct.parse.numberTransformer(data, "en-blt_em-offset-y", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-blt_em-use-offset-y": Struct.parse.boolean(data, "en-blt_em-use-offset-y"),
          "en-blt_em-change-offset-y": Struct.parse.boolean(data, "en-blt_em-change-offset-y"),
          "en-blt_em-wiggle-freq": Struct.parse.numberTransformer(data, "en-blt_em-wiggle-freq", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-blt_em-use-wiggle-freq": Struct.parse.boolean(data, "en-blt_em-use-wiggle-freq"),
          "en-blt_em-change-wiggle-freq": Struct.parse.boolean(data, "en-blt_em-change-wiggle-freq"),
          "en-blt_em-wiggle-amp": Struct.parse.numberTransformer(data, "en-blt_em-wiggle-amp", {
            clampValue: { from: -99999.9, to: 99999.9 },
            clampTarget: { from: -99999.9, to: 99999.9 },
          }),
          "en-blt_em-use-wiggle-amp": Struct.parse.boolean(data, "en-blt_em-use-wiggle-amp"),
          "en-blt_em-change-wiggle-amp": Struct.parse.boolean(data, "en-blt_em-change-wiggle-amp"),
        }
      }

      return Struct.append({
        "icon": Struct.parse.sprite(data, "icon"),
        "en-blt_hide": Struct.parse.boolean(data, "en-blt_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-spawn": Struct.parse.boolean(data, "en-blt_hide-spawn", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em": Struct.parse.boolean(data, "en-blt_hide-em", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),

        "en-blt_hide-em-cfg": Struct.parse.boolean(data, "en-blt_hide-em-cfg", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em-angle": Struct.parse.boolean(data, "en-blt_hide-em-angle", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em-per-array": Struct.parse.boolean(data, "en-blt_hide-em-per-array", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em-spd": Struct.parse.boolean(data, "en-blt_hide-em-spd", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em-offset-x": Struct.parse.boolean(data, "en-blt_hide-em-offset-x", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em-offset-y": Struct.parse.boolean(data, "en-blt_hide-em-offset-y", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em-wiggle-freq": Struct.parse.boolean(data, "en-blt_hide-em-wiggle-freq", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-blt_hide-em-wiggle-amp": Struct.parse.boolean(data, "en-blt_hide-em-wiggle-amp", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),

        "en-blt_preview": Struct.parse.boolean(data, "en-blt_preview"),
        "en-blt_template": Struct.parse.text(data, "en-blt_template", "bullet-default"),
        "en-blt_use-lifespan": Struct.parse.boolean(data, "en-blt_use-lifespan", false),
        "en-blt_lifespan": Struct.parse.number(data, "en-blt_lifespan", 15.0),
        "en-blt_use-dmg": Struct.parse.boolean(data, "en-blt_use-dmg", false),
        "en-blt_dmg": Struct.parse.number(data, "en-blt_dmg", 1.0),
        "en-blt_spd": Struct.parse.number(data, "en-blt_spd", 10.0, 0.0, 99.9),
        "en-blt_spd-grid": Struct.parse.boolean(data, "en-blt_spd-grid"),
        "en-blt_use-spd-rng": Struct.parse.boolean(data, "en-blt_use-spd-rng"),
        "en-blt_spd-rng": Struct.parse.number(data, "en-blt_spd-rng", 0.0, 0.0, 99.9),
        "en-blt_dir": Struct.parse.number(data, "en-blt_dir", 270.0, 0.0, 360.0),
        "en-blt_use-dir-rng": Struct.parse.boolean(data, "en-blt_use-dir-rng"),
        "en-blt_dir-rng": Struct.parse.number(data, "en-blt_dir-rng", 0.0, 0.0, 360.0),
        "en-blt_x": Struct.parse.number(data, "en-blt_x", 0.0, 
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0), 
          SHROOM_SPAWN_AMOUNT / 2.0),
        "en-blt_snap-x": Struct.parse.boolean(data, "en-blt_snap-x"),
        "en-blt_use-rng-x": Struct.parse.boolean(data, "en-blt_use-rng-x"),
        "en-blt_rng-x": Struct.parse.number(data, "en-blt_rng-x", 0.0, 
          0.0,
          SHROOM_SPAWN_AMOUNT),
        "en-blt_y": Struct.parse.number(data, "en-blt_y", 0.0,
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0),
          SHROOM_SPAWN_AMOUNT / 2.0),
        "en-blt_snap-y": Struct.parse.boolean(data, "en-blt_snap-y"),
        "en-blt_use-rng-y": Struct.parse.boolean(data, "en-blt_use-rng-y"),
        "en-blt_rng-y": Struct.parse.number(data, "en-blt_rng-y", 0.0,
          0.0,
          SHROOM_SPAWN_AMOUNT),
        "en-blt_use-texture": Struct.parse.boolean(data, "en-blt_use-texture"),
        "en-blt_texture": Struct.parse.sprite(data, "en-blt_texture"),
        "en-blt_use-mask": Struct.parse.boolean(data, "en-blt_use-mask"),
        "en-blt_mask": Struct.parse.rectangle(data, "en-blt_mask"),
        "en-blt_use-em": Struct.parse.boolean(data, "en-blt_use-em"),
        "en-blt_em-cfg": emitterConfig,
        "en-blt_em-use-cfg": Struct.parse.boolean(data, "en-blt_em-use-cfg", true),
      }, oldEmitter, false)
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var spd = abs(Struct.get(data, "en-blt_spd")
        + (Struct.get(data, "en-blt_use-spd-rng")
          ? (random(Struct.get(data, "en-blt_spd-rng") / 2.0)
            * choose(1.0, -1.0))
          : 0.01))
        + (Struct.get(data, "en-blt_spd-grid")
          ? controller.gridService.properties.speed
          : 0.0)
      var angle = Math.normalizeAngle(Struct.get(data, "en-blt_dir")
        + (Struct.get(data, "en-blt_use-dir-rng")
          ? (random(Struct.get(data, "en-blt_dir-rng") / 2.0)
          * choose(1.0, -1.0))
        : 0.0)),
      var spawnX = Struct.get(data, "en-blt_x")
        * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
        + 0.5
        + (Struct.get(data, "en-blt_use-rng-x")
          ? (random(Struct.get(data, "en-blt_rng-x") / 2.0)
            * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0)
      var snapH = Struct.getDefault(data, "en-blt_snap-x", false)
      var spawnY = Struct.get(data, "en-blt_y")
        * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
        - 0.5
        + (Struct.get(data, "en-blt_use-rng-y")
          ? (random(Struct.get(data, "en-blt_rng-y") / 2.0)
            * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
            * choose(1.0, -1.0))
          : 0.0)
      var snapV = Struct.getDefault(data, "en-blt_snap-y", false)
      var lifespan = Struct.get(data, "en-blt_use-lifespan") ? Struct.get(data, "en-blt_lifespan") : null
      var damage = Struct.get(data, "en-blt_use-dmg") ? Struct.get(data, "en-blt_dmg") : null
      var template = Struct.get(data, "en-blt_template")
      var angleOffset = null
      var angleOffsetRng = null
      var sumAngleOffset = null
      var speedOffset = null
      var sumSpeedOffset = null
      if (Struct.get(data, "en-blt_use-em")) {
        var emitterConfig = (Struct.get(data, "en-blt_em-use-cfg") == false)
          ? {
            amount: Struct.get(data, "en-blt_em-amount"),
            arrays: Struct.get(data, "en-blt_em-arrays"),
            angle: Struct.get(data, "en-blt_em-use-angle")
              ? (Struct.get(data, "en-blt_em-change-angle")
                ? Struct.get(data, "en-blt_em-angle").serialize()
                : Struct.get(Struct.get(data, "en-blt_em-angle").serialize(), "value"))
              : 0.0,
            angleRng: Struct.get(data, "en-blt_em-use-angle-rng")
              ? Struct.get(data, "en-blt_em-angle-rng")
              : 0.0,
            angleStep: Struct.get(data, "en-blt_em-angle-step"),
            perArray: Struct.get(data, "en-blt_em-per-array"),
            anglePerArray: Struct.get(data, "en-blt_em-use-per-array-dir")
              ? (Struct.get(data, "en-blt_em-change-per-array-dir")
                ? Struct.get(data, "en-blt_em-per-array-dir").serialize()
                : Struct.get(Struct.get(data, "en-blt_em-per-array-dir").serialize(), "value"))
              : 0.0,
            anglePerArrayRng: Struct.get(data, "en-blt_em-use-per-array-rng")
              ? Struct.get(data, "en-blt_em-per-array-rng")
              : 0.0,
            anglePerArrayStep: Struct.get(data, "en-blt_em-per-array-step"),
            speed: Struct.get(data, "en-blt_em-use-spd")
              ? (Struct.get(data, "en-blt_em-change-spd")
                ? Struct.get(data, "en-blt_em-spd").serialize()
                : Struct.get(Struct.get(data, "en-blt_em-spd").serialize(), "value"))
              : 0.0,
            speedRng: Struct.get(data, "en-blt_em-use-spd-rng")
              ? Struct.get(data, "en-blt_em-spd-rng")
              : 0.0,
            duration: Struct.get(data, "en-blt_em-duration"),
            offsetX: Struct.get(data, "en-blt_em-use-offset-x")
              ? (Struct.get(data, "en-blt_em-change-offset-x")
                ? Struct.get(data, "en-blt_em-offset-x").serialize()
                : Struct.get(Struct.get(data, "en-blt_em-offset-x").serialize(), "value"))
              : 0.0,
            offsetY: Struct.get(data, "en-blt_em-use-offset-y")
              ? (Struct.get(data, "en-blt_em-change-offset-y")
                ? Struct.get(data, "en-blt_em-offset-y").serialize()
                : Struct.get(Struct.get(data, "en-blt_em-offset-y").serialize(), "value"))
              : 0.0,
            wiggleFrequency: Struct.get(data, "en-blt_em-use-wiggle-freq")
              ? (Struct.get(data, "en-blt_em-change-wiggle-freq")
                ? Struct.get(data, "en-blt_em-wiggle-freq").serialize()
                : Struct.get(Struct.get(data, "en-blt_em-wiggle-freq").serialize(), "value"))
              : 0.0,
            wiggleAmplitude: Struct.get(data, "en-blt_em-use-wiggle-amp")
              ? (Struct.get(data, "en-blt_em-change-wiggle-amp")
                ? Struct.get(data, "en-blt_em-wiggle-amp").serialize()
                : Struct.get(Struct.get(data, "en-blt_em-wiggle-amp").serialize(), "value"))
              : 0.0,
          } : Struct.get(data, "en-blt_em-cfg")

        controller.bulletService.spawnBulletEmitter({
          name: template,
          spawnX: spawnX,
          spawnY: spawnY,
          angle: angle,
          speed: spd,
          snapH: snapH,
          snapV: snapV,
          lifespan: lifespan,
          damage: damage,
          angleOffset: angleOffset,
          angleOffsetRng: angleOffsetRng,
          sumAngleOffset: sumAngleOffset,
          speedOffset: speedOffset,
          sumSpeedOffset: sumSpeedOffset,
        }, emitterConfig)
      } else {
        var view = controller.gridService.view
        var locked = controller.gridService.targetLocked
        var viewX = snapH ? locked.snapH : view.x
        var viewY = snapV ? locked.snapV : view.y
        controller.bulletService.spawnBullet(
          template,
          Shroom,
          viewX + spawnX,
          viewY + spawnY,
          angle,
          spd,
          angleOffset,
          angleOffsetRng,
          sumAngleOffset,
          speedOffset,
          sumSpeedOffset,
          lifespan,
          damage
        )
      }

      ///@description ecs
      /*
      var controller = Beans.get(BeanVisuController)
      controller.gridECS.add(new GridEntity({
        type: GridEntityType.ENEMY,
        position: { 
          x: controller.gridService.view.x
            + (Struct.get(data, "en-blt_x") 
              * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) 
              + 0.5),
          y: controller.gridService.view.y
            + (Struct.get(data, "en-blt_y") 
              * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT) 
              - 0.5),
        },
        velocity: { 
          speed: Struct.get(data, "en-blt_spd") / 1000, 
          angle: Struct.get(data, "en-blt_dir"),
        },
        renderSprite: { name: "texture_baron" },
      }))
      */
    },
  },
  "brush_entity_coin": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "en-coin_hide": Struct.parse.boolean(data, "en-coin_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-coin_hide-spawn": Struct.parse.boolean(data, "en-shr_coin-spawn", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-coin_preview": Struct.parse.boolean(data, "en-coin_preview"),
        "en-coin_template": Struct.parse.text(data, "en-coin_template", "coin-default"),
        "en-coin_x": Struct.parse.number(data, "en-coin_x", 0.0,
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0),
          SHROOM_SPAWN_AMOUNT / 2.0),
        "en-coin_snap-x": Struct.parse.boolean(data, "en-coin_snap-x"),
        "en-coin_use-rng-x": Struct.parse.boolean(data, "en-coin_use-rng-x"),
        "en-coin_rng-x": Struct.parse.number(data, "en-coin_rng-x", 0.0,
          0.0,
          SHROOM_SPAWN_AMOUNT),
        "en-coin_y": Struct.parse.number(data, "en-coin_y", 0.0,
          -1.0 * (SHROOM_SPAWN_AMOUNT / 2.0),
          SHROOM_SPAWN_AMOUNT / 2.0),
        "en-coin_snap-y": Struct.parse.boolean(data, "en-coin_snap-y"),
        "en-coin_use-rng-y": Struct.parse.boolean(data, "en-coin_use-rng-y"),
        "en-coin_rng-y": Struct.parse.number(data, "en-coin_rng-y", 0.0,
          0.0, 
          SHROOM_SPAWN_AMOUNT),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }

      var view = controller.gridService.view
      var viewX = Struct.get(data, "en-coin_snap-x")
        ? floor(view.x / (view.width / 2.0)) * (view.width / 2.0)
        : view.x
      var viewY = Struct.get(data, "en-coin_snap-y")
        ? floor(view.y / (view.height / 2.0)) * (view.height / 2.0)
        : view.y

      ///@description feature TODO entity.coin.spawn
      controller.coinService.send(new Event("spawn-coin", {
        template: Struct.get(data, "en-coin_template"),
        x: viewX + Struct.get(data, "en-coin_x")
          * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
          + 0.5
          + (Struct.get(data, "en-coin_use-rng-x")
            ? (random(Struct.get(data, "en-coin_rng-x") / 2.0)
              * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
              * choose(1.0, -1.0))
            : 0.0),
        y: viewY + Struct.get(data, "en-coin_y")
          * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
          - 0.5
          + (Struct.get(data, "en-coin_use-rng-y")
            ? (random(Struct.get(data, "en-coin_rng-y") / 2.0)
              * (SHROOM_SPAWN_SIZE / SHROOM_SPAWN_AMOUNT)
              * choose(1.0, -1.0))
            : 0.0),
      }))
    },
  },
  "brush_entity_player": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "en-pl_hide": Struct.parse.boolean(data, "en-pl_hide", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-pl_hide-texture": Struct.parse.boolean(data, "en-pl_hide-texture", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-pl_hide-mask": Struct.parse.boolean(data, "en-pl_hide-mask", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-pl_hide-stats": Struct.parse.boolean(data, "en-pl_hide-stats", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-pl_hide-cfg": Struct.parse.boolean(data, "en-pl_hide-cfg"), TRACK_EVENT_DEFAULT_HIDDEN_VALUE,
        "en-pl_texture": Struct.parse.sprite(data, "en-pl_texture", { name: "texture_player" }),
        "en-pl_use-mask": Struct.parse.boolean(data, "en-pl_use-mask"),
        "en-pl_mask": Struct.parse.rectangle(data, "en-pl_mask"),
        "en-pl_reset-pos": Struct.parse.boolean(data, "en-pl_reset-pos"),
        "en-pl_shadow": Struct.parse.boolean(data, "en-pl_shadow"),
        "en-pl_use-stats": Struct.parse.boolean(data, "en-pl_use-stats"),
        "en-pl_stats": Struct.getIfType(data, "en-pl_stats", Struct, {
          force: { value: 0 },
          point: { value: 0 },
          bomb: { value: 5 },
          life: { value: 4 },
        }),
        "en-pl_use-bullethell": Struct.parse.boolean(data, "en-pl_use-bullethell"),
        "en-pl_bullethell": Struct.getIfType(data, "en-pl_bullethell", Struct, {
          x: {
            friction: 9.3,
            acceleration: 1.92,
            speedMax: 2.1,
          },
          y: {
            friction: 9.3,
            acceleration: 1.92,
            speedMax: 2.1,
          },
          guns: [
            {
              angle:  90,
              bullet: "bullet_default",
              cooldown: 8.0,
              offsetX:  0.0,
              offsetY:  0.0,
              speed:  10.0,
            }
          ]
        }),
        "en-pl_use-platformer": Struct.parse.boolean(data, "en-pl_use-platformer"),
        "en-pl_platformer": Struct.getIfType(data, "en-pl_platformer", Struct, {
          x: {
            friction: 9.3,
            acceleration: 1.92,
            speedMax: 2.1,
          },
          y: {
            friction: 0.0,
            acceleration: 1.92,
            speedMax: 25.0,
          },
          jump:  {
            size:  3.5,
          }
        }),
        "en-pl_use-racing": Struct.parse.boolean(data, "en-pl_use-racing"),
        "en-pl_racing": Struct.getIfType(data, "en-pl_racing", Struct, { }),
      }
    },
    run: function(data, channel) {
      var controller = Beans.get(BeanVisuController)
      if (!controller.isChannelDifficultyValid(channel)) {
        return
      }
      
      ///@description feature TODO entity.player.spawn
      controller.playerService.send(new Event("spawn-player", {
        "sprite": Struct.get(data, "en-pl_texture").serialize(),
        "mask": Struct.get(data, "en-pl_mask").serialize(),
        "reset-position": Struct.get(data, "en-pl_reset-pos")
          ? Struct.get(data, "en-pl_reset-pos")
          : false,
        "stats": Struct.get(data, "en-pl_use-stats")
          ? Struct.get(data, "en-pl_stats")
          : null,
        "bulletHell": Struct.get(data, "en-pl_use-bullethell")
          ? Struct.get(data, "en-pl_bullethell")
          : null,
        "platformer": Struct.get(data, "en-pl_use-platformer")
          ? Struct.get(data, "en-pl_platformer")
          : null,
        "racing": Struct.get(data, "en-pl_use-racing")
          ? Struct.get(data, "en-pl_racing")
          : null,
      }))

      ///@description feature TODO grid.player.shadow
      Struct.set(controller.gridService.properties, "playerShadowEnable", Struct.get(data, "en-pl_shadow"))
    },
  },
  "brush_entity_config": {
    parse: function(data) {
      return {
        "icon": Struct.parse.sprite(data, "icon"),
        "en-cfg_hide-render": Struct.parse.boolean(data, "en-cfg_hide-render", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-cfg_hide-cls": Struct.parse.boolean(data, "en-cfg_hide-cls", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-cfg_hide-cfg": Struct.parse.boolean(data, "en-cfg_hide-cfg", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-cfg_hide-shroom": Struct.parse.boolean(data, "en-cfg_hide-shroom", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-cfg_hide-player": Struct.parse.boolean(data, "en-cfg_hide-player", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-cfg_hide-coin": Struct.parse.boolean(data, "en-cfg_hide-coin", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-cfg_hide-bullet": Struct.parse.boolean(data, "en-cfg_hide-bullet", TRACK_EVENT_DEFAULT_HIDDEN_VALUE),
        "en-cfg_use-render-shr": Struct.parse.boolean(data, "en-cfg_use-render-shr"),
        "en-cfg_render-shr": Struct.parse.boolean(data, "en-cfg_render-shr"),
        "en-cfg_use-render-player": Struct.parse.boolean(data, "en-cfg_use-render-player"),
        "en-cfg_render-player": Struct.parse.boolean(data, "en-cfg_render-player"),
        "en-cfg_use-render-coin": Struct.parse.boolean(data, "en-cfg_use-render-coin"),
        "en-cfg_render-coin": Struct.parse.boolean(data, "en-cfg_render-coin"),
        "en-cfg_use-render-bullet": Struct.parse.boolean(data, "en-cfg_use-render-bullet"),
        "en-cfg_render-bullet": Struct.parse.boolean(data, "en-cfg_render-bullet"),
        "en-cfg_cls-shr": Struct.parse.boolean(data, "en-cfg_cls-shr"),
        "en-cfg_cls-player": Struct.parse.boolean(data, "en-cfg_cls-player"),
        "en-cfg_cls-coin": Struct.parse.boolean(data, "en-cfg_cls-coin"),
        "en-cfg_cls-bullet": Struct.parse.boolean(data, "en-cfg_cls-bullet"),
        "en-cfg_use-z-shr": Struct.parse.boolean(data, "en-cfg_use-z-shr"),
        "en-cfg_z-shr": Struct.parse.numberTransformer(data, "en-cfg_z-shr", {
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "en-cfg_change-z-shr": Struct.parse.boolean(data, "en-cfg_change-z-shr"),
        "en-cfg_use-z-player": Struct.parse.boolean(data, "en-cfg_use-z-player"),
        "en-cfg_z-player": Struct.parse.numberTransformer(data, "en-cfg_z-player", {
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "en-cfg_change-z-player": Struct.parse.boolean(data, "en-cfg_change-z-player"),
        "en-cfg_use-z-coin": Struct.parse.boolean(data, "en-cfg_use-z-coin"),
        "en-cfg_z-coin": Struct.parse.numberTransformer(data, "en-cfg_z-coin", {
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "en-cfg_change-z-coin": Struct.parse.boolean(data, "en-cfg_change-z-coin"),
        "en-cfg_use-z-bullet": Struct.parse.boolean(data, "en-cfg_use-z-bullet"),
        "en-cfg_z-bullet":Struct.parse.numberTransformer(data, "en-cfg_z-bullet", {
          clampValue: { from: 0.0, to: 99999.9 },
          clampTarget: { from: 0.0, to: 99999.9 },
        }),
        "en-cfg_change-z-bullet": Struct.parse.boolean(data, "en-cfg_use-render-shr"),
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
      var depths = properties.depths

      ///@description feature TODO grid.shroom.render
      Visu.resolveBooleanTrackEvent(data,
        "en-cfg_use-render-shr",
        "en-cfg_render-shr",
        "renderShrooms",
        properties)

      ///@description feature TODO grid.player.render
      Visu.resolveBooleanTrackEvent(data,
        "en-cfg_use-render-player",
        "en-cfg_render-player",
        "renderPlayer",
        properties)

      ///@description feature TODO grid.coin.render
      Visu.resolveBooleanTrackEvent(data,
        "en-cfg_use-render-coin",
        "en-cfg_render-coin",
        "renderCoins",
        properties)

      ///@description feature TODO grid.bullet.render
      Visu.resolveBooleanTrackEvent(data,
        "en-cfg_use-render-bullet",
        "en-cfg_render-bullet",
        "renderBullets",
        properties)

      ///@description feature TODO grid.shroom.clear
      Visu.resolveSendEventTrackEvent(data,
        "en-cfg_cls-shr",
        "clear-shrooms",
        null,
        controller.shroomService.dispatcher)

      ///@description feature TODO grid.player.clear
      Visu.resolveSendEventTrackEvent(data,
        "en-cfg_cls-player",
        "clear-player",
        null,
        controller.playerService.dispatcher)

      ///@description feature TODO grid.coin.clear
      Visu.resolveSendEventTrackEvent(data,
        "en-cfg_cls-coin",
        "clear-coins",
        null,
        controller.coinService.dispatcher)

      ///@description feature TODO grid.bullets.clear
      Visu.resolveSendEventTrackEvent(data,
        "en-cfg_cls-bullet",
        "clear-bullets",
        null,
        controller.bulletService.dispatcher)

      ///@description feature TODO grid.shroom.z
      Visu.resolveNumberTransformerTrackEvent(data, 
        "en-cfg_use-z-shr",
        "en-cfg_z-shr",
        "en-cfg_change-z-shr",
        "shroomZ",
        depths, pump, executor)

      ///@description feature TODO grid.player.z
      Visu.resolveNumberTransformerTrackEvent(data, 
        "en-cfg_use-z-player",
        "en-cfg_z-player",
        "en-cfg_change-z-player",
        "playerZ",
        depths, pump, executor)

      ///@description feature TODO grid.coin.z
      Visu.resolveNumberTransformerTrackEvent(data, 
        "en-cfg_use-z-coin",
        "en-cfg_z-coin",
        "en-cfg_change-z-coin",
        "coinZ",
        depths, pump, executor)

      ///@description feature TODO grid.bullet.z
      Visu.resolveNumberTransformerTrackEvent(data, 
        "en-cfg_use-z-bullet",
        "en-cfg_z-bullet",
        "en-cfg_change-z-bullet",
        "bulletZ",
        depths, pump, executor)
    },
  },
}
#macro entity_track_event global.__entity_track_event
