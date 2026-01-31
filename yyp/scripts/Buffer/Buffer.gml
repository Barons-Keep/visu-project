///@package com.alkapivo.core.util.Buffer

#macro GMBuffer "GMBuffer"

///@enum
function _BufferType(): Enum() constructor {
    FIXED = buffer_fixed
    GROW = buffer_grow
    WRAP = buffer_wrap
    FAST = buffer_fast
}
global.__BufferType = new _BufferType()
#macro BufferType global.__BufferType

///@interface
function Buffer() constructor {

    ///@mock
    ///@param {any} object
    ///@return {Buffer}
    static add = function(object) {
        return this
    }

    ///@mock
    ///@return {any}
    static get = function() {
        return null
    }

    ///@mock
    ///@return {Buffer}
    static clear = function() {
        return this
    }

    ///@mock
    static free = function() { }
}

#macro TEXT_BUFFER_SIZE 1024
#macro TEXT_BUFFER_ALIGNMENT 1

///@param {Struct} [config]
function TextBuffer(config = {}): Buffer() constructor {

    ///@private
    ///@type {BufferType}
    type = Assert.isEnum(Struct
        .getDefault(config, "type", BufferType.FIXED), BufferType)

    ///@private
    ///@type {Number}
    alignment = Assert.isType(Struct
        .getDefault(config, "alignment", TEXT_BUFFER_ALIGNMENT), Number)

    ///@private
    ///@type {Size}
    size = Assert.isType(Struct
        .getDefault(config, "size", TEXT_BUFFER_SIZE), Number)

    ///@private
    ///@type {GMBuffer}
    asset = Assert.isType(Struct.contains(config, "asset")
        ? config.asset
        : buffer_create(this.size, buffer_grow, this.alignment),
    GMBuffer)

    ///@override
    ///@param {String} text
    ///@return {TextBuffer}
    static add = function(text) {
        buffer_write(this.asset, buffer_text, text)
        return this
    }

    ///@override
    ///@return {String}
    static get = function() {
        buffer_seek(this.asset, buffer_seek_start, 0)
        var text = buffer_read(this.asset, buffer_text)
        return text
    }

    ///@override
    ///@return {TextBuffer}
    static clear = function() {
        buffer_resize(this.asset, 0)
        buffer_resize(this.asset, this.size)
        return this
    }

    ///@override
    static free = function() {
        buffer_delete(this.asset)
    }
}

function _BufferUtil() constructor {

    ///@param {String} path
    ///@throws {FileNotFoundException}
    ///@return {TextBuffer}
    static loadAsTextBuffer = function(path) {
        Assert.fileExists(path)

        return new TextBuffer({ asset: buffer_load(path) })
    }
}
global.__BufferUtil = new _BufferUtil()
#macro BufferUtil global.__BufferUtil


function BufferTest() constructor {
  bufferStep = (4096 * 8)
  bufferAsset = buffer_create(this.bufferStep, buffer_grow, 1)
  currentSize = buffer_get_size(bufferAsset)
  targetSize = (8 * 1024 * 1024)
  growing = true
  timer = 0.0
  update = function() {
    static writeIrandomU8Data = function(iterator, index, context) {
      buffer_poke(context.bufferAsset, context.currentSize + index, buffer_u8, irandom(255))
    }

    if (!this.growing) {
      return this
    }

    timer += DELTA_TIME * FRAME_MS
    var this.newSize = this.currentSize + this.bufferStep
    if (this.newSize >= this.targetSize) {
      buffer_resize(this.bufferAsset, this.targetSize)
      this.currentSize = this.targetSize

      buffer_delete(this.bufferAsset)
      this.bufferAsset = -1
      this.growing = false
      Logger.debug("BufferTest", $"Buffer reached target size and was deleted. {this.timer}")
    } else {
      buffer_resize(this.bufferAsset, this.newSize)
      IntStream.forEach(0, this.newSize - this.currentSize, writeIrandomU8Data, this)
      this.currentSize = this.newSize
    }

    return this
  }
}
