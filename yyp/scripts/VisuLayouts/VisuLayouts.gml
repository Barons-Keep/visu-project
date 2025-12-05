///@package io.alkapivo.visu.ui

///@type {Number}
#macro VISU_MENU_ENTRY_HEIGHT 80

///@type {Map<String, Callable>}
global.__VisuLayouts = new Map(String, Callable, {

  ///@param {?Struct} [config]
  ///@return {Struct}
  "menu-title": function(config = null) {
    return {
      name: "visu-menu.title",
      nodes: {
        label: {
          name: "visu-menu.title.label",
        }
      }
    }
  },

  ///@param {?Struct} [config]
  ///@return {Struct}
  "menu-button-entry": function(config = null) {
    return {
      name: "visu-menu.content.entry",
      type: Core.isEnum(Struct.get(config, "type"), UILayoutType)
        ? config.type
        : UILayoutType.VERTICAL,
      collection: true,
      x: function() { return 0 },
      y: function() { return this.collection.getIndex() * this.height() },
      width: function() { return this.context.width() },
      height: function() { return VISU_MENU_ENTRY_HEIGHT },
      nodes: {
        label: {
          name: "visu-menu.content.entry.label",
          width: function() { return this.context.width() },
          height: function() { return this.context.height() },
          x: function() { return this.context.x() },
          y: function() { return this.context.y() },
        }
      }
    }
  },

  "menu-button-input-entry": function(config = null) {
    return {
      name: "menu-button-input-entry",
      type: Core.isEnum(Struct.get(config, "type"), UILayoutType)
        ? config.type
        : UILayoutType.VERTICAL,
      collection: true,
      x: function() { return 0 },
      y: function() { return this.collection.getIndex() * this.height() },
      width: function() { return this.context.width() },
      height: function() { return VISU_MENU_ENTRY_HEIGHT },
      nodes: {
        label: {
          name: "menu-button-input-entry.label",
          width: function() { return this.context.width() * 0.66 },
          height: function() { return this.context.height() },
          x: function() { return this.context.x() },
          y: function() { return this.context.y() },
        },
        input: {
          name: "menu-button-input-entry.input",
          width: function() { return this.context.width() * 0.33 },
          height: function() { return this.context.height() },
          x: function() { return this.context.nodes.label.right() },
          y: function() { return this.context.y() },
        }
      }
    }
  },

  ///@param {?Struct} [config]
  ///@return {Struct}
  "menu-spin-select-entry": function(config = null) {
    return {
      name: "menu-spin-select-entry",
      type: Core.isEnum(Struct.get(config, "type"), UILayoutType)
        ? config.type
        : UILayoutType.VERTICAL,
      collection: true,
      x: function() { return 0 },
      y: function() { return this.collection.getIndex() * this.height() },
      width: function() { return this.context.width() },
      height: function() { return VISU_MENU_ENTRY_HEIGHT },
      nodes: {
        label: {
          name: "menu-spin-select.label",
          x: function() { return this.context.x() },
          y: function() { return this.context.y() },
          width: function() { return this.context.width() * 0.66 },
        },
        previous: {
          name: "menu-spin-select.previous",
          x: function() { return this.context.nodes.label.right() },
          y: function() { return this.context.y() },
          width: function() { return VISU_MENU_ENTRY_HEIGHT * 0.5 },
        },
        preview: {
          name: "menu-spin-select.preview",
          x: function() { return this.context.nodes.previous.right() },
          y: function() { return this.context.y() },
          width: function() { return (this.context.width() * 0.33)
            - this.context.nodes.previous.width()
            - this.context.nodes.next.width() },
        },
        next: {
          name: "menu-spin-spin-select.next",
          x: function() { return this.context.nodes.preview.right() },
          y: function() { return this.context.y() },
          width: function() { return VISU_MENU_ENTRY_HEIGHT * 0.5 },
        },
      }
    }
  },

  ///@param {?Struct} [config]
  ///@return {Struct}
  "menu-slider-entry": function(config = null) {
    return {
      name: "menu-slider-entry",
      type: Core.isEnum(Struct.get(config, "type"), UILayoutType)
        ? config.type
        : UILayoutType.VERTICAL,
      collection: true,
      x: function() { return 0 },
      y: function() { return this.collection.getIndex() * this.height() },
      width: function() { return this.context.width() },
      height: function() { return VISU_MENU_ENTRY_HEIGHT },
      nodes: {
        label: {
          name: "menu-slider-entry.label",
          x: function() { return this.context.x() },
          y: function() { return this.context.y() },
          width: function() { return this.context.width() * 0.66 },
          height: function() { return this.context.height() },
        },
        slider: {
          name: "menu-slider-entry.slider",
          x: function() { return this.context.nodes.label.right() + this.__margin.left },
          width: function() { return this.context.width()
            - this.__margin.left 
            - this.__margin.right 
            - this.context.nodes.label.width() 
            - this.context.nodes.label.__margin.left
            - this.context.nodes.label.__margin.right },
          margin: { left: 16, right: 20 },
          height: function() { return this.context.height() },
        },
      }
    }
  },

  ///@param {?Struct} [config]
  ///@return {Struct}
  "menu-keyboard-key-entry": function(config = null) {
    return {
      name: "menu-keyboard-key-entry",
      type: Core.isEnum(Struct.get(config, "type"), UILayoutType)
        ? config.type
        : UILayoutType.VERTICAL,
      collection: true,
      x: function() { return 0 },
      y: function() { return this.collection.getIndex() * this.height() },
      width: function() { return this.context.width() },
      height: function() { return VISU_MENU_ENTRY_HEIGHT },
      nodes: {
        label: {
          name: "menu-keyboard-key-entry.label",
          x: function() { return this.context.x() },
          y: function() { return this.context.y() },
          width: function() { return this.context.width() / 2.0 },
        },
        preview: {
          name: "menu-keyboard-key-entry.preview",
          x: function() { return this.context.x() + this.width() },
          y: function() { return this.context.y() },
          width: function() { return this.context.width() / 2.0 },
        },
      }
    }
  },

  ///@param {?Struct} [config]
  ///@return {Struct}
  "spin-select": function(config = null) {
      ///@return {Callable}
      static factoryNodeHeight = function() {
        return function() {
          return Struct.getDefault(this, "heightValue", 28)
        }
      }
      
    var hidden = Struct.getDefault(config, "hidden", false)
    return {
      name: "spin-select",
      margin: Struct.getDefault(config, "margin", { top: 2 }),
      hidden: hidden,
      height: Struct.getDefault(config, "height", factoryNodeHeight()),
      nodes: {
        label: {
          name: "spin-select.label",
          margin: { top: 2, bottom: 2, left: 5 },
          hidden: hidden,
          width: function() { return 72 - this.__margin.left - this.__margin.right },
        },
        previous: {
          name: "spin-select.previous",
          margin: { top: 0, bottom: 0, right: 0, left: 6 },
          hidden: hidden,
          x: function() { return this.context.nodes.label.right() + this.__margin.left },
          y: function() { return this.context.y() + round((this.context.height() - this.height()) / 2.0) },
          width: function() { return 14 },
          height: factoryNodeHeight(),
        },
        preview: {
          name: "spin-select.preview",
          hidden: hidden,
          propagateHidden: true,
          x: function() {
            var labelRight = this.context.nodes.label.right()
            return labelRight + (this.context.width() - labelRight - this.width()) / 2.0
          },
          width: function() { return this.context.width() - this.context.nodes.label.right() },
        },
        next: {
          name: "spin-select.next",
          margin: { top: 0, bottom: 0, right: 6, left: 0 },
          hidden: hidden,
          x: function() {
            var margin = this.context.__margin
            return this.context.x() + margin.left + this.context.width() + margin.right - this.width() - this.__margin.right
          },
          y: function() { return this.context.y() + round((this.context.height() - this.height()) / 2.0) },
          width: function() { return 14 },
          height: factoryNodeHeight(),
        },
      }
    }
  },

  ///@param {?Struct} [config]
  ///@return {Struct}
  "header": function(config = null) {
    var hidden = Struct.getDefault(config, "hidden", false)
    return {
      name: "header",
      margin: Struct.getDefault(config, "margin", { top: 2 }),
      hidden: hidden,
      nodes: {
        checkbox: {
          name: "header.checkbox",
          width: function() { return 24 },
          margin: { left: 5, right: 2 },
        },
        label: {
          name: "header.label",
          propagateHidden: true,
          x: function() { return this.context.nodes.checkbox.right() },
          width: function() {
            var checkbox = this.context.nodes.checkbox
            var input = this.context.nodes.input
            return this.context.width() 
              - checkbox.width()
              - checkbox.__margin.right
              - input.width() 
              - input.__margin.right 
              - input.__margin.left
          },
        },
        input: {
          name: "property.input",
          margin: { left: 0, right: 7 },
          x: function() { return this.context.nodes.label.right() + this.__margin.left },
          width: function() { return 42 },
        },
      }
    }
  },

  ///@param {?Struct} [config]
  ///@return {Struct}
  "number-property": function(config = null) {
    ///@return {Callable}
    static factoryNodeHeight = function() {
      return function() {
        return Struct.getDefault(this, "heightValue", 28)
      }
    }

    ///@param {Number} [index]
    ///@return {Callable}
    static factoryNodeY = function() {
      return function() {
        var context = this.context
        var index = Struct.getDefault(this, "index", 0)
        return context.y() + context.__margin.top + context.nodes.header.height() + (this.height() * index)
      }
    }

    var hidden = Struct.getDefault(config, "hidden", false)
    return {
      name: "number-property",
      type: Struct.getDefault(config, "type", UILayoutType.VERTICAL),
      hidden: hidden,
      margin: Struct.get(config, "margin"),
      height: function() {
        var nodes = this.nodes
        return nodes.header.height() + (nodes.ease.index * nodes.ease.height())
      },
      nodes: {
        header: {
          name: "number-property.header",
          hidden: hidden,
          height: Struct.getIfType(Struct.get(config, "header"), "height", Callable, factoryNodeHeight()),
        },
        value: {
          name: "number-property.value",
          hidden: hidden,
          propagateHidden: true,
          y: factoryNodeY(),
          height: factoryNodeHeight(),
        },
        target: {
          name: "number-property.target",
          hidden: hidden,
          index: 1,
          y: factoryNodeY(),
          height: factoryNodeHeight(),
        },
        duration: {
          name: "number-property.duration",
          hidden: hidden,
          index: 2,
          y: factoryNodeY(),
          height: factoryNodeHeight(),
        },
        ease: {
          name: "number-property.ease",
          hidden: hidden,
          index: 3,
          y: factoryNodeY(),
          height: factoryNodeHeight(),
        },
      }
    }
  },
})
#macro VisuLayouts global.__VisuLayouts