///@package com.janvorisek.bktglitch

//////////////////////////////////
//                              //
//   bktGlitch 1.3.2            //
//    Written by Jan Vorisek    //
//     @blokatt | blokatt.net   //
//      jan@blokatt.net         //
//       31/01/2021             //
//                              //
//     "Here we go again."      //
//                              //
//////////////////////////////////


#macro NOISE_TEXTURE_SIZE 256


enum bktGlitch {
  lineSpeed,
  lineShift,
  lineResolution,
  lineVertShift,
  lineDrift,
  jumbleSpeed,
  jumbleShift,
  jumbleResolution,
  jumbleness,
  dispersion,
  channelShift,
  noiseLevel, 
  shakiness,
  rngSeed,
  intensity,
  time,
  resolution,
  noiseTexture,
}


enum BktGlitchPreset {
  A,
  B,
  C,
  D,
  E
}


///@static
///@type {GMTexture}
global.bktGlitchNoiseSprite = null


function bktglitch_init() {
	if (variable_global_exists("bktGlitchNoiseSprite") && (sprite_exists(global.bktGlitchNoiseSprite))) {
		return 0
	}	

	if (!shader_is_compiled(shader_bkt_glitch)) {
	    show_debug_message("bktGlitch failed to compile, the effect will not be visible.")
	    return 0
	}
	
	global.bktGlitchUniform[bktGlitch.lineSpeed] = shader_get_uniform(shader_bkt_glitch, "lineSpeed")
	global.bktGlitchUniform[bktGlitch.lineDrift] = shader_get_uniform(shader_bkt_glitch, "lineDrift")
	global.bktGlitchUniform[bktGlitch.lineResolution] = shader_get_uniform(shader_bkt_glitch, "lineResolution")
	global.bktGlitchUniform[bktGlitch.lineVertShift] = shader_get_uniform(shader_bkt_glitch, "lineVertShift")
	global.bktGlitchUniform[bktGlitch.lineShift] = shader_get_uniform(shader_bkt_glitch, "lineShift")
	global.bktGlitchUniform[bktGlitch.jumbleness] = shader_get_uniform(shader_bkt_glitch, "jumbleness")
	global.bktGlitchUniform[bktGlitch.jumbleResolution] = shader_get_uniform(shader_bkt_glitch, "jumbleResolution")
	global.bktGlitchUniform[bktGlitch.jumbleShift] = shader_get_uniform(shader_bkt_glitch, "jumbleShift")
	global.bktGlitchUniform[bktGlitch.jumbleSpeed] = shader_get_uniform(shader_bkt_glitch, "jumbleSpeed")
	global.bktGlitchUniform[bktGlitch.dispersion] = shader_get_uniform(shader_bkt_glitch, "dispersion")
	global.bktGlitchUniform[bktGlitch.channelShift] = shader_get_uniform(shader_bkt_glitch, "channelShift")
	global.bktGlitchUniform[bktGlitch.noiseLevel] = shader_get_uniform(shader_bkt_glitch, "noiseLevel")
	global.bktGlitchUniform[bktGlitch.shakiness] = shader_get_uniform(shader_bkt_glitch, "shakiness")
	global.bktGlitchUniform[bktGlitch.rngSeed] = shader_get_uniform(shader_bkt_glitch, "rngSeed")
	global.bktGlitchUniform[bktGlitch.intensity] = shader_get_uniform(shader_bkt_glitch, "intensity")
	global.bktGlitchUniform[bktGlitch.time] = shader_get_uniform(shader_bkt_glitch, "time")
	global.bktGlitchUniform[bktGlitch.resolution] = shader_get_uniform(shader_bkt_glitch, "resolution")
	global.bktGlitchUniform[bktGlitch.noiseTexture] = shader_get_sampler_index(shader_bkt_glitch, "noiseTexture")

	// Generate noise texture with xorshift
	var _seed = int64(max(1, random_get_seed()))
	var _buffer = buffer_create(NOISE_TEXTURE_SIZE * NOISE_TEXTURE_SIZE * 4, buffer_fixed, 1)
	repeat ((NOISE_TEXTURE_SIZE * NOISE_TEXTURE_SIZE) / 2) {
		var _x = int64(_seed)
		_x ^= _x << 13
		_x ^= _x >> 7
		_x ^= _x << 17
		_seed = _x
		buffer_write(_buffer, buffer_u64, _seed)
	}
	var _surface = surface_create(NOISE_TEXTURE_SIZE, NOISE_TEXTURE_SIZE)
	buffer_set_surface(_buffer, _surface, 0)
	
	global.bktGlitchNoiseSprite = sprite_create_from_surface(_surface, 0, 0, NOISE_TEXTURE_SIZE, NOISE_TEXTURE_SIZE, false, false, 0, 0)

	surface_free(_surface)
	buffer_delete(_buffer)
}
	

///@param {Number} _width
///@param {Number} _height
///@param {Number} _time
function bktglitch_activate(_width, _height, _time) {
	bktglitch_init()
	shader_set(shader_bkt_glitch)
	gpu_set_tex_repeat_ext(global.bktGlitchUniform[bktGlitch.noiseTexture], true)
	gpu_set_tex_filter_ext(global.bktGlitchUniform[bktGlitch.noiseTexture], false)
	texture_set_stage(global.bktGlitchUniform[bktGlitch.noiseTexture], sprite_get_texture(global.bktGlitchNoiseSprite, 0))
	if ((_width == undefined) || (_height == undefined)) {
		bktglitch_set_resolution_of_application_surface()
	} else {
	  bktglitch_set_resolution(_width, _height)
	}

	// Passes global timer to shader, setting this to zero results in everything being static.
	bktglitch_set_time(_time == null ? current_time * 0.05 : _time)
}


///@param {Number} _preset
function bktglitch_config_preset(_preset) {
	/*
  Sets a start preset for the shader, in case you don't want to set all uniforms
  manually. Defaults to all-zeroes. 

  If you set up a nice configuration in the demo, you can press C to have its code
  generated and copied into the clipboard.

  Presets: 
    BktGlitchPreset.A
    BktGlitchPreset.B
    BktGlitchPreset.C
    BktGlitchPreset.D
    BktGlitchPreset.E 
	*/

	switch (_preset) {
    case BktGlitchPreset.A:       
      bktglitch_set_intensity(1.000000)
      bktglitch_set_line_shift(0.004000)
      bktglitch_set_line_speed(0.010000)
      bktglitch_set_line_resolution(1.000000)
      bktglitch_set_line_drift(0.100000)
      bktglitch_set_line_vertical_shift(0.000000)
      bktglitch_set_noise_level(0.500000)
      bktglitch_set_jumbleness(0.200000)
      bktglitch_set_jumble_speed(0.166667)
      bktglitch_set_jumble_resolution(.23333333)
      bktglitch_set_jumble_shift(0.160000)
      bktglitch_set_channel_shift(0.004000)
      bktglitch_set_channel_dispersion(0.002500)
      bktglitch_set_shakiness(0.500000)
      bktglitch_set_rng_seed(0.000000)
      break
    case BktGlitchPreset.B:       
      bktglitch_set_intensity(1.000000)
      bktglitch_set_line_shift(0.011000)
      bktglitch_set_line_speed(0.166667)
      bktglitch_set_line_resolution(0.420000)
      bktglitch_set_line_drift(0.249702)
      bktglitch_set_line_vertical_shift(0.713333)
      bktglitch_set_noise_level(0.940000)
      bktglitch_set_jumbleness(0.273333)
      bktglitch_set_jumble_speed(0.000000)
      bktglitch_set_jumble_resolution(.07333333)
      bktglitch_set_jumble_shift(0.626667)
      bktglitch_set_channel_shift(0.003333)
      bktglitch_set_channel_dispersion(0.000000)
      bktglitch_set_shakiness(1.733333)
      bktglitch_set_rng_seed(30.000000)
      break
    case BktGlitchPreset.C:   
      bktglitch_set_intensity(1.000000)
      bktglitch_set_line_shift(0.001667)
      bktglitch_set_line_speed(0.020397)
      bktglitch_set_line_resolution(1.145380)
      bktglitch_set_line_drift(0.212783)
      bktglitch_set_line_vertical_shift(0.125946)
      bktglitch_set_noise_level(1.000000)
      bktglitch_set_jumbleness(0.660000)
      bktglitch_set_jumble_speed(0.000000)
      bktglitch_set_jumble_resolution(.20000000)
      bktglitch_set_jumble_shift(0.673333)
      bktglitch_set_channel_shift(0.012000)
      bktglitch_set_channel_dispersion(0.063333)
      bktglitch_set_shakiness(3.933333)
      bktglitch_set_rng_seed(48.294403)
      break
    case BktGlitchPreset.D:   
      bktglitch_set_intensity(1.000000)
      bktglitch_set_line_shift(0.001333)
      bktglitch_set_line_speed(0.023333)
      bktglitch_set_line_resolution(2.160000)
      bktglitch_set_line_drift(0.573333)
      bktglitch_set_line_vertical_shift(0.326667)
      bktglitch_set_noise_level(1.000000)
      bktglitch_set_jumbleness(0.660000)
      bktglitch_set_jumble_speed(0.000000)
      bktglitch_set_jumble_resolution(.24000000)
      bktglitch_set_jumble_shift(0.040000)
      bktglitch_set_channel_shift(0.000667)
      bktglitch_set_channel_dispersion(0.003333)
      bktglitch_set_shakiness(2.466667)
      bktglitch_set_rng_seed(0.000000)
      break
    case BktGlitchPreset.E:   
      bktglitch_set_intensity(1.000000)
      bktglitch_set_line_shift(0.001333)
      bktglitch_set_line_speed(0.250000)
      bktglitch_set_line_resolution(1.660000)
      bktglitch_set_line_drift(0.493333)
      bktglitch_set_line_vertical_shift(0.740000)
      bktglitch_set_noise_level(0.353333)
      bktglitch_set_jumbleness(0.300000)
      bktglitch_set_jumble_speed(25.000000)
      bktglitch_set_jumble_resolution(.10000000)
      bktglitch_set_jumble_shift(0.086667)
      bktglitch_set_channel_shift(0.034667)
      bktglitch_set_channel_dispersion(0.020000)
      bktglitch_set_shakiness(2.266667)
      bktglitch_set_rng_seed(48.666667)
      break 
    default:
      bktglitch_config_zero()
	}
}


///@param {Number} _lineShift
///@param {Number} _lineSpeed
///@param {Number} _lineResolution
///@param {Number} _lineDrift
///@param {Number} _lineVerticalShift
///@param {Number} _jumbleness
///@param {Number} _jumbleSpeed
///@param {Number} _jumbleResolution
///@param {Number} _jumbleShift
///@param {Number} _noiseLevel
///@param {Number} _channelShift
///@param {Number} _channelDispersion
///@param {Number} _shakiness
///@param {Number} _intensity
///@param {Number} _rngSeed
function bktglitch_config(_lineShift, _lineSpeed, _lineResolution, _lineDrift, 
    _lineVerticalShift, _jumbleness, _jumbleSpeed, _jumbleResolution, _jumbleShift, 
    _noiseLevel, _channelShift, _channelDispersion, _shakiness, _intensity, _rngSeed) {
	bktglitch_set_line_shift(_lineShift)
	bktglitch_set_line_speed(_lineSpeed)
	bktglitch_set_line_resolution(_lineResolution)
	bktglitch_set_line_drift(_lineDrift)
	bktglitch_set_line_vertical_shift(_lineVerticalShift)
	bktglitch_set_jumbleness(_jumbleness)
	bktglitch_set_jumble_speed(_jumbleSpeed)
	bktglitch_set_jumble_resolution(_jumbleResolution)
	bktglitch_set_jumble_shift(_jumbleShift)
	bktglitch_set_noise_level(_noiseLevel)
	bktglitch_set_channel_shift(_channelShift)
	bktglitch_set_channel_dispersion(_channelDispersion)
	bktglitch_set_shakiness(_shakiness)
	bktglitch_set_intensity(_intensity)
	bktglitch_set_rng_seed(_rngSeed)
}


function bktglitch_config_zero() {
	bktglitch_set_line_shift(0)
	bktglitch_set_line_speed(0)
	bktglitch_set_line_resolution(0)
	bktglitch_set_line_drift(0)
	bktglitch_set_line_vertical_shift(0)
	bktglitch_set_jumbleness(0)
	bktglitch_set_jumble_speed(0)
	bktglitch_set_jumble_resolution(0)
	bktglitch_set_jumble_shift(0)
	bktglitch_set_noise_level(0)
	bktglitch_set_channel_shift(0)
	bktglitch_set_channel_dispersion(0)
	bktglitch_set_shakiness(0)
	bktglitch_set_intensity(0)
	bktglitch_set_rng_seed(0)
}


function bktglitch_set_resolution_of_gui() {
	assert_bktglitch_activated("bktGlitch.resolution")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.resolution], display_get_gui_width(), display_get_gui_height())
}


function bktglitch_set_resolution_of_application_surface() {
	// If you provide bktglitch_activate with no arguments, this function is run automatically.   
	if (surface_exists(application_surface)) {
		assert_bktglitch_activated("bktGlitch.resolution")
	  shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.resolution], surface_get_width(application_surface), surface_get_height(application_surface))
	}
}


///@description Passes time variable to the shader, neeeds to change for animation.
///@param {Number} _time
function bktglitch_set_time(_time) {
	/*
	Designed for a variable that increases by one every frame at 60 FPS.
	Done automatically by bktglitch_set_time.
	*/
	assert_bktglitch_activated("bktGlitch.time")

	// Wraps around after a day with the default behaviour, which seems to be good enough not to cause precision issues.
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.time], _time % 5184000.0)
}


///@description Sets overall intensity of the shader.
///@param {Number} _intensity
function bktglitch_set_intensity(_intensity) {
	assert_bktglitch_activated("bktGlitch.intensity")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.intensity], abs(_intensity))
}


///@description Sets base horizontal line offset.
///@param {Number} _intensity
function bktglitch_set_line_shift(_intensity) {
	assert_bktglitch_activated("bktGlitch.lineShift")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.lineShift], abs(_intensity))
}


///@description Sets waving speed of horizontal lines.
///@param {Number} _intensity
function bktglitch_set_line_speed(_intensity) {
	assert_bktglitch_activated("bktGlitch.lineSpeed")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.lineSpeed], abs(_intensity))
}


///@description Sets resolution of horizontal lines.
///@param {Number} _granularity
function bktglitch_set_line_resolution(_granularity) {
	assert_bktglitch_activated("bktGlitch.lineResolution")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.lineResolution], max(0.000001, abs(_granularity)))
}


///@description Sets vertical (phase) offset of horizontal lines. 
///@param {Number} _intensity
function bktglitch_set_line_vertical_shift(_intensity) {
	assert_bktglitch_activated("bktGlitch.lineVertShift")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.lineVertShift], abs(_intensity))
}


///@description Sets level of noise.
///@param {Number} _intensity
function bktglitch_set_noise_level(_intensity) {
	assert_bktglitch_activated("bktGlitch.noiseLevel")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.noiseLevel], abs(_intensity))
}


///@description Sets level of "jumbleness".
///@param {Number} _intensity
function bktglitch_set_jumbleness(_intensity) {
	assert_bktglitch_activated("bktGlitch.jumbleness")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.jumbleness], abs(_intensity))
}


///@description Sets speed of jumble block variation.
///@param {Number} _speed
function bktglitch_set_jumble_speed(_speed) {
	/*
  Sets speed of jumble variation.
  Range based around 0-1, no upper limit.
  Higher = faster block variation
  0 = no change over time
	*/
	assert_bktglitch_activated("bktGlitch.jumbleSpeed")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.jumbleSpeed], abs(_speed))
}


///@description Sets granularity of jumble blocks. 
///@param {Number} _granularity
function bktglitch_set_jumble_resolution(_granularity) {
	assert_bktglitch_activated("bktGlitch.jumbleResolution")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.jumbleResolution], abs(_granularity))
}


///@description Sets level of texture offset in jumble blocks.
///@param {Number} _intensity
function bktglitch_set_jumble_shift(_intensity) {
	assert_bktglitch_activated("bktGlitch.jumbleShift")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.jumbleShift], abs(_intensity))
}


///@description Sets level of horizontal RGB channel shift.
///@param {Number} _intensity
function bktglitch_set_channel_shift(_intensity) {
	assert_bktglitch_activated("bktGlitch.channelShift")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.channelShift], abs(_intensity))
}


///@description Changes seed used for random calculations - adds variation to all effects.
///@param {Number} _value
function bktglitch_set_rng_seed(_value) {
	assert_bktglitch_activated("bktGlitch.rngSeed")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.rngSeed], max(0.000001, abs(_value)))
}


///@description Sets shakiness of horizontal lines.
///@param {Number} _intensity
function bktglitch_set_shakiness(_intensity) {
	assert_bktglitch_activated("bktGlitch.shakiness")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.shakiness], abs(_intensity))
}


///@description Sets level of horizontal noisy RGB channel dispersion.
///@param {Number} _intensity
function bktglitch_set_channel_dispersion(_intensity) {
	assert_bktglitch_activated("bktGlitch.dispersion")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.dispersion], abs(_intensity))
}


///@description Sets added scanline-y drift to horizontal lines.
///@param {Number} _intensity
function bktglitch_set_line_drift(_intensity) {
	assert_bktglitch_activated("bktGlitch.lineDrift")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.lineDrift], abs(_intensity))
}


///@description Sets resolution of the region the shader is used on.
///@param {Number} _width Width in pixels.
///@param {Number} _height Height in pixels.
function bktglitch_set_resolution(_width, _height) {
	/*
	If you're using the shader as a post-processing effect on the entire screen, you'll probably
	want to use bktglitch_set_resolution_of_application_surface.
	*/
	assert_bktglitch_activated("bktGlitch.resolution")
	shader_set_uniform_f(global.bktGlitchUniform[bktGlitch.resolution], abs(_width), abs(_height))
}

#macro bktglitch_deactivate shader_reset