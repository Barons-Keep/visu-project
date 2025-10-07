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

gml_pragma("forceinline")


#macro BktGlitch_deactivate shader_reset


function assert_bktglitch_activated(_uniform) {
	if (shader_current() != shader_bkt_glitch) {
		show_debug_message("ERROR: attempting to set " + _uniform + " while the shader is not active!")
	}
}


///@description Initialises the shader.
function BktGlitch_init() {
	bktglitch_init()
}


///@description Activates the shader and sets required uniforms.
///@param {Number} _width
///@param {Number} _height
///@param {Number} _time
function BktGlitch_activate(_width, _height, _time) {
	bktglitch_activate(_width, _height, _time)
}


///@param {Number} _preset
function BktGlitch_config_preset(_preset) {
	bktglitch_config_preset(_preset)
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
function BktGlitch_config(_lineShift, _lineSpeed, _lineResolution, _lineDrift, 
      _lineVerticalShift, _jumbleness, _jumbleSpeed, _jumbleResolution, _jumbleShift, 
      _noiseLevel, _channelShift, _channelDispersion, _shakiness, _intensity, _rngSeed) {

	bktglitch_config(
    _lineShift, _lineSpeed, _lineResolution, _lineDrift, _lineVerticalShift, 
    _jumbleness, _jumbleSpeed, _jumbleResolution, _jumbleShift, _noiseLevel, _channelShift, 
    _channelDispersion, _shakiness, _intensity, _rngSeed
  )
}


///@description One-liner that sets up tweakable properties of the shader to zero. 
function BktGlitch_config_zero() {
	bktglitch_config_zero()
}


///@description Passes resolution to the shader set to the size of the GUI surface.
function BktGlitch_set_resolution_of_gui() {
	bktglitch_set_resolution_of_gui()
}


///@description Passes resolution to the shader set to the size of the application surface.
function BktGlitch_set_resolution_of_application_surface() {
	bktglitch_set_resolution_of_application_surface()
}


///@description Passes time variable to the shader, neeeds to change for animation.
///@param {Number} _time
function BktGlitch_set_time(_time) {
	bktglitch_set_time(_time)
}


///@description Sets overall intensity of the shader.
///@param {Number} _intensity
function BktGlitch_set_intensity(_intensity) {
	bktglitch_set_intensity(_intensity)
}


///@description Sets base horizontal line offset.
///@param {Number} _intensity
function BktGlitch_set_line_shift(_intensity) {
	bktglitch_set_line_shift(_intensity)
}


///@description Sets waving speed of horizontal lines.
///@param {Number} _intensity
function BktGlitch_set_line_speed(_intensity) {
	bktglitch_set_line_speed(_intensity)
}


///@description Sets resolution of horizontal lines.
///@param {Number} _granularity
function BktGlitch_set_line_resolution(_granularity) {
	bktglitch_set_line_resolution(_granularity)
}


///@description Sets vertical (phase) offset of horizontal lines. 
///@param {Number} _intensity
function BktGlitch_set_line_vertical_shift(_intensity) {
	bktglitch_set_line_vertical_shift(_intensity)
}


///@description Sets level of noise.
///@param {Number} _intensity
function BktGlitch_set_noise_level(_intensity) {
	bktglitch_set_noise_level(_intensity)
}


///@description Sets level of "jumbleness".
///@param {Number} _intensity
function BktGlitch_set_jumbleness(_intensity) {
	bktglitch_set_jumbleness(_intensity)
}


///@description Sets speed of jumble block variation.
///@param {Number} _speed
function BktGlitch_set_jumble_speed(_speed) {
	bktglitch_set_jumble_speed(_speed)
}


///@description Sets granularity of jumble blocks. 
///@param {Number} _granularity
function BktGlitch_set_jumble_resolution(_granularity) {
	bktglitch_set_jumble_resolution(_granularity)
}


///@description Sets level of texture offset in jumble blocks.
///@param {Number} _intensity
function BktGlitch_set_jumble_shift(_intensity) {
	bktglitch_set_jumble_shift(_intensity)
}


///@description Sets level of horizontal RGB channel shift.
///@param {Number} _intensity
function BktGlitch_set_channel_shift(_intensity) {
	bktglitch_set_channel_shift(_intensity)
}


///@description Changes seed used for random calculations - adds variation to all effects.
///@param {Number} _value
function BktGlitch_set_rng_seed(_value) {
	bktglitch_set_rng_seed(_value)
}


///@description Sets shakiness of horizontal lines.
///@param {Number} _intensity
function BktGlitch_set_shakiness(_intensity) {
	bktglitch_set_shakiness(_intensity)
}


///@description Sets level of horizontal noisy RGB channel dispersion.
///@param {Number} _intensity
function BktGlitch_set_channel_dispersion(_intensity) {
	bktglitch_set_channel_dispersion(_intensity)
}


///@description Sets added scanline-y drift to horizontal lines.
///@param {Number} _intensity
function BktGlitch_set_line_drift(_intensity) {
	bktglitch_set_line_drift(_intensity)
}


///@description Sets resolution of the region the shader is used on.
///@param {Number} _width Width in pixels.
///@param {Number} _height Height in pixels.
function BktGlitch_set_resolution(_width, _height) {
	bktglitch_set_resolution(_width, _height)
}
