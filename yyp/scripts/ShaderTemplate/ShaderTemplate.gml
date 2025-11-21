///@package io.alkapivo.core.renderer.shader

///@param {String} _name
///@param {Struct} json
function ShaderTemplate(_name, json) constructor {

  ///@type {?String}
  name = Assert.isType(_name, String, "ShaderTemplate::name must be type of String")

  ///@type {?String}
  inherit = Struct.contains(json, "inherit")
    ? Assert.isType(json.inherit, String, "ShaderTemplate::inherit must be type of String")
    : null

  ///@type {String}
  shader = Assert.isType(json.shader, String, "ShaderTemplate::shader must be type of String")
  Assert.isType(ShaderUtil.fetch(this.shader), Shader, $"Shader {this.shader} must exists")

  ///@type {?Struct}
  properties = Struct.contains(json, "properties")
    ? Assert.isType(json.properties, Struct, "ShaderTemplate::properties must be type of Struct")
    : null

  ///@return {Struct}
  serialize = function() {
    var json = {
      name: this.name,
      shader: this.shader,
      inherit: this.inherit,
      properties: this.properties,
    }

    return json
  }
}
