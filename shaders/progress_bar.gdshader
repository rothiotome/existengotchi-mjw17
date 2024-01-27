shader_type canvas_item;

uniform float min_val;
uniform float current_val;
uniform float max_val;

/*
	linear normalization from one range to another
*/
float linear(float old_min, float old_max, float new_min, float new_max, float current) {
	float old_range = (old_max - old_min);
	float new_range = (new_max - new_min);
	float new_val = (((current - old_min) * new_range) / old_range ) + new_min;
	return new_val;
}

void fragment() {
	vec4 color = COLOR;
	
	float normalized = linear(max_val, min_val, 0.0, 1.0, current_val);
	
	/*
	If the fragcoord.x is less than or equal to the calculated point
	between min and max that current_value falls on, mix with our
	fill color
	*/
	if (UV.y <= normalized) {
		if(color.a > 0.4f)
		{
			color.a = 0.1f;
		}
	}
	
	COLOR = color;
}