///@shader shaderDefault
///@description Fragment shader.
///@uniform {vec2(width, height)} resolution
///@uniform {float} ledSize
///@uniform {float} brightness

	varying vec4 inputColor;
	varying vec2 inputTexture;
	
	uniform vec2 resolution;
	uniform float ledSize;
	uniform float brightness;
	
  float get_alpha_from_pixel(vec3 pixel) {
    return dot(pixel, vec3(0.2126, 0.7152, 0.0722)); // Luma (ITU-R BT.709)
  }

	vec4 pixelize(vec2 uv, float scale) {
		float dx = 1.0 / scale;
		float dy = 1.0 / scale;
		vec2 coord = vec2(
			dx * ceil(uv.x / dx),
			dy * ceil(uv.y / dy));
		return texture2D(gm_BaseTexture, coord);
	}

	void main() {
		vec2 coord = inputTexture * ledSize;
		coord.x *= resolution.x / resolution.y;
		float computedDots = (abs(sin(coord.x * 3.1415)) * 1.2) * (abs(sin(coord.y * 3.1415)) * 1.2);
		
		vec4 outputPixel = pixelize(inputTexture, ledSize) * brightness;
		outputPixel = computedDots < 1.0
      ? vec4(outputPixel.r * 0.5, outputPixel.g * 0.5, outputPixel.b * 0.5, outputPixel.a * 1.0)
      : outputPixel * computedDots;
		//outputPixel.a *=  inputColor.a;
		//gl_FragColor = outputPixel;

    vec4 texture = texture2D(gm_BaseTexture, inputTexture);
    vec3 pixel = outputPixel.rgb;
    float alpha = get_alpha_from_pixel(pixel);
    pixel = mix(pixel, texture.rgb, 1.0 - inputColor.a);
    pixel = mix(pixel, texture.rgb, 1.0 - alpha);
    gl_FragColor = vec4(pixel, texture.a + (alpha * inputColor.a));
	}
	
