shader_type canvas_item;

uniform int grass_size;

void vertex() {
	VERTEX *= float(grass_size);
}

void fragment() {
	// Called for every pixel the material is visible on.
}
