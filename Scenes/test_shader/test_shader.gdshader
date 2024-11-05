shader_type canvas_item;

//uniform vec4 flash_color : source_color = vec4(1.0);

uniform vec4 flash_color : source_color = vec4(1.0);
uniform float flash_modifier : hint_range(0.0, 1.0) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	//vec4 color = vec4(0.5, 0.5, .75, 0.5);
	
	//COLOR = vec4(UV, 1.0, 1.0);
	
	//COLOR = texture(TEXTURE, UV);
	//COLOR.b = 1.0;
	
	//vec4 color = texture(TEXTURE, UV);
	//color.rgb = mix(color.rgb, flash_color.rgb, 1);
	//COLOR = color;
	
	vec4 color = texture(TEXTURE, UV);
 	color.rgb = mix(color.rgb, flash_color.rgb, flash_modifier);
 	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
