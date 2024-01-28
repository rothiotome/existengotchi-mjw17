extends TextureRect

var target_value = 0
var current_value = 0

var grow_tween: Tween

func _ready():
	set_shader_value(current_value)

func set_value(value):
	target_value = value
	if grow_tween:
		grow_tween.stop()
		grow_tween.kill()
	grow_tween = create_tween()
	grow_tween.tween_method(set_shader_value, current_value, target_value, 1)
	grow_tween.play()


func set_shader_value(value: float):
	material.set_shader_parameter("current_val", value);
	current_value = value
		
