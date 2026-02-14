///@package io.alkapivo.visu.service.brush

function VEBrushService(): Service() constructor {

  ///@type {Map<String, Array>}
  templates = new Map(String, Array)

  ///@description init templates with BrushType keys
  BrushType.keys().forEach(function(key, index, templates) {
    templates.add(new Array(VEBrushTemplate), BrushType.get(key))
  }, this.templates)

  ///@param {BrushType} type
  ///@return {?Array}
  fetchTemplates = function(type) {
    return this.templates.get(type)
  }

  ///@param {VEBrushTemplate}
  ///@param {?Number} idx
  ///@return {VEBrushService}
  saveTemplate = function(template, idx = null) {
    if (!Core.isType(template, VEBrushTemplate)) {
      Logger.warn("VEBrushService", "saveTemplate(): Template must be type of VEBrushTemplate")
      return this
    }

    var templates = this.templates.get(template.type)
    if (templates == null) {
      Logger.warn("VEBrushService", $"Unable to find template for type '{template.type}'")
      return this
    }

    var index = templates.findIndex(function(template, index, name) {
      return template.name == name
    }, template.name)

    if (index != null) {
      //Logger.info("VEBrushService", $"Template of type '{template.type}' updated: '{template.name}'")
      templates.set(index, template)
    } else {
      //Logger.info("VEBrushService", $"Template of type '{template.type}' added: '{template.name}'")
      if (Core.isType(idx, Number)) {
        templates.add(template, idx)
      } else {
        templates.add(template)
      }
    }

    return this
  }

  ///@param {VEBrushTemplate}
  ///@return {VEBrushService}
  removeTemplate = function(template) {
    if (!Core.isType(template, VEBrushTemplate)) {
      Logger.warn("VEBrushService", "removeTemplate(): Template must be type of VEBrushTemplate")
      return this
    }

    var templates = this.templates.get(template.type)
    if (templates == null) {
      Logger.warn("VEBrushService", $"removeTemplate(): Unable to find template for type '{template.type}'")
      return this
    }

    var index = templates.findIndex(function(template, index, name) {
      return template.name == name
    }, template.name)

    if (index != null) {
      /**///@log.level Logger.info("VEBrushService", $"removeTemplate(): Template of type '{template.type}' removed: '{template.name}'")
      templates.remove(index)
    } else {
      Logger.warn("VEBrushService", $"removeTemplate(): Template of type '{template.type}' wasn't found: '{template.name}'")
    }

    return this
  }

  ///@return {VEBrushTemplate}
  clearTemplates = function() {
    this.templates.forEach(function(array) {
      array.clear()
    })

    return this
  }
}