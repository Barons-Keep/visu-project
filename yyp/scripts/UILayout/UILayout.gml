///@package io.alkapivo.core.service.ui

///@enum
function _UILayoutType(): Enum() constructor {
  NONE = "none"
  VERTICAL = "vertical"
  HORIZONTAL = "horizontal"
}
global.__UILayoutType = new _UILayoutType()
#macro UILayoutType global.__UILayoutType


///@param {?Struct} [json]
function Margin(json = null) constructor {
  
  ///@type {Number}
  top = Struct.getIfType(json, "top", Number, 0.0)
  
  ///@type {Number}
  bottom = Struct.getIfType(json, "bottom", Number, 0.0)
  
  ///@type {Number}
  left = Struct.getIfType(json, "left", Number, 0.0)
  
  ///@type {Number}
  right = Struct.getIfType(json, "right", Number, 0.0)
}


///@param {?Struct} [config]
function UILayoutIterator(config = null) constructor {
  
  ///@type {Number}
  index = Struct.getIfType(config, "index", Number, 0.0)
  
  ///@type {Number}
  size = Struct.getIfType(config, "size", Number, 1.0)
  
  ///@return {Number}
  static getIndex = function() { 
    gml_pragma("forceinline")
    return this.index
  }
  
  ///@return {Number}
  static getSize = function() {
    gml_pragma("forceinline")
    return this.size
  }
  
  ///@param {Number} index
  ///@return {UILayoutIterator}
  static setIndex = function(index) { 
    gml_pragma("forceinline")
    this.index = index
    return this
  }

  ///@param {Number} size
  ///@return {UILayoutIterator}
  static setSize = function(size) { 
    gml_pragma("forceinline")
    this.size = size
    return this
  }
}


///@param {Struct} config
///@param {?UILayout} [_context]
function UILayout(config, _context = null) constructor {

  ///@private
  ///@return {Callable}
  static parseX = function() {
    gml_pragma("forceinline")
    if (!Optional.is(this.context)) {
      return function() {
        return this.__margin.left
      }
    } 
    
    return this.type == UILayoutType.HORIZONTAL
      ? function() {
        return this.context.right() + this.__margin.left
      }
      : function() {
        return this.context.x() + this.__margin.left
      }
  }

  ///@private
  ///@return {Callable}
  static parseY = function() {
    gml_pragma("forceinline")
    if (!Optional.is(this.context)) {
      return function() {
        return this.__margin.top
      }
    }

    return this.type == UILayoutType.VERTICAL
      ? function() {
        return this.context.bottom() + this.__margin.top
      }
      : function() {
        return this.context.y() + this.__margin.top
      }
  }

  ///@private
  ///@param {?UILayout} [context]
  ///@param {?Struct} [config]
  ///@return {Struct}
  static parseNodes = function(config = null, context = null) {
    gml_pragma("forceinline")
    static parseNode = function(node, name, context) {
      return new UILayout(node, context)
    }

    return Optional.is(Struct.getIfType(config, "nodes", Struct))
      ? Struct.map(config.nodes, parseNode, context)
      : { } 
  }

  static parseMargin = function() {
    gml_pragma("forceinline")
  }
  
  ///@param {?UILayout}
  context = Core.getIfType(_context, UILayout)

  ///@type {UILayoutType}
  type = Struct.getIfEnum(config, "type", UILayoutType, UILayoutType.NONE)

  ///@type {UILayoutType}
  orientation = this.type != UILayoutType.NONE
    ? this.type
    : (this.context != null && Struct.get(this.context, "type") != UILayoutType.NONE
      ? this.context.type
      : UILayoutType.VERTICAL)

  ///@type {?String}
  name = Struct.getIfType(config, "name", String)
  
  ///@type {?Struct}
  collection = Struct.getIfType(context, "collection", UILayoutIterator, (Struct
    .contains(config, "collection") ? new UILayoutIterator(config.collection) : null))

  ///@type {Struct}
  nodes = this.parseNodes(config, this)

  ///@type {Boolean}
  hidden = Struct.getIfType(config, "hidden", Boolean, false)

  ///@type {Boolean}
  propagateHidden = Struct.getIfType(config, "propagateHidden", Boolean, false)

  ///@type {Margin}
  marginRef = new Margin(Struct.getIfType(config, "margin", Struct))

  ///@type {Margin}
  marginHidden = new Margin()
  switch (this.type) {
    case UILayoutType.VERTICAL:
      this.marginHidden.top = 0
      this.marginHidden.bottom = 0
      this.marginHidden.left = this.marginRef.left
      this.marginHidden.right = this.marginRef.right
      break
    case UILayoutType.HORIZONTAL:
      this.marginHidden.top = this.marginRef.top
      this.marginHidden.bottom = this.marginRef.bottom
      this.marginHidden.left = 0
      this.marginHidden.right = 0
      break
    default:
      this.marginHidden.top = 0
      this.marginHidden.bottom = 0
      this.marginHidden.left = 0
      this.marginHidden.right = 0
      break
  }

  ///@type {Margin}
  __margin = marginRef

  ///@return {Margin}
  getMargin = function() {
    if (this.hidden) {
      switch (this.type) {
        case UILayoutType.VERTICAL:
          this.marginHidden.top = 0
          this.marginHidden.bottom = 0
          this.marginHidden.left = this.marginRef.left
          this.marginHidden.right = this.marginRef.right
          break
        case UILayoutType.HORIZONTAL:
          this.marginHidden.top = this.marginRef.top
          this.marginHidden.bottom = this.marginRef.bottom
          this.marginHidden.left = 0
          this.marginHidden.right = 0
          break
        default:
          this.marginHidden.top = 0
          this.marginHidden.bottom = 0
          this.marginHidden.left = 0
          this.marginHidden.right = 0
          break
      }
      return this.marginHidden
    } else {
      return this.marginRef
    }
  }

  ///@return {Number}
  x = method(this, Optional.is(Struct.getIfType(config, "x", Callable)) ? config.x : this.parseX())

  ///@return {Number}
  y = method(this, Optional.is(Struct.getIfType(config, "y", Callable)) ? config.y : this.parseY())

  ///@return {Number}
  width = function() {
    return this.hidden && this.orientation == UILayoutType.HORIZONTAL
      ? 0.0 : this.proxyWidth()
  }

  ///@return {Number}
  height = function() {
    return this.hidden && this.orientation == UILayoutType.VERTICAL
      ? 0.0 : this.proxyHeight()
  }

  ///@return {Number}
  proxyWidth = method(this, Struct.getIfType(config, "width", Callable, Optional.is(this.context)
    ? function() {
      return this.context.width() - this.__margin.left - this.__margin.right
    }
    : function() {
      return 0
    }
  ))

  ///@return {Number}
  proxyHeight = method(this, Struct.getIfType(config, "height", Callable, Optional.is(this.context)
    ? function() { 
      return this.context.height() - this.__margin.top - this.__margin.bottom
    }
    : function() {
      return 0
    }
  ))
  
  ///@return {Number}
  left = method(this, Struct.getIfType(config, "left", Callable, function() {
    return this.x() - this.__margin.left
  }))

  ///@return {Number}
  top = method(this, Struct.getIfType(config, "top", Callable, function() {
    return this.y() - this.__margin.top
  }))

  ///@return {Number}
  right = method(this, Struct.getIfType(config, "right", Callable, function() {
    return this.x() + this.width() + this.__margin.right
  }))
  
  ///@return {Number}
  bottom = method(this, Struct.getIfType(config, "bottom", Callable, function() {
    return this.y() + this.height() + this.__margin.bottom
  }))

  ///@param {Boolean} hidden
  ///@return {UILayer}
  updateHidden = function(hidden) {
    static updateNodeHidden = function(node, key, hidden) {
      node.hidden = hidden
      node.__margin = hidden ? node.marginHidden : node.marginRef
    }

    updateNodeHidden(this, null, hidden)
    this.fetchNodes().forEach(updateNodeHidden, hidden)
    if (this.propagateHidden && this.context != null) {
      this.context.updateHidden(hidden)
    }

    return this
  }

  nodeMap = null

  ///@return {Map<String, UILayout>}
  fetchNodes = function() {
    if (this.nodeMap == null) {
      this.nodeMap = Struct.toMap(this.nodes, String, UILayout)
    }

    return this.nodeMap
  }
  
  Struct.appendUnique(this, config, true)
}


///@static
function _UILayoutUtil() constructor {

  ///@return {Callable}
  sumNodesHeight = function() {
    return function() {
      static sumHeight = function(node, name, acc) {
        acc.height = acc.height + node.height()
      }

      var acc = { height: 0 }
      Struct.forEach(this.nodes, sumHeight, acc)
      return acc.height
    }
  }

  ///@return {Callable}
  areNodesHidden = function() {
    return function() {
      var nodeKeys = Struct.get(this, "nodeKeys")
      if (!Optional.is(nodeKeys)) {
        nodeKeys = Struct.keys(this.nodes)
        Struct.set(this, "nodeKeys", nodeKeys)
      }
      
      var size = GMArray.size(nodeKeys)
      for (var index = 0; index < size; index++) {
        var node = Struct.get(this.nodes, this.nodeKeys[index])
        if (!node.hidden) {
          return false
        }
      }

      return true
    }
  }
}
global.__UILayoutUtil = new _UILayoutUtil()
#macro UILayoutUtil global.__UILayoutUtil


///@debug
/*
global.____uiLayoutCounter = {
  _x: 0,
  _y: 0,
  _w: 0,
  _h: 0,
  xAcc: 0,
  yAcc: 0,
  wAcc: 0,
  hAcc: 0,
  xMax: 0,
  yMax: 0,
  wMax: 0,
  hMax: 0,
  x: function() {
    this._x += 1
    this.xAcc += 1
    this.xMax = max(this.xAcc, this.xMax)
    return this
  },
  y: function() {
    this._y += 1
    this.yAcc += 1
    this.yMax = max(this.yAcc, this.yMax)
    return this
  },
  w: function() {
    this._w += 1
    this.wAcc += 1
    this.wMax = max(this.wAcc, this.wMax)
    return this
  },
  h: function() {
    this._h += 1
    this.hAcc += 1
    this.hMax = max(this.hAcc, this.hMax)
    return this
  },
  timer: new Timer(1.0, { loop: Infinity }),
  reset: function() {
    this._x = 0
    this._y = 0
    this._w = 0
    this._h = 0
    return this
  },
  resetAcc: function() {
    this.xAcc = 0
    this.yAcc = 0
    this.wAcc = 0
    this.hAcc = 0
    return this
  },
  print: function() {
    var d = GAME_FPS * this.timer.duration
    Core.print($"#{string_format(this.timer.loopCounter, 3, 0)} | x: {string_format(this._x / d, 6, 0)} y: {string_format(this._y / d, 6, 0)}, w: {string_format(this._w / d, 6, 0)}, h: {string_format(this._h / d, 6, 0)}, xmax: {string_format(this.xMax, 6, 0)}, ymax: {string_format(this.yMax, 6, 0)}, wmax: {string_format(this.wMax, 6, 0)}, hmax: {string_format(this.hMax, 6, 0)}")
    return this
  }
}

updateBegin = function() {
  if (global.____uiLayoutCounter.timer.update().finished) {
    global.____uiLayoutCounter.print()
    global.____uiLayoutCounter.reset()
  }
  global.____uiLayoutCounter.resetAcc()
}

///@param {Struct} config
///@param {?UILayout} [_context]
function UILayout(config, _context = null) constructor {

  ///@private
  ///@return {Callable}
  static parseX = function() {
    if (this.context == null) {
      return function() { return this.__margin.left }
    } 

    switch (this.type) {
      case UILayoutType.HORIZONTAL: return function() { return this.context.right() 
        + this.__margin.left }
      default: return function() { return this.context.x() + this.__margin.left }
    }
  }

  ///@private
  ///@return {Callable}
  static parseY = function() {
    if (this.context == null) {
      return function() { return this.__margin.top }
    }

    switch (this.type) {
      case UILayoutType.VERTICAL: return function() { return this.context.bottom() 
        + this.__margin.top }
      default: return function() { return this.context.y() + this.__margin.top }
    }
  }

  ///@private
  ///@param {?UILayout} [context]
  ///@param {?Struct} [config]
  ///@return {Struct}
  static parseNodes = function(config = null, context = null) {
    static parseNode = function(node, name, context) {
      return new UILayout(node, context)
    }

    return Struct.contains(config, "nodes")
      ? Struct.map(Assert.isType(config.nodes, Struct), parseNode, context)
      : {} 
  }
  
  ///@param {?UILayout}
  context = Core.getIfType(_context, UILayout)

  ///@type {UILayoutType}
  type = Struct.getIfEnum(config, "type", UILayoutType, UILayoutType.NONE)
  
  ///@type {?String}
  name = Struct.getIfType(config, "name", String)

  ///@return {Margin}
  margin = new Margin(Struct.getIfType(config, "margin", Struct))

  x = function() {
    global.____uiLayoutCounter.x()
    return this.____x()
  }

  y = function() {
    global.____uiLayoutCounter.y()
    return this.____y()
  }

  width = function() {
    global.____uiLayoutCounter.w()
    return this.____width()
  }

  height = function() {
    global.____uiLayoutCounter.h()
    return this.____height()
  }
  
  ///@return {Number}
  ____x = method(this, Optional.is(Struct.getIfType(config, "x", Callable)) ? config.x : this.parseX())

  ///@return {Number}
  ____y = method(this, Optional.is(Struct.getIfType(config, "y", Callable)) ? config.y : this.parseY())

  ///@return {Number}
  ____width = method(this, Struct.getIfType(config, "width", Callable, Optional.is(this.context)
    ? function() { return this.context.width() - this.__margin.left - this.__margin.right }
    : function() { return 0 } ))

  ///@return {Number}
  ____height = method(this, Struct.getIfType(config, "height", Callable, Optional.is(this.context)
    ? function() { return this.context.height() - this.__margin.top - this.__margin.bottom }
    : function() { return 0 } ))
  
  ///@return {Number}
  left = method(this, Struct.getIfType(config, "left", Callable, function() {
    return this.x() - this.__margin.left
  }))

  ///@return {Number}
  top = method(this, Struct.getIfType(config, "top", Callable, function() {
    return this.y() - this.__margin.top
  }))

  ///@return {Number}
  right = method(this, Struct.getIfType(config, "right", Callable, function() {
    return this.x() + this.width() + this.__margin.right
  }))
  
  ///@return {Number}
  bottom = method(this, Struct.getIfType(config, "bottom", Callable, function() {
    return this.y() + this.height() + this.__margin.bottom
  }))

  ///@type {?Struct}
  collection = Struct.getIfType(context, "collection", UILayoutIterator, Struct
    .contains(config, "collection") 
      ? new UILayoutIterator(config.collection) 
      : null)
  
  ///@type {Struct}
  nodes = this.parseNodes(config, this)

  Struct.appendUnique(this, config, true)
}

*/