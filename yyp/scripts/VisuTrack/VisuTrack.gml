///@package io.alkapivo.visu

///@todo missing absolute path validation
///@param {Struct} json
function VisuTrack(_path, json) constructor {

  ///@type {String}
  path = Assert.isType(FileUtil.getDirectoryFromPath(_path), String)

  var _editor = Beans.get(Visu.modules().editor.controller)

  ///@type {Number}
  bpm = Assert.isType(Struct.getDefault(json, "bpm", _editor == null ? 120 : _editor.store.getValue("bpm")), Number)

  ///@type {Number}
  bpmCount = Assert.isType(Struct.getDefault(json, "bpm-count", _editor == null ? 0 : _editor.store.getValue("bpm-count")), Number)

  ///@type {Number}
  bpmSub = Assert.isType(Struct.getDefault(json, "bpm-sub", _editor == null ? 2 : _editor.store.getValue("bpm-sub")), Number)

  ///@type {Number}
  bpmShift = Assert.isType(Struct.getDefault(json, "bpm-shift", _editor == null ? 0 : _editor.store.getValue("bpm-shift")), Number)

  ///@type {String}
  sound = Assert.isType(Struct.get(json, "sound"), String)

  ///@type {String}
  track = Assert.isType(Struct.get(json, "track"), String)
  
  ///@type {String}
  bullet = Assert.isType(Struct.get(json, "bullet"), String)

  ///@type {String}
  coin = Assert.isType(Struct.get(json, "coin"), String)
  
  ///@type {String}
  subtitle = Assert.isType(Struct.get(json, "subtitle"), String)
  
  ///@type {String}
  particle = Assert.isType(Struct.get(json, "particle"), String)
  
  ///@type {String}
  shader = Assert.isType(Struct.get(json, "shader"), String)
  
  ///@type {String}
  shroom = Assert.isType(Struct.get(json, "shroom"), String)
  
  ///@type {String}
  texture = Assert.isType(Struct.get(json, "texture"), String)

  ///@type {?String}
  video = Core.isType(Struct.get(json, "video"), String)
    ? json.video
    : null

  ///@type {Array<String>}
  editor = new Array(String, json.editor)

  ///@param {String} manifestPath
  saveProject = function(manifestPath) {
    var controller = Beans.get(BeanVisuController)
    var fileService = Beans.get(BeanFileService)
    var previousPath = this.path
    var path = Assert.isType(FileUtil.getDirectoryFromPath(manifestPath), String)
    var manifest = {
      "model": "io.alkapivo.visu.controller.VisuTrack",
      "version": "1",
      "data": {  
        "bpm": this.bpm,
        "bpm-count": this.bpmCount,
        "bpm-sub": this.bpmSub,
        "bpm-shift": this.bpmShift,
        "track": this.track,
        "bullet": this.bullet,
        "coin": this.coin,
        "subtitle": this.subtitle,
        "particle": this.particle,
        "shader": this.shader,
        "shroom": this.shroom,
        "sound": this.sound,
        "texture": this.texture,
        "video": this.video,
        "editor": Beans.get(BeanVisuController).brushService.templates
          .keys()
          .map(function(filename) {
            return $"brush/{filename}.json"
          })
          .getContainer(),
      }
    }

    FileUtil.createDirectory($"{path}brush")
    FileUtil.createDirectory($"{path}template")
    FileUtil.createDirectory($"{path}texture")

    #region Serialize
    var track = controller.trackService.track.serialize()

    var sound = {
      "model": "Collection<io.alkapivo.core.service.sound.SoundIntent>",
      "version": "1",
      "data": {}
    }
    Beans.get(BeanSoundService).intents
      .forEach(function(intent, name, data) {
        Struct.set(data, name, intent.serialize())
      }, sound.data)

    var bullet = {
      "model": "Collection<io.alkapivo.visu.service.bullet.BulletTemplate>",
      "version": "1",
      "data": {},
    }
    controller.bulletService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, bullet.data)

    var coin = {
      "model": "Collection<io.alkapivo.visu.service.coin.CoinTemplate>",
      "version": "1",
      "data": {},
    }
    controller.coinService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, coin.data)

    var subtitle = {
      "model": "Collection<io.alkapivo.visu.service.subtitle.SubtitleTemplate>",
      "version": "1",
      "data": {},
    }
    controller.subtitleService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, subtitle.data)

    var particle = {
      "model": "Collection<io.alkapivo.core.service.particle.ParticleTemplate>",
      "version": "1",
      "data": {},
    }
    controller.particleService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, particle.data)
    
    var shader = {
      "model": "Collection<io.alkapivo.core.service.shader.ShaderTemplate>",
      "version": "1",
      "data": {},
    }
    controller.shaderPipeline.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, shader.data)

    var shroom = {
      "model": "Collection<io.alkapivo.visu.service.shroom.ShroomTemplate>",
      "version": "1",
      "data": {},
    }
    controller.shroomService.templates
      .forEach(function(template, name, data) {
        Struct.set(data, template.name, template.serialize())
      }, shroom.data)

    var textureAcc = {
      texture: {
        "model": "Collection<io.alkapivo.core.service.texture.TextureIntent>",
        "version": "1",
        "data": {},
      },
      files: new Map(String, Struct),
    }
    Beans.get(BeanTextureService).templates
      .forEach(function(template, name, acc) {
        var path = template.file
        var json = template.serialize()
        json.file = $"texture/{json.file}"
        acc.files.set(path, json)
        Struct.set(acc.texture.data, template.name, json)
      }, textureAcc)

    var editor = {}
    Beans.get(BeanVisuController).brushService.templates
      .forEach(function(templates, type, editor) {
        Struct.set(editor, type, {
          "model": "Collection<io.alkapivo.visu.editor.api.VEBrushTemplate>",
          "version": "1",
          "data": templates.getContainer(),
        })
      }, editor)

    var video = null
    var sourceVideo = null
    if (Core.isType(this.video, String) 
      && FileUtil.fileExists(this.video)) {
      video = FileUtil.getFilenameFromPath(this.Video)
      sourceVideo = Assert.fileExists(FileUtil.get($"{path}{video}"))
    } 
    #endregion

    #region Save
    FileUtil.writeFileSync(new File({
        path: manifestPath,
        data: String.replaceAll(JSON.stringify(manifest, { pretty: true }), "\\", ""),
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.track}",
        data: track,
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.bullet}",
        data: JSON.stringify(bullet, { pretty: true }),
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.coin}",
        data: JSON.stringify(coin, { pretty: true }),
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.subtitle}",
        data: JSON.stringify(subtitle, { pretty: true }),
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.particle}",
        data: JSON.stringify(particle, { pretty: true }),
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.shader}",
        data: JSON.stringify(shader, { pretty: true }),
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.shroom}",
        data: JSON.stringify(shroom, { pretty: true }),
    }))

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.texture}",
        data: String.replaceAll(JSON.stringify(textureAcc.texture, { pretty: true }), "\\", ""),
    }))
    textureAcc.files.forEach(function(template, sourcePath, targetDirectory) {
      FileUtil.copyFile(sourcePath, $"{targetDirectory}{template.file}")
    }, path)

    FileUtil.writeFileSync(new File({
        path: $"{path}{this.sound}",
        data: JSON.stringify(sound, { pretty: true }),
    }))
    Struct.forEach(sound.data, function(intent, name, acc) {
      FileUtil.copyFile($"{acc.source}{intent.file}", $"{acc.target}{intent.file}")
    }, {
      source: previousPath,
      target: path,
    })

    if (Optional.is(this.video)) {
      FileUtil.copyFile(sourceVideo, $"{path}{video}")
    }

    Struct.forEach(editor, function(data, filename, acc) {
      FileUtil.writeFileSync(new File({
          path: $"{acc.path}brush/{filename}.json",
          data: JSON.stringify(data, { pretty: true }),
      }))
    }, { path: path, fileService: fileService })
    #endregion
  }
}