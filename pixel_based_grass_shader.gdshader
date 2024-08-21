shader_type canvas_item;

uniform float a;
uniform float b;
uniform float c;
uniform float d;

uniform vec2 wind_vector;
uniform float wind_speed;
uniform float noise_map_scale;

uniform float h_strength;
uniform float v_strength;

uniform sampler2D wind_noise_map;
const float noise_map_size = 1024.; // to be set to a resolition of a noise map

varying float gust;

//void fragment() {
	//COLOR = texture(TEXTURE, vec2(UV.x + a * (UV.y - 1.), UV.y));
	//COLOR.r = vec4(vec3(VERTEX.x + (1. - UV.y) * -pow((1. - UV.y),2.) * -h_strength * (gust - 0.5) * 2.), 1);
//}

void vertex() {
	vec2 vertex = vec2(0);
	gust = texture(
		wind_noise_map,
		mod(MODEL_MATRIX[3].xy - wind_vector * wind_speed * TIME, noise_map_size * noise_map_scale)/(noise_map_size* noise_map_scale)
	).r;
	VERTEX.x = VERTEX.x + (1. - UV.y) * -pow((1. - UV.y),2.) * -h_strength * (gust - 0.5) * 2.;
	//VERTEX.y = (1. - UV.y) * v_strength * abs((gust - 0.5) * 2.);
	//VERTEX.y = (VERTEX.y + b) * a - (a * b);
	VERTEX.y = -(UV.y - 1.) * (-4. * v_strength * pow(gust - .5, 2) + 1.) - .5;
	//VERTEX.y *= 
}

