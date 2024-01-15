shader_type canvas_item;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	if (color.r == 0.0 && color.g == 0.0 && color.b == 0.0) {
		COLOR = vec4(0.8, 0.0, 0.0, 1.0);
	}
	else {
		COLOR = color;
	}
}
