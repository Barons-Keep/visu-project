///@package io.alkapivo.visu.editor.ui.controller

///@param {VisuEditorController} _editor
function VETrackControl(_editor) constructor {

  ///@type {VisuEditorController}
  editor = Assert.isType(_editor, VisuEditorController)
  
  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "track-control",
        fetchNodeX: new BindIntent(function(index, amount, width, margin) {
          var halfX = this.context.width() / 2
          var halfWidth = ((width * amount) + (margin * (amount + 2))) / 2
          return halfX - halfWidth + (width * index) + (margin * (index + 2))
        }),
        nodes: {
          timeline: {
            name: "track-control.timeline",
            margin: { left: 0, right: 32 },
            x: function() { return this.__margin.left },
            y: function() { return 0 },
            width: function() { return this.context.width() 
              - this.__margin.left
              - this.__margin.right },
            height: function() { 
              return 36
            },
          },

          timestamp: {
            name: "track-control.timestamp",
            width: function() { return 64 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 24, right: 4 },
            x: function() { return this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          bpm_label: {
            name: "track-control.bpm_label",
            width: function() { return 28 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 4, right: 0 },
            x: function() { return this.context.nodes.timestamp.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          bpm_field: {
            name: "track-control.bpm_field",
            width: function() { return 32 },
            height: function() { return 24 },
            margin: { top: 10, bottom: 10, left: 0, right: 4 },
            x: function() { return this.context.nodes.bpm_label.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          meter_label: {
            name: "track-control.meter_label",
            width: function() { return 28 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 4, right: 0 },
            x: function() { return this.context.nodes.bpm_field.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          meter_field: {
            name: "track-control.meter_field",
            width: function() { return 32 },
            height: function() { return 24 },
            margin: { top: 10, bottom: 10, left: 0, right: 4 },
            x: function() { return this.context.nodes.meter_label.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          sub_label: {
            name: "track-control.sub_label",
            width: function() { return 28 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 4, right: 0 },
            x: function() { return this.context.nodes.meter_field.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          sub_field: {
            name: "track-control.sub_field",
            width: function() { return 32 },
            height: function() { return 24 },
            margin: { top: 10, bottom: 10, left: 0, right: 4 },
            x: function() { return this.context.nodes.sub_label.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          shift_label: {
            name: "track-control.shift_label",
            width: function() { return 28 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 4, right: 0 },
            x: function() { return this.context.nodes.sub_field.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          shift_field: {
            name: "track-control.shift_field",
            width: function() { return 48 },
            height: function() { return 24 },
            margin: { top: 10, bottom: 10, left: 0, right: 4 },
            x: function() { return this.context.nodes.shift_label.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          /*
          shift_label: {
            name: "track-control.shift_label",
            width: function() { return 28 },
            height: function() { return 32 },
            margin: { top:0, bottom: 0, left: 4, right: 0 },
            x: function() { return this.context.nodes.sub_field.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
              - 20.0},
          },
          shift_field: {
            name: "track-control.shift_field",
            width: function() { return 32 },
            height: function() { return 24 },
            margin: { top: 10, bottom: 2, left: 0, right: 4 },
            x: function() { return this.context.nodes.sub_field.right() 
              + this.__margin.left },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height() },
          },
          */
          backward: {
            name: "track-control.backward",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 0 },
            x: function() { return this.context.fetchNodeX(0, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.__margin.top },
          },
          play: {
            name: "track-control.play",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 0 },
            x: function() { return this.context.fetchNodeX(1, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.__margin.top },
          },
          pause: {
            name: "track-control.pause",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 0 },
            x: function() { return this.context.fetchNodeX(2, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.__margin.top },
          },
          forward: {
            name: "track-control.forward",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 0 },
            x: function() { return this.context.fetchNodeX(3, 4, this.width(), 4) },
            y: function() { return this.context.nodes.timeline.bottom()
              + this.__margin.top },
          },
          
          autosave: {
            name: "track-control.autosave",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 1, right: 4 },
            x: function() { return this.context.nodes.follow.left() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
          follow: {
            name: "track-control.follow",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 1, right: 4 },
            x: function() { return this.context.nodes.update.left() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
          update: {
            name: "track-control.update",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 1, right: 4 },
            x: function() { return this.context.nodes.undo.left() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
          undo: {
            name: "track-control.undo",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 1, right: 4 },
            x: function() { return this.context.nodes.redo.left() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
          redo: {
            name: "track-control.redo",
            width: function() { return 32 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 1, right: 4 },
            x: function() { return this.context.nodes.zoom_out.left() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
          zoom_out: {
            name: "track-control.zoom_out",
            width: function() { return 16 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 4, right: 1 },
            x: function() { return this.context.nodes.zoom.left() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
          zoom: {
            name: "track-control.zoom",
            width: function() { return 64 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 10, right: 10 },
            x: function() { return this.context.nodes.zoom_in.left() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
          zoom_in: {
            name: "track-control.zoom_in",
            width: function() { return 16 },
            height: function() { return 32 },
            margin: { top: 4, bottom: 4, left: 1, right: 24 },
            x: function() { return this.context.width() 
              - this.__margin.right
              - this.width() },
            y: function() { return this.context.height()
              - this.__margin.bottom 
              - this.height()
            },
          },
        }
      }, 
      parent
    )
  }

  ///@private
  ///@param {UIlayout} parent
  ///@return {Map<String, UI>}
  factoryContainers = function(parent) {
    static factorySlider = function(json) {
      return Struct.appendRecursiveUnique(
        {
          type: UISliderHorizontal,
          layout: json.layout,
          value: 0.0,
          minValue: 0.0,
          maxValue: 1.0,
          getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
          setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
          pointer: {
            name: "texture_slider_pointer_track_control",
            scaleX: 0.125,
            scaleY: 0.125,
          },
          progress: { 
            thickness: 1.75, 
            alpha: 1.0,
            blend: VETheme.color.accentLight,
            line: { name: "texture_grid_line_bold" },
            cornerFrom: { name: "texture_empty" },
            cornerTo: { name: "texture_empty" },
          },
          background: {
            thickness: 0.0, 
            blend: VETheme.color.sideDark,
            alpha: 0.0,
          },
          preRender: function() {
            var background = Struct.get(this, "_background")
            if (!Core.isType(background, TexturedLine)) {
              background = new TexturedLine({
                thickness: 1.5, 
                blend: VETheme.color.side,
                alpha: 0.5,
                line: { name: "texture_grid_line_default" },
                cornerFrom: { name: "texture_empty" },
                cornerTo: { name: "texture_empty" },
              })
              Struct.set(this, "_background", background)
            }

            var fromX = this.context.area.getX() + this.area.getX()
            var fromY = this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2)
            var widthMax = this.area.getWidth() + (this.pointer.getWidth() * this.pointer.scaleX())
            var width = ((this.value - this.minValue) / abs(this.minValue - this.maxValue)) * widthMax
            background.render(fromX, fromY, fromX + widthMax, fromY)
          },
          state: new Map(String, any),
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          updateCustom: function() {
            var controller = Beans.get(BeanVisuController)
            var trackService = controller.trackService
            var mousePromise = Beans.get(BeanVisuEditorIO).mouse.getClipboard()
            var context = Struct.get(Struct.get(mousePromise, "state"), "context")
            var ruler = Beans.get(BeanVisuEditorController).timeline.containers.get("ve-timeline-ruler")
            if (context == this) {
              this.updatePosition(MouseUtil.getMouseX() - this.context.area.getX(), MouseUtil.getMouseY() - this.context.area.getY())
              return
            } else if (context != null && context == ruler) {
              var mouseXTime = ruler.state.get("mouseXTime")
              if (Core.isType(mouseXTime, Number)) {
                this.value = clamp(
                  mouseXTime / trackService.duration, 
                  this.minValue, 
                  this.maxValue
                )
                return
              }
            }

            if (this.state.contains("promise")) {
              var promise = this.state.get("promise")
              if (Struct.get(promise, "status") == PromiseStatus.PENDING) {
                return
              }
              this.state.remove("promise")
            }
            
            if (controller.fsm.getStateName() == "rewind") {
              return
            }

            this.value = clamp(
              trackService.time / trackService.duration, 
              this.minValue, 
              this.maxValue
            )
          },
          updatePosition: function(mouseX, mouseY) {
            var width = this.area.getWidth() - (this.area.getX() * 2)
            this.value = clamp(mouseX / width, this.minValue, this.maxValue)

            var controller = Beans.get(BeanVisuController)
            var editor = Beans.get(BeanVisuEditorController)
            var ruler = editor.uiService.find("ve-timeline-ruler")
            if (Optional.is(ruler)) {
              ruler.state.set("time", this.value * controller.trackService.duration)
              ruler.finishUpdateTimer()
            }

            var events = editor.uiService.find("ve-timeline-events")
            if (Optional.is(events)) {
              events.state.set("time", this.value * controller.trackService.duration)
              events.finishUpdateTimer()
            }
          },
          onMousePressedLeft: function(event) {
            this.updatePosition(event.data.x - this.context.area.getX(), event.data.y - this.context.area.getY())
          },
          onMouseReleasedLeft: function(event) {
            this.updatePosition(event.data.x - this.context.area.getX(), event.data.y - this.context.area.getY())
            this.sendEvent()
          },
          onMouseDragLeft: function(event) {
            var context = this
            var mouse = Beans.get(BeanVisuEditorIO).mouse
            var name = Struct.get(mouse.getClipboard(), "name")
            if (name == "resize_accordion"
                || name == "resize_brush_toolbar"
                || name == "resize_brush_inspector"
                || name == "resize_template_inspector"
                || name == "resize_timeline"
                || name == "resize_horizontal"
                || name == "resize_event_title"
                || !Beans.get(BeanVisuController).trackService.isTrackLoaded()) {
              return
            }

            Beans.get(BeanVisuEditorIO).mouse.setClipboard(new Promise()
              .setState({
                context: context,
                callback: context.sendEvent,
              })
              .whenSuccess(function() {
                Callable.run(Struct.get(this.state, "callback"))
              })
            )
          },
          sendEvent: new BindIntent(function() {
            var controller = Beans.get(BeanVisuController)
            var timestamp = this.value * (controller.trackService.duration - (FRAME_MS * 4))
            var promise = controller
              .send(new Event("rewind")
              .setData({ timestamp: timestamp })
              .setPromise(new Promise()))
            this.state.set("promise", promise)
            return promise
          }),
        },
        VEStyles.get("ve-track-control").slider,
        false
      )
    }

    static factoryButton = function(json) {
      var button = Struct.appendRecursiveUnique(
        {
          type: UIButton,
          layout: json.layout,
          sprite: json.sprite,
          callback: json.callback,
          label: {
            text: "",
            align: { v: VAlign.BOTTOM, h: HAlign.CENTER },
            color: VETheme.color.textShadow,
            useScale: false,
            outline: true,
            outlineColor: VETheme.color.sideDark,
            font: "font_inter_8_bold",
          },
          updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
          updateCustom: Struct.contains(json, "updateCustom") 
             ? json.updateCustom
             : function() {},
          onMouseHoverOver: function(event) {
            this.sprite.setBlend(ColorUtil.fromHex(VETheme.color.buttonHover).toGMColor())
          },
          onMouseHoverOut: function(event) {
            this.sprite.setBlend(ColorUtil.fromHex(VETheme.color.textShadow).toGMColor())
          },
        },
        VEStyles.get("ve-track-control").button,
        false
      )

      if (Optional.is(Struct.getIfType(json, "postRender", Callable))) {
        Struct.set(button, "postRender", json.postRender)
      }

      return button
    }

    static factoryLabel = function(json) {
      var struct = {
        type: UIText,
        layout: json.layout,
        text: json.text,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
      }

      if (Struct.contains(json, "updateCustom")) {
        Struct.set(struct, "updateCustom", json.updateCustom)
      }

      if (Struct.contains(json, "align")) {
        Struct.set(struct, "align", json.align)
      }
      
      return Struct.appendRecursiveUnique(
        struct,
        VEStyles.get("ve-track-control").label,
        false
      )
    }
    
    var controller = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "ve-track-control": new UI({
        name: "ve-track-control",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VETheme.color.primaryShadow).toGMColor(),
          "background-color2": ColorUtil.fromHex(VETheme.color.sideDark).toGMColor(),
          "background-alpha": 0.85,
          "store": Beans.get(BeanVisuEditorController).store,
        }),
        controller: controller,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        spinner: SpriteUtil.parse({ name: "texture_spinner", scaleX: 0.25, scaleY: 0.25 }),
        spinnerFactor: 0,
        render: function() {
          var color = this.state.get("background-color")
          var color2 = this.state.get("background-color2")
          if (Core.isType(color, GMColor)) {
            GPU.render.rectangle(
              this.area.x, this.area.y + 16, 
              this.area.x + this.area.getWidth(), this.area.y + this.area.getHeight(), 
              false,
              color, color, color2, color2, 
              this.state.get("background-alpha")
            )
          }

          this.items.forEach(this.renderItem, this.area)

          if (Beans.get(BeanVisuController).fsm.getStateName() == "rewind") {
            this.spinnerFactor = lerp(this.spinnerFactor, 100.0, 0.1)
            this.spinner
              .setAlpha(this.spinnerFactor / 100.0)
              .render(
                (GuiWidth() / 2) ,
                (GuiHeight() / 2) - (this.spinnerFactor / 2)
            )
          } else if (this.spinnerFactor > 0) {
            this.spinnerFactor = lerp(this.spinnerFactor, 0.0, 0.1)
            this.spinner
              .setAlpha(this.spinnerFactor / 100.0)
              .render(
              (GuiWidth() / 2),
              (GuiHeight() / 2) - (this.spinnerFactor / 2)
            )
          }
        },
        items: {
          "slider_ve-track-control_timeline": factorySlider({
            layout: layout.nodes.timeline,
          }),
          "button_ve-track-control_backward": factoryButton({
            layout: layout.nodes.backward,
            sprite: { 
              name: "texture_ve_trackcontrol_button_rewind_left",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              var controller = Beans.get(BeanVisuController)
              controller.send(new Event("rewind").setData({
                timestamp: clamp(
                  controller.trackService.time - 5.0, 
                  0, 
                  controller.trackService.duration),
              }))
            },
            postRender: function() {
              if (!this.isHoverOver) {
                return
              }
              
              var text = this.label.text
              this.label.text = "Rewind 5sec (CTRL + <)"
              this.label.render(
                // todo VALIGN HALIGN
                this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                this.context.area.getY() + this.area.getY(),
                this.area.getWidth(),
                this.area.getHeight()
              )
              this.label.text = text
            },
          }),
          "button_ve-track-control_play": factoryButton({
            layout: layout.nodes.play,
            sprite: {
              name: "texture_ve_trackcontrol_button_play",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Beans.get(BeanVisuController).send(new Event("play"))
            },
            postRender: function() {
              if (!this.isHoverOver) {
                return
              }
              
              var text = this.label.text
              this.label.text = "Play (SPACE)"
              this.label.render(
                // todo VALIGN HALIGN
                this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                this.context.area.getY() + this.area.getY(),
                this.area.getWidth(),
                this.area.getHeight()
              )
              this.label.text = text
            },
          }),
          "button_ve-track-control_pause": factoryButton({
            layout: layout.nodes.pause,
            sprite: {
              name: "texture_ve_trackcontrol_button_pause",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Beans.get(BeanVisuController).send(new Event("pause"))
            },
            postRender: function() {
              if (!this.isHoverOver) {
                return
              }
              
              var text = this.label.text
              this.label.text = "Pause (SPACE)"
              this.label.render(
                // todo VALIGN HALIGN
                this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                this.context.area.getY() + this.area.getY(),
                this.area.getWidth(),
                this.area.getHeight()
              )
              this.label.text = text
            },
          }),
          "button_ve-track-control_forward": factoryButton({
            layout: layout.nodes.forward,
            sprite: {
              name: "texture_ve_trackcontrol_button_rewind_right",
              blend: VETheme.color.textShadow,
            },
            callback: function() {
              Logger.debug("VETrackControl", $"Button pressed: {this.name}")
              var controller = Beans.get(BeanVisuController)
              controller.send(new Event("rewind").setData({
                timestamp: clamp(
                  controller.trackService.time + 5.0, 
                  0, 
                  controller.trackService.duration),
              }))
            },
            postRender: function() {
              if (!this.isHoverOver) {
                return
              }
              
              var text = this.label.text
              this.label.text = "Forward 5sec (CTRL + >)"
              this.label.render(
                // todo VALIGN HALIGN
                this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                this.context.area.getY() + this.area.getY(),
                this.area.getWidth(),
                this.area.getHeight()
              )
              this.label.text = text
            },
          }),
          "text_ve-track-control_timestamp": factoryLabel({
            layout: layout.nodes.timestamp,
            text: "",
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
            updateCustom: function() {
              var trackService = Beans.get(BeanVisuController).trackService
              var value = Struct.get(this.context.items
                .get("slider_ve-track-control_timeline"), "value")
              if (!trackService.isTrackLoaded()
                  || !Core.isType(value, Number) 
                  || Math.isNaN(value) 
                  || Math.isNaN(trackService.duration)) {

                this.label.text = "00:00.00"
                return
              }
              
              this.label.text = String
                .formatTimestampMilisecond(NumberUtil
                .parse(trackService.duration * value, 0.0))
            },
          }),
          "text_ve-track-control_bpm_label": factoryLabel({
            layout: layout.nodes.bpm_label,
            text: "BPM",
            font: "font_inter_10_regular",
            offset: { y: 1 },
            color: VETheme.color.textShadow,
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
          }),
          "text-field_ve-track-control_bpm_field": {
            type: UITextField,
            layout: layout.nodes.bpm_field,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            text: "90",
            value: "90",
            font: "font_inter_10_regular",
            colorBackgroundUnfocused: VETheme.color.side,
            colorBackgroundFocused: VETheme.color.primaryShadow,
            colorOutlineUnfocused: VETheme.color.primaryShadow,
            colorOutlineFocused: VETheme.color.primary,
            colorTextUnfocused: VETheme.color.textShadow,
            colorTextFocused: VETheme.color.textFocus,
            colorSelection: VETheme.color.textSelected,
            lh: 20.0000,
            padding: { top: 2, bottom: 0, left: 4, right: 4 },
            GMTF_DECIMAL: 0,
            config: { key: "bpm" },
            store: {
              key: "bpm",
              callback: function(value, data) { 
                var item = data.store.get("bpm")
                if (item == null) {
                  return 
                }
    
                var bpm = item.get()
                if (!Core.isType(bpm, Number)) {
                  return 
                }

                data.textField.setText(string(bpm))
              },
              set: function(value) {
                var item = this.get()
                if (item == null) {
                  return 
                }
    
                var parsedValue = NumberUtil.parse(value, null)
                if (parsedValue == null) {
                  return
                }

                item.set(parsedValue)
                Struct.set(Beans.get(BeanVisuController).track, "bpm", parsedValue)
              },
            },
          },
          "text_ve-track-control_meter_label": factoryLabel({
            layout: layout.nodes.meter_label,
            text: "Meter",
            font: "font_inter_10_regular",
            offset: { y: 1 },
            color: VETheme.color.textShadow,
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
          }),
          "text-field_ve-track-control_meter_field": {
            type: UITextField,
            layout: layout.nodes.meter_field,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            text: "16",
            value: "16",
            font: "font_inter_10_regular",
            colorBackgroundUnfocused: VETheme.color.side,
            colorBackgroundFocused: VETheme.color.primaryShadow,
            colorOutlineUnfocused: VETheme.color.primaryShadow,
            colorOutlineFocused: VETheme.color.primary,
            colorTextUnfocused: VETheme.color.textShadow,
            colorTextFocused: VETheme.color.textFocus,
            colorSelection: VETheme.color.textSelected,
            lh: 20.0000,
            padding: { top: 2, bottom: 0, left: 4, right: 4 },
            config: { key: "bpm-count" },
            store: {
              key: "bpm-count",
              callback: function(value, data) { 
                var item = data.store.get("bpm-count")
                if (item == null) {
                  return 
                }
    
                var bpm = item.get()
                if (!Core.isType(bpm, Number)) {
                  return 
                }

                data.textField.setText(string(bpm))
              },
              set: function(value) {
                var item = this.get()
                if (item == null) {
                  return 
                }
    
                var parsedValue = NumberUtil.parse(value, null)
                if (parsedValue == null) {
                  return
                }
                item.set(parsedValue)
    
                Struct.set(Beans.get(BeanVisuController).track, "bpmCount", parsedValue)
              },
            },
            margin: { left: 2, right: 2 },
          },
          "text_ve-track-control_sub_label": factoryLabel({
            layout: layout.nodes.sub_label,
            text: "Sub",
            font: "font_inter_10_regular",
            offset: { y: 1 },
            color: VETheme.color.textShadow,
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
          }),
          "text-field_ve-track-control_sub_field": {
            type: UITextField,
            layout: layout.nodes.sub_field,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            text: "2",
            value: "2",
            font: "font_inter_10_regular",
            colorBackgroundUnfocused: VETheme.color.side,
            colorBackgroundFocused: VETheme.color.primaryShadow,
            colorOutlineUnfocused: VETheme.color.primaryShadow,
            colorOutlineFocused: VETheme.color.primary,
            colorTextUnfocused: VETheme.color.textShadow,
            colorTextFocused: VETheme.color.textFocus,
            colorSelection: VETheme.color.textSelected,
            lh: 20.0000,
            padding: { top: 2, bottom: 0, left: 4, right: 4 },
            config: { key: "bpmSub" },
            store: {
              key: "bpm-sub",
              callback: function(value, data) { 
                var item = data.store.get("bpm-sub")
                if (item == null) {
                  return 
                }
    
                var bpm = item.get()
                if (!Core.isType(bpm, Number)) {
                  return 
                }
                data.textField.setText(string(bpm))
              },
              set: function(value) {
                var item = this.get()
                if (item == null) {
                  return 
                }
    
                var parsedValue = NumberUtil.parse(value, null)
                if (parsedValue == null) {
                  return
                }
                item.set(parsedValue)
    
                Struct.set(Beans.get(BeanVisuController).track, "bpmSub", parsedValue)
              },
            },
            margin: { left: 2, right: 2 },
          },
          "text_ve-track-control_shift_label": factoryLabel({
            layout: layout.nodes.shift_label,
            text: "Shift",
            font: "font_inter_10_regular",
            offset: { y: 1 },
            color: VETheme.color.textShadow,
            align: { v: VAlign.CENTER, h: HAlign.LEFT },
          }),
          "text-field_ve-track-control_shift_field": {
            type: UITextField,
            layout: layout.nodes.shift_field,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayoutTextField")),
            text: "0",
            value: "0",
            font: "font_inter_10_regular",
            colorBackgroundUnfocused: VETheme.color.side,
            colorBackgroundFocused: VETheme.color.primaryShadow,
            colorOutlineUnfocused: VETheme.color.primaryShadow,
            colorOutlineFocused: VETheme.color.primary,
            colorTextUnfocused: VETheme.color.textShadow,
            colorTextFocused: VETheme.color.textFocus,
            colorSelection: VETheme.color.textSelected,
            lh: 20.0000,
            padding: { top: 2, bottom: 0, left: 4, right: 4 },
            config: { key: "bpmShift" },
            store: {
              key: "bpm-shift",
              callback: function(value, data) { 
                var item = data.store.get("bpm-shift")
                if (item == null) {
                  return 
                }
    
                var bpm = item.get()
                if (!Core.isType(bpm, Number)) {
                  return 
                }
                data.textField.setText(string(bpm))
              },
              set: function(value) {
                var item = this.get()
                if (item == null) {
                  return 
                }
    
                var parsedValue = NumberUtil.parse(value, null)
                if (parsedValue == null) {
                  return
                }
                item.set(parsedValue)
    
                Struct.set(Beans.get(BeanVisuController).track, "bpmShift", parsedValue)
              },
            },
            margin: { left: 2, right: 2 },
          },
          "checkbox_ve-track-control_autosave": {
            type: UICheckbox,
            layout: layout.nodes.autosave,
            value: Beans.get(BeanVisuEditorController).autosave.value,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            callback: function() {
              var editor = Beans.get(BeanVisuEditorController)
              editor.autosave.value = this.value
              Visu.settings.setValue("visu.editor.autosave", this.value).save()
              if (!editor.autosave.value) {
                editor.autosave.timer.time = 0
              }
            },
            spriteOn: {
              name: "texture_ve_brush_toolbar_icon_save",
              blend: "#FFFFFF",
              alpha: 1.0,
            },
            spriteOff: {
              name: "texture_ve_brush_toolbar_icon_save",
              blend: "#FFFFFF",
              alpha: 0.2,
            },
            backgroundMargin: { top: 1, bottom: 1, left: 0, right: 1 },
            backgroundColor: VETheme.color.sideDark,
            backgroundColorSelected: VETheme.color.primaryLight,
            backgroundColorOut: VETheme.color.sideDark,
            onMouseHoverOver: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            description: "Autosave",
            render: function() {
              if (Optional.is(this.preRender)) {
                this.preRender()
              }
              this.renderBackgroundColor()

              var sprite = this.value ? this.spriteOn : this.spriteOff
              if (sprite != null) {
                var alpha = sprite.getAlpha()
                if (this.scaleToFillStretched) {
                  sprite.scaleToFillStretched(this.area.getWidth() - this.margin.left - this.margin.right, this.area.getHeight() - this.margin.top - this.margin.bottom)
                }
                sprite
                  .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                  .render(
                    this.context.area.getX() + this.area.getX() + this.margin.left,
                    this.context.area.getY() + this.area.getY() + this.margin.top
                  )
                  .setAlpha(alpha)
              }

              var label = Struct.get(this, "label")
              if (label == null) {
                label = new UILabel({ 
                  text: this.description,
                  color: VETheme.color.textShadow,
                  align: { v: VAlign.BOTTOM, h: HAlign.CENTER },
                  useScale: false,
                  outline: true,
                  outlineColor: VETheme.color.sideDark,
                  font: "font_inter_8_bold",
                })
                Struct.set(this, "label", label)
              }
  
              if (this.isHoverOver && this.enable.value) {
                this.label.text = this.description
                this.label.alpha = this.backgroundAlpha
                this.label.render(
                  // todo VALIGN HALIGN
                  this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                  this.context.area.getY() + this.area.getY(),// + (this.area.getHeight() / 2)
                  this.area.getWidth(),
                  this.area.getHeight()
                )
              }
              return this
            },
          },
          "checkbox_ve-track-control_update": {
            type: UICheckbox,
            layout: layout.nodes.update,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            store: { key: "update-services" },
            spriteOn: {
              name: "texture_ve_brush_toolbar_icon_update",
              blend: "#FFFFFF",
              alpha: 1.0,
            },
            spriteOff: {
              name: "texture_ve_brush_toolbar_icon_update",
              blend: "#FFFFFF",
              alpha: 0.2,
            },
            backgroundMargin: { top: 1, bottom: 1, left: 0, right: 1 },
            backgroundColor: VETheme.color.sideDark,
            backgroundColorSelected: VETheme.color.primaryLight,
            backgroundColorOut: VETheme.color.sideDark,
            onMouseHoverOver: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            description: "Update",
            render: function() {
              if (Optional.is(this.preRender)) {
                this.preRender()
              }
              this.renderBackgroundColor()

              var sprite = this.value ? this.spriteOn : this.spriteOff
              if (sprite != null) {
                var alpha = sprite.getAlpha()
                if (this.scaleToFillStretched) {
                  sprite.scaleToFillStretched(this.area.getWidth() - this.margin.left - this.margin.right, this.area.getHeight() - this.margin.top - this.margin.bottom)
                }
                sprite
                  .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                  .render(
                    this.context.area.getX() + this.area.getX() + this.margin.left,
                    this.context.area.getY() + this.area.getY() + this.margin.top
                  )
                  .setAlpha(alpha)
              }

              var label = Struct.get(this, "label")
              if (label == null) {
                label = new UILabel({ 
                  text: this.description,
                  color: VETheme.color.textShadow,
                  align: { v: VAlign.BOTTOM, h: HAlign.CENTER },
                  useScale: false,
                  outline: true,
                  outlineColor: VETheme.color.sideDark,
                  font: "font_inter_8_bold",
                })
                Struct.set(this, "label", label)
              }
  
              if (this.isHoverOver && this.enable.value) {
                this.label.text = this.description
                this.label.alpha = this.backgroundAlpha
                this.label.render(
                  // todo VALIGN HALIGN
                  this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                  this.context.area.getY() + this.area.getY(),// + (this.area.getHeight() / 2)
                  this.area.getWidth(),
                  this.area.getHeight()
                )
              }
              return this
            },
          },
          "checkbox_ve-track-control_follow": {
            type: UICheckbox,
            layout: layout.nodes.follow,
            updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            store: { key: "timeline-follow" },
            spriteOn: {
              name: "texture_ve_brush_toolbar_icon_follow",
              blend: "#FFFFFF",
              alpha: 1.0,
            },
            spriteOff: {
              name: "texture_ve_brush_toolbar_icon_follow",
              blend: "#FFFFFF",
              alpha: 0.2,
            },
            backgroundMargin: { top: 1, bottom: 1, left: 0, right: 1 },
            backgroundColor: VETheme.color.sideDark,
            backgroundColorSelected: VETheme.color.primaryLight,
            backgroundColorOut: VETheme.color.sideDark,
            onMouseHoverOver: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
            },
            onMouseHoverOut: function(event) {
              this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
            },
            description: "Follow",
            render: function() {
              if (Optional.is(this.preRender)) {
                this.preRender()
              }
              this.renderBackgroundColor()

              var sprite = this.value ? this.spriteOn : this.spriteOff
              if (sprite != null) {
                var alpha = sprite.getAlpha()
                if (this.scaleToFillStretched) {
                  sprite.scaleToFillStretched(this.area.getWidth() - this.margin.left - this.margin.right, this.area.getHeight() - this.margin.top - this.margin.bottom)
                }
                sprite
                  .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                  .render(
                    this.context.area.getX() + this.area.getX() + this.margin.left,
                    this.context.area.getY() + this.area.getY() + this.margin.top
                  )
                  .setAlpha(alpha)
              }

              var label = Struct.get(this, "label")
              if (label == null) {
                label = new UILabel({ 
                  text: this.description,
                  color: VETheme.color.textShadow,
                  align: { v: VAlign.BOTTOM, h: HAlign.CENTER },
                  useScale: false,
                  outline: true,
                  outlineColor: VETheme.color.sideDark,
                  font: "font_inter_8_bold",
                })
                Struct.set(this, "label", label)
              }
  
              if (this.isHoverOver && this.enable.value) {
                this.label.text = this.description
                this.label.alpha = this.backgroundAlpha
                this.label.render(
                  // todo VALIGN HALIGN
                  this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                  this.context.area.getY() + this.area.getY(),// + (this.area.getHeight() / 2)
                  this.area.getWidth(),
                  this.area.getHeight()
                )
              }
              return this
            },
          },
          "button-ve-track-control_redo": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              label: { 
                text: "",
                color: VETheme.color.textShadow,
                align: { v: VAlign.BOTTOM, h: HAlign.CENTER },
                useScale: false,
                outline: true,
                outlineColor: VETheme.color.sideDark,
                font: "font_inter_8_bold",
              },
              sprite: {
                name: "texture_ve_brush_toolbar_icon_redo",
                alpha: 1.0,
              },
              layout: layout.nodes.redo,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() { 
                if (Struct.get(this.enable, "value") == false) {
                  return
                }
                
                Beans.get(BeanVisuEditorIO).keyboard.keys.controlLeft.on = true ///@hack

                var editor = Beans.get(BeanVisuEditorController)
                editor.store.get("selected-event").set(null, true)
                editor.store.getValue("selected-events").clear()
                editor.timeline.transactionService.redo()
              },
              backgroundMargin: { top: 1, bottom: 1, left: 0, right: 1 },
              backgroundColor: VETheme.color.sideDark,
              backgroundColorSelected: VETheme.color.primaryLight,
              backgroundColorOut: VETheme.color.sideDark,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }

                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              description: "Redo (CTRL + SHIFT + Z)",
              render: function() {
                var value = Beans.get(BeanVisuEditorController).timeline.transactionService.reverted.size() > 0
                if (this.updateEnable != null && value != this.enable.value) {
                  Struct.set(this.enable, "value", value)
                  this.updateEnable()
                }
                backgroundAlpha = this.enable.value ? 1.0 : 0.5

                if (Optional.is(this.preRender)) {
                  this.preRender()
                }
                this.renderBackgroundColor()
          
                if (this.sprite != null) {
                  var alpha = this.sprite.getAlpha()
                  this.sprite
                    .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                    .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                    .render(
                      this.context.area.getX() + this.area.getX(),
                      this.context.area.getY() + this.area.getY())
                    .setAlpha(alpha)
                }
          
                if (this.label != null) {
                  this.label.alpha = this.backgroundAlpha
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2),
                    this.area.getWidth(), 
                    this.area.getHeight()
                  )
                }
    
                if (this.isHoverOver && this.enable.value) {
                  var text = this.label.text
                  this.label.text = this.description
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY(),
                    this.area.getWidth(),
                    this.area.getHeight()
                  )
                  this.label.text = text
                }
                return this
              },
            },
            null,//VEStyles.get("ve-track-control").button,
            false
          ),
          "button-ve-track-control_undo": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              label: { 
                text: "",
                color: VETheme.color.textShadow,
                align: { v: VAlign.BOTTOM, h: HAlign.CENTER },
                useScale: false,
                outline: true,
                outlineColor: VETheme.color.sideDark,
                font: "font_inter_8_bold",
              },
              sprite: {
                name: "texture_ve_brush_toolbar_icon_undo",
                alpha: 1.0,
              },
              layout: layout.nodes.undo,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              callback: function() { 
                if (Struct.get(this.enable, "value") == false) {
                  return
                }

                Beans.get(BeanVisuEditorIO).keyboard.keys.controlLeft.on = true ///@hack
                
                var editor = Beans.get(BeanVisuEditorController)
                editor.store.get("selected-event").set(null, true)
                editor.store.getValue("selected-events").clear()
                editor.timeline.transactionService.undo()
              },
              backgroundMargin: { top: 1, bottom: 1, left: 0, right: 1 },
              backgroundColor: VETheme.color.sideDark,
              backgroundColorSelected: VETheme.color.primaryLight,
              backgroundColorOut: VETheme.color.sideDark,
              onMouseHoverOver: function(event) {
                if (Struct.get(this.enable, "value") == false) {
                  this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
                  return
                }

                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              description: "Undo (CTRL + Z)",
              render: function() {
                var value = Beans.get(BeanVisuEditorController).timeline.transactionService.applied.size() > 0
                if (this.updateEnable != null && value != this.enable.value) {
                  Struct.set(this.enable, "value", value)
                  this.updateEnable()
                }
                backgroundAlpha = this.enable.value ? 1.0 : 0.5

                if (Optional.is(this.preRender)) {
                  this.preRender()
                }
                this.renderBackgroundColor()
          
                if (this.sprite != null) {
                  var alpha = this.sprite.getAlpha()
                  this.sprite
                    .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                    .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                    .render(
                      this.context.area.getX() + this.area.getX(),
                      this.context.area.getY() + this.area.getY())
                    .setAlpha(alpha)
                }
          
                if (this.label != null) {
                  this.label.alpha = this.backgroundAlpha
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2),
                    this.area.getWidth(), 
                    this.area.getHeight()
                  )
                }
    
                if (this.isHoverOver && this.enable.value) {
                  var text = this.label.text
                  this.label.text = this.description
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY(),
                    this.area.getWidth(),
                    this.area.getHeight()
                  )
                  this.label.text = text
                }
                return this
              },
            },
            null,//VEStyles.get("ve-track-control").button,
            false
          ),
          "button-ve-track-control_zoom_out": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              label: { 
                text: "-",
                color: VETheme.color.textShadow,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
                useScale: false,
                outline: true,
                outlineColor: VETheme.color.sideDark,
                font: "font_inter_8_bold",
              },
              layout: layout.nodes.zoom_out,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              store: {
                key: "timeline-zoom",
                set: Lambda.passthrough,
                callback: Lambda.passthrough,
              },
              callback: function(vvv) {
                if (!Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var value = item.get()
                if (!Core.isType(value, Number)) {
                  return
                }

                item.set(clamp(value - 1, 5, 30))
              },
              backgroundMargin: { top: 1, bottom: 1, left: 0, right: 1 },
              backgroundColor: VETheme.color.sideDark,
              backgroundColorSelected: VETheme.color.primaryLight,
              backgroundColorOut: VETheme.color.sideDark,
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              description: "Zoom out ( - )",
              render: function() {
                if (Optional.is(this.preRender)) {
                  this.preRender()
                }
                this.renderBackgroundColor()
          
                if (this.sprite != null) {
                  var alpha = this.sprite.getAlpha()
                  this.sprite
                    .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                    .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                    .render(
                      this.context.area.getX() + this.area.getX(),
                      this.context.area.getY() + this.area.getY())
                    .setAlpha(alpha)
                }
          
                if (this.label != null) {
                  this.label.alpha = this.backgroundAlpha
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2),
                    this.area.getWidth(), 
                    this.area.getHeight()
                  )
                }
    
                if (this.isHoverOver && this.enable.value) {
                  var text = this.label.text
                  var alignV = this.label.align.v
                  this.label.text = this.description
                  this.label.align.v = VAlign.BOTTOM
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY(),// + (this.area.getHeight() / 2)
                    this.area.getWidth(),
                    this.area.getHeight()
                  )
                  this.label.align.v = alignV
                  this.label.text = text
                }
                return this
              },
            },
            null,//VEStyles.get("ve-track-control").button,
            false
          ),
          "slider-ve-track-control_zoom": Struct.appendRecursive(
            { 
              type: UISliderHorizontal,
              layout: layout.nodes.zoom,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              getClipboard: Beans.get(BeanVisuEditorIO).mouse.getClipboard,
              setClipboard: Beans.get(BeanVisuEditorIO).mouse.setClipboard,
              minValue: 5.0,
              maxValue: 30.0,
              //snapValue: 1.0 / 15.0,
              notify: true,
              store: { key: "timeline-zoom" },
              onMouseHoverOver: function(event) { },
              onMouseHoverOut: function(event) { },
              updatePosition: function(mouseX, mouseY) {
                var controller = Beans.get(BeanVisuController)
                var editor = Beans.get(BeanVisuEditorController)
                var ruler = editor.uiService.find("ve-timeline-ruler")
                if (Optional.is(ruler)) {
                  ruler.finishUpdateTimer()
                }
    
                var events = editor.uiService.find("ve-timeline-events")
                if (Optional.is(events)) {
                  events.finishUpdateTimer()
                }
              },
              postRender: function() {
                if (!this.isHoverOver) {
                  return
                }

                var label = Struct.get(this, "label")
                if (!Optional.is(label)) {
                  label = new UILabel({
                    text: "", // "Zoom out / in\n( - / + )",
                    color: VETheme.color.textShadow,
                    align: { v: VAlign.BOTTOM, h: HAlign.CENTER },
                    useScale: false,
                    outline: true,
                    outlineColor: VETheme.color.sideDark,
                    font: "font_inter_8_bold",
                  })

                  Struct.set(this, "label", label)
                }

                this.label.render(
                  // todo VALIGN HALIGN
                  this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                  this.context.area.getY() + this.area.getY(),// + (this.area.getHeight() / 2)
                  this.area.getWidth(),
                  this.area.getHeight()
                )
              }
            },
            VEStyles.get("slider-horizontal-2"),
            false
          ),
          "button-ve-track-control_zoom_in": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              label: { 
                text: "+",
                color: VETheme.color.textShadow,
                align: { v: VAlign.CENTER, h: HAlign.CENTER },
                useScale: false,
                outline: true,
                outlineColor: VETheme.color.sideDark,
                font: "font_inter_8_bold",
              },
              layout: layout.nodes.zoom_in,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              store: {
                key: "timeline-zoom",
                set: Lambda.passthrough,
                callback: Lambda.passthrough,
              },
              callback: function(vvv) {
                if (!Core.isType(this.store, UIStore)) {
                  return
                }

                var item = this.store.get()
                if (!Core.isType(item, StoreItem)) {
                  return
                }

                var value = item.get()
                if (!Core.isType(value, Number)) {
                  return
                }

                item.set(clamp(value + 1, 5, 30))
              },
              backgroundMargin: { top: 1, bottom: 1, left: 0, right: 1 },
              backgroundColor: VETheme.color.sideDark,
              backgroundColorSelected: VETheme.color.primaryLight,
              backgroundColorOut: VETheme.color.sideDark,
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorSelected).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.backgroundColorOut).toGMColor()
              },
              description: "Zoom in ( + )",
              render: function() {
                if (Optional.is(this.preRender)) {
                  this.preRender()
                }
                this.renderBackgroundColor()
          
                if (this.sprite != null) {
                  var alpha = this.sprite.getAlpha()
                  this.sprite
                    .setAlpha(alpha * (Struct.get(this.enable, "value") == false ? 0.5 : 1.0))
                    .scaleToFillStretched(this.area.getWidth(), this.area.getHeight())
                    .render(
                      this.context.area.getX() + this.area.getX(),
                      this.context.area.getY() + this.area.getY())
                    .setAlpha(alpha)
                }
          
                if (this.label != null) {
                  this.label.alpha = this.backgroundAlpha
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY() + (this.area.getHeight() / 2),
                    this.area.getWidth(), 
                    this.area.getHeight()
                  )
                }
    
                if (this.isHoverOver && this.enable.value) {
                  var text = this.label.text
                  var alignV = this.label.align.v
                  this.label.text = this.description
                  this.label.align.v = VAlign.BOTTOM
                  this.label.render(
                    // todo VALIGN HALIGN
                    this.context.area.getX() + this.area.getX() + (this.area.getWidth() / 2),
                    this.context.area.getY() + this.area.getY(),// + (this.area.getHeight() / 2)
                    this.area.getWidth(),
                    this.area.getHeight()
                  )
                  this.label.align.v = alignV
                  this.label.text = text
                }
                return this
              },
            },
            null,//VEStyles.get("ve-track-control").button,
            false
          ),
        },
        onInit: function() {
          var bpm = this.items.get("text-field_ve-track-control_bpm_field").textField
          var meter = this.items.get("text-field_ve-track-control_meter_field").textField
          var sub = this.items.get("text-field_ve-track-control_sub_field").textField
          var shift = this.items.get("text-field_ve-track-control_shift_field").textField
          bpm.setPrevious(shift).setNext(meter)
          meter.setPrevious(bpm).setNext(sub)
          sub.setPrevious(meter).setNext(shift)
          shift.setPrevious(sub).setNext(bpm)
        }
      })
    })
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      this.containers = this.factoryContainers(event.data.layout)
      containers.forEach(function(container, key, uiService) {
        uiService.send(new Event("add", {
          container: container,
          replace: true,
        }))
      }, Beans.get(BeanVisuEditorController).uiService)
    },
    "close": function(event) {
      var context = this
      this.containers.forEach(function(container, key, uiService) {
        uiService.dispatcher.execute(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, Beans.get(BeanVisuEditorController).uiService).clear()
    },
  }), { 
    enableLogger: false, 
    catchException: false,
  })

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETrackControl}
  update = function() { 
    try {
      this.dispatcher.update()
    } catch (exception) {
      var message = $"VETrackControl dispatcher fatal error: {exception.message}"
      Beans.get(BeanVisuController).send(new Event("spawn-popup", { message: message }))
      Logger.error("UI", message)
    }
    return this
  }
}