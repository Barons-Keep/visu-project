
///@package io.alkapivo.visu.ui.controller

///@param {?Struct} [_config]
function VisuModal(_config = null) constructor {

  ///@type {?Struct}
  config = Optional.is(_config) ? Assert.isType(_config, Struct) : null

  ///@type {Map<String, Containers>}
  containers = new Map(String, UI)

  ///@private
  ///@param {UIlayout} parent
  ///@return {UILayout}
  factoryLayout = function(parent) {
    return new UILayout(
      {
        name: "visu-modal",
        x: function() { return (this.context.width() - this.width()) / 2 },
        y: function() { return (this.context.height() - this.height()) / 2 },
        width: function() { return 260 },
        height: function() { return 100 },
        nodes: {
          message: {
            name: "visu-modal.message",
            x: function() { return this.__margin.left },
            y: function() { return this.__margin.top },
            height: function() { return 50 - this.__margin.top - this.__margin.bottom },
            margin: { top: 8, left: 8, right: 8, bottom: 8 },
          },
          accept: {
            name: "visu-modal.accept",
            x: function() { return this.__margin.left },
            y: function() { return this.context.nodes.message.height()
              + this.context.nodes.message.__margin.top
              + this.context.nodes.message.__margin.bottom
              + this.__margin.top },
            width: function() { return (this.context.width() / 2)
              - this.__margin.left
              - this.__margin.right },
            height: function() { return this.context.height() 
              - this.context.nodes.message.height() 
              - this.context.nodes.message.__margin.top
              - this.context.nodes.message.__margin.bottom 
              - this.__margin.top
              - this.__margin.bottom },
            margin: { top: 8, left: 8, right: 8, bottom: 8 },
          },
          deny: {
            name: "visu-modal.deny",
            x: function() { return (this.context.width() / 2) 
              + this.__margin.left },
            y: function() { return this.context.nodes.message.height()
              + this.context.nodes.message.__margin.top
              + this.context.nodes.message.__margin.bottom
              + this.__margin.top },
            width: function() { return (this.context.width() / 2)
              - this.__margin.left
              - this.__margin.right },
            height: function() { return this.context.height() 
              - this.context.nodes.message.height() 
              - this.context.nodes.message.__margin.top
              - this.context.nodes.message.__margin.bottom 
              - this.__margin.top
              - this.__margin.bottom },
            margin: { top: 8, left: 8, right: 8, bottom: 8 },
          }
        }
      },
      parent
    )
  }

  ///@private
  ///@param {?UIlayout} [parent]
  ///@return {Map<String, UI>}
  factoryContainers = function(parent = null) {
    var modal = this
    var layout = this.factoryLayout(parent)
    return new Map(String, UI, {
      "visu-modal": new UI({
        name: "visu-modal",
        state: new Map(String, any, {
          "background-color": ColorUtil.fromHex(VisuTheme.color.primary).toGMColor(),
        }),
        modal: modal,
        layout: layout,
        updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
        render: Callable.run(UIUtil.renderTemplates.get("renderDefault")),
        items: {
          "visu-modal.message": Struct.appendRecursiveUnique(
            {
              type: UIText,
              layout: layout.nodes.message,
              text: modal.config.message.text,
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
            },
            VEStyles.get("visu-modal").message,
            false
          ),
          "visu-modal.accept": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              layout: layout.nodes.accept,
              label: { text: modal.config.accept.text },
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              onMouseReleasedLeft: modal.config.accept.callback,
              colorHoverOver: VisuTheme.color.accept,
              colorHoverOut: VisuTheme.color.acceptShadow,
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
              },
            },
            VEStyles.get("visu-modal").accept,
            false
          ),
          "visu-modal.deny": Struct.appendRecursiveUnique(
            {
              type: UIButton,
              layout: layout.nodes.deny,
              label: { text: modal.config.deny.text },
              updateArea: Callable.run(UIUtil.updateAreaTemplates.get("applyLayout")),
              onMouseReleasedLeft: modal.config.deny.callback,
              colorHoverOver: VisuTheme.color.deny,
              colorHoverOut: VisuTheme.color.denyShadow,
              onMouseHoverOver: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOver).toGMColor()
              },
              onMouseHoverOut: function(event) {
                this.backgroundColor = ColorUtil.fromHex(this.colorHoverOut).toGMColor()
              },
            },
            VEStyles.get("visu-modal").deny,
            false
          ),
        },
      }),
    })
  }

  ///@type {EventPump}
  dispatcher = new EventPump(this, new Map(String, Callable, {
    "open": function(event) {
      var controller = Beans.get(BeanVisuController)
      var editor = Beans.get(Visu.modules().editor.controller)
      var uiService = Optional.is(editor) ? editor.uiService : controller.uiService
      this.dispatcher.execute(new Event("close"))
      this.containers = this.factoryContainers(event.data.layout)
      containers.forEach(function(container, key, uiService) {
        uiService.send(new Event("add", {
          container: container,
          replace: true,
        }))
      }, uiService)
    },
    "close": function(event) {
      var context = this
      var controller = Beans.get(BeanVisuController)
      var editor = Beans.get(Visu.modules().editor.controller)
      var uiService = Optional.is(editor) ? editor.uiService : controller.uiService
      this.containers.forEach(function(container, key, uiService) {
        uiService.send(new Event("remove", { 
          name: key, 
          quiet: true,
        }))
      }, uiService).clear()
    },
  }))

  ///@param {Event} event
  ///@return {?Promise}
  send = function(event) {
    return this.dispatcher.send(event)
  }

  ///@return {VETrackControl}
  update = function() { 
    this.dispatcher.update()
    return this
  }
}