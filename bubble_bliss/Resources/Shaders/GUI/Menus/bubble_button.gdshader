shader_type canvas_item;


uniform sampler2D tex;

uniform vec2 tex1_scroll_speed = vec2(0.1, 0.1);
uniform vec2 tex2_scroll_speed = vec2(0.1, 0.1);
uniform float circle_radius = 0.5; // Half the UV space
uniform vec2 circle_center = vec2(0.5, 0.5); // Center of the circle

uniform float offset = 0.0; // Each bubble gets a unique value in code

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec2 uv1 = fract(UV + tex1_scroll_speed * (TIME + offset));
	vec2 uv2 = fract(vec2(1.0 - UV.x, 1.0 - UV.y) + tex2_scroll_speed * (TIME + offset));
	
	vec4 color1 = texture(tex, uv1);
	vec4 color2 = texture(tex, uv2);
	
	vec4 combined = (color1 + color2 * 0.5) * 0.66; // Blend the two
	
	// Circular mask
	float dist = distance(UV, circle_center);
	if (dist > circle_radius){
		discard;
	}
	
	COLOR.rgb = COLOR.rgb * combined.rgb;
	COLOR.a = combined.a;
	// COLOR = combined;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
