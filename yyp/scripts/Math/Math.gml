///@package io.alkapivo.core.lang

///@static
function _Vector() constructor {

  ///@param {Struct} json
  ///@param {Vector2|Vector3|Vector4} type
  ///@throws {ParseException}
  ///@return {Vector2|Vector3|Vector4}
  static parse = function(json, type) {
    switch (type) {
      case Vector2:
        return new Vector2(
          Struct.getIfType(json, "x", Number, 0.0), 
          Struct.getIfType(json, "y", Number, 0.0)
        )
      case Vector3:
        return new Vector3(
          Struct.getIfType(json, "x", Number, 0.0), 
          Struct.getIfType(json, "y", Number, 0.0), 
          Struct.getIfType(json, "z", Number, 0.0)
        )
      case Vector4:
        return new Vector4(
          Struct.getIfType(json, "x", Number, 0.0), 
          Struct.getIfType(json, "y", Number, 0.0), 
          Struct.getIfType(json, "z", Number, 0.0), 
          Struct.getIfType(json, "a", Number, 0.0)
        )
      default:
        throw new ParseException()
    }
  }
}
global.__Vector = new _Vector()
#macro Vector global.__Vector


///@param {Number} _x
///@param {Number} _y
function Vector2(_x = 0.0, _y = 0.0) constructor {

  ///@type {Number}
  x = Assert.isType(_x, Number)

  ///@type {Number}
  y = Assert.isType(_y, Number)

  ///@param {Vector2} vec2
  ///@return {Boolean}
  static areEqual = function(vec2) {
      return this.x == vec2.x && this.y == vec2.y
  }

  ///@return {Struct}
  serialize = function() {
    return {
      x: this.x,
      y: this.y,
    }
  }
}


///@param {Number} _x
///@param {Number} _y
///@param {Number} _z
function Vector3(_x = 0.0, _y = 0.0, _z = 0.0) constructor {

  ///@type {Number}
  x = Assert.isType(_x, Number)

  ///@type {Number}
  y = Assert.isType(_y, Number)

  ///@type {Number}
  z = Assert.isType(_z, Number)

  ///@return {Struct}
  serialize = function() {
    return {
      x: this.x,
      y: this.y,
      z: this.z,
    }
  }
}


///@param {Number} _x
///@param {Number} _y
///@param {Number} _z
///@param {Number} _a
function Vector4(_x = 0.0, _y = 0.0, _z = 0.0, _a = 0.0) constructor {

  ///@type {Number}
  x = Assert.isType(_x, Number)

  ///@type {Number}
  y = Assert.isType(_y, Number)

  ///@type {Number}
  z = Assert.isType(_z, Number)

  ///@type {Number}
  a = Assert.isType(_a, Number)

  ///@return {Struct}
  serialize = function() {
    return {
      x: this.x,
      y: this.y,
      z: this.z,
      a: this.a,
    }
  }
}


///@param {?Struct} [json]
function Rectangle(json = null) constructor {

  ///@override
  ///@type {Number}
  x = Struct.getIfType(json, "x", Number, 0)

  ///@override
  ///@type {Number}
  y = Struct.getIfType(json, "y", Number, 0)

  ///@override
  ///@type {Number}
  z = Struct.getIfType(json, "width", Number, 0)

  ///@override
  ///@type {Number}
  a = Struct.getIfType(json, "height", Number, 0)

  ///@return {Number}
  getX = function() {
    return this.x
  }

  ///@return {Number}
  getY = function() {
    return this.y
  }

  ///@return {Number}
  getWidth = function() {
    return this.z
  }

  ///@return {Number}
  getHeight = function() {
    return this.a
  }

  ///@param {Number} x
  ///@return {Area}
  setX = function(x) {
    this.x = x
    return this
  }

  ///@param {Number} y
  ///@return {Area}
  setY = function(y) {
    this.y = y
    return this
  }

  ///@param {Number} width
  ///@return {Area}
  setWidth = function(width) {
    this.z = width
    return this
  }

  ///@param {Number} height
  ///@return {Area}
  setHeight = function(height) {
    this.a = height
    return this
  }

  ///@param {Number} x
  ///@param {Number} y
  ///@return {Boolean}
  collide = function(x, y) {
    return x >= this.getX() 
      && x <= this.getX() + this.getWidth() 
      && y >= this.getY() 
      && y <= this.getY() + this.getHeight()
  }

  ///@override
  ///@return {Struct}
  serialize = function() {
    return {
      x: this.getX(),
      y: this.getY(),
      width: this.getWidth(),
      height: this.getHeight(),
    }
  }
}


///@param {Number} _width
///@param {Number} _height
function Ellipse(_width, _height) constructor {
    
  ///@type {Number}
  width = _width

  ///@type {Number}
  height = _height
  
  ///@private
  ///@type {Number} angle
  ///@return {Number}
  static fetchRadiusFactor = function(angle) {
    return (this.width * this.height) / Math.sqr(
        (Math.pow(this.width, 2) * Math.pow(sin(angle), 2)) + 
        (Math.pow(this.height, 2) * Math.pow(cos(angle), 2))
    )
  }

  ///@param {Number} angle
  ///@return {Number}
  static fetchX = function(angle) {
    return this.fetchRadiusFactor(angle) * cos(angle)
  }

  ///@param {Number} angle
  ///@return {Number}
  static fetchY = function(angle) {
    return this.fetchRadiusFactor(angle) * sin(angle)
  }

  ///@param {Number} angle
  ///@param {Vector2<Number>} [vec2]
  ///@return {Vector2<Number>}
  static fetchVector2 = function(angle, vec2 = new Vector2()) {
    vec2.x = this.fetchX(angle)
    vec2.y = this.fetchY(angle)
    return vec2
  }
}


///@static
function _Math() constructor {

  ///@param {Number} fromX
  ///@param {Number} fromY
  ///@param {Number} toX
  ///@param {Number} toY
  ///@return {Number}
  static fetchPointsAngle = function(fromX, fromY, toX, toY) {
    gml_pragma("forceinline")
    return point_direction(fromX, fromY, toX, toY)
  }

  ///@param {Number} source
  ///@param {Number} target
  ///@return {Number}
  static fetchPointsAngleDiff = function(source, target) {
    gml_pragma("forceinline")
    return angle_difference(source, target)
  }

  ///@param {Number} angle
  ///@return {Number}
  static normalizeAngle = function(angle) {
    gml_pragma("forceinline")
    return (angle mod 360 + 360) mod 360;
  }

  ///@param {Number} from
  ///@param {Number} to
  ///@param {Number} factor
  ///@return {Number}
  static lerpAngle = function(from, to, factor) {
    gml_pragma("forceinline")
    var _from = (from mod 360 + 360) mod 360
    var _to = (to mod 360 + 360) mod 360
    var diff = _to - _from
    if (abs(diff) > 180) {
      if (diff > 0) {
        diff -= 360
      } else {
        diff += 360
      }
    }

    var result = _from + diff * factor
    return (result mod 360 + 360) mod 360
  }

  ///@param {Number} fromX
  ///@param {Number} fromY
  ///@param {Number} toX
  ///@param {Number} toY
  ///@return {Number}
  static fetchLength = function(fromX, fromY, toX, toY) {
    gml_pragma("forceinline")
    return point_distance(fromX, fromY, toX, toY)
  }

  ///@param {Number} sx1
  ///@param {Number} sy1
  ///@param {Number} sx2
  ///@param {Number} sy2
  ///@param {Number} dx1
  ///@param {Number} dy1
  ///@param {Number} dx2
  ///@param {Number} dy2
  ///@return {Boolean}
  static rectangleOverlaps = function(sx1, sy1, sx2, sy2, dx1, dy1, dx2, dy2) {
    gml_pragma("forceinline")
    return rectangle_in_rectangle(sx1, sy1, sx2, sy2, dx1, dy1, dx2, dy2) > 0
  }

  ///@param {Number} length
  ///@param {Number} angle
  ///@return {Number}
  static fetchCircleX = function(length, angle) {
    gml_pragma("forceinline")
    return lengthdir_x(length, angle)
  }

  ///@param {Number} length
  ///@param {Number} angle
  ///@return {Number}
  static fetchCircleY = function(length, angle) {
    gml_pragma("forceinline")
    return lengthdir_y(length, angle)
  }

  ///@param {Number} source
  ///@param {Number} target
  ///@param {Number} [factor]
  ///@return {Number}
  static transformNumber = function(source, target, factor = 1.0) {
    gml_pragma("forceinline")
    var dir = source < target ? 1 : -1
    var value = source + (dir * factor)
    return dir > 0
      ? clamp(value, source, target)
      : clamp(value, target, source)
  }

  ///@param {Number} number
  ///@return {Number}
  static randomNumber = function(number) {
    gml_pragma("forceinline")
    return random(number)
  }

  ///@param {Number} from
  ///@param {Number} to
  ///@return {Number}
  static randomNumberFromRange = function(from, to) {
    gml_pragma("forceinline")
    return random_range(from, to)
  }

  ///@param {Number} from
  ///@param {Number} to
  ///@return {Number}
  static randomInteger = function(number) {
    gml_pragma("forceinline")
    return irandom(number)
  }

  ///@param {Number} from
  ///@param {Number} to
  ///@return {Number}
  static randomIntegerFromRange = function(from, to) {
    gml_pragma("forceinline")
    return irandom_range(from, to)
  }

  ///@type {Number} a
  ///@type {Number} b
  ///@type {Number} [epsilon]
  static areNumbersEqual = function(a, b, epsilon = 0.0) {
    gml_pragma("forceinline")
    return a >= b - epsilon && a <= b + epsilon
  }

  ///@param {any} value
  ///@return {Boolean}
  static isNaN = function(value) {
    gml_pragma("forceinline")
    return is_nan(value)
  }

  ///@param {Number} x
  ///@param {Number} y
  ///@param {Number} z
  ///@param {Matrix} view
  ///@param {Matrix} projection
  ///@param {Number} width
  ///@param {Number} height
  ///@return {Struct}
  static project3DCoordsOn2D = function(x, y, z, view, projection, width, height) {
    gml_pragma("forceinline")
    var _x = 0
    var _y = 0
    if (projection[15] == 0) {
      /// perspective projection
      var _width = view[2] * x + view[6] * y + view[10] * z + view[14];
      if (_width == 0) {
        return { 
          x: null, 
          y: null
        }
      }

      _x = projection[8] + projection[0] * (view[0] * x + view[4] * y + view[8] * z + view[12]) / _width
      _y = projection[9] + projection[5] * (view[1] * x + view[5] * y + view[9] * z + view[13]) / _width
    } else {
      /// ortho projection
      _x = projection[12] + projection[0] * (view[0] * x + view[4] * y + view[8]  * z + view[12])
      _y = projection[13] + projection[5] * (view[1] * x + view[5] * y + view[9]  * z + view[13])
    }

    return { 
      x: (0.5 + 0.5 * _x) * width,
      y: (0.5 + 0.5 * _y) * height,
    }
  }

  ///@param {Number} x
  ///@param {Number} y
  ///@param {Matrix} view
  ///@param {Matrix} projection
  ///@param {Number} width
  ///@param {Number} width
  static project2DCoordsOn3D = function(x, y, view, projection, width, height) {
    gml_pragma("forceinline")
    var mx = 2 * (x / width - 0.5) / projection[0]
    var my = 2 * (y / height - 0.5) / projection[5]
    var camX = -1 * (view[12] * view[0] + view[13] * view[1] + view[14] * view[2])
    var camY = -1 * (view[12] * view[4] + view[13] * view[5] + view[14] * view[6])
    var camZ = -1 * (view[12] * view[8] + view[13] * view[9] + view[14] * view[10])
    if (projection[15] == 0) {    
      /// perspective projection
      return [
        view[2]  + mx * view[0] + my * view[1],
        view[6]  + mx * view[4] + my * view[5],
        view[10] + mx * view[8] + my * view[9],
        camX,
        camY,
        camZ
      ]
    } else {
      /// ortho projection
      return [ 
        view[2], 
        view[6],
        view[10],
        camX + mx * view[0] + my * view[1],
        camY + mx * view[4] + my * view[5],
        camZ + mx * view[8] + my * view[9]
      ]
    }
  }

  ///@param {Number} base
  ///@param {Number} exponent
  ///@return {Number}
  static pow = function(base, exponent) {
    return power(base, exponent)
  }

  ///@param {Number} value
  ///@return {Number}
  static sqr = function(value) {
    return (sign(value) == 1.0) ? sqrt(value) : 0.0
  }
}
global.__Math = new _Math()
#macro Math global.__Math