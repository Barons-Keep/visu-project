///@package io.alkapivo.core.renderer.shader

#macro GMShaderSampler "GMShaderSampler"


///@param {GMShader} _asset
///@param {String} _name
///@param {?Callable} _update
function ShaderSampler(_asset, _name, _update) constructor {

  ///@type {String}
  name = Assert.isType(_name, String, "ShaderSampler name must be type of String")

  ///@type {GMShaderSampler}
  asset = Assert.isType(shader_get_sampler_index(_asset, this.name), GMShaderSampler, $"Cannot parse sampler {name}")

  ///@param {ShaderPipeline} context
  update = Core.isType(_update, Callable) ? _update : function(context) { }
}

