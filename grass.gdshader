shader_type canvas_item;

uniform float a;
uniform float b;
uniform float c;

uniform float world_size;

uniform vec2 wind_vector;

uniform float horizontal_strength;
uniform float vertical_strength;

uniform sampler2D wind_noise_map;

varying float horizontal_gust;

void fragment() {
	COLOR = vec4(0,horizontal_gust,0,1);
}

void vertex() {
	horizontal_gust = texture(
		wind_noise_map,
		(MODEL_MATRIX[3].xy) / b
	).r;
	//VERTEX.x += (UV.y - 1.) * horizontal_strength * horizontal_gust;
	//VERTEX.y *= -(UV.y * vertical_strength * abs((horizontal_gust - 0.5) * 2.));
	
	//horizontal_gust = texture(
		//wind_noise_map,
		//mod(MODEL_MATRIX[3].xy - wind_vector * TIME, world_size)/world_size
	//).r;
	//VERTEX.x = -pow(UV.y,2.) * -horizontal_strength * (horizontal_gust - 0.5) * 2.;
	//VERTEX.y = -(UV.y * vertical_strength * abs((horizontal_gust - 0.5) * 2.));
}

