extends TextureRect

var target_value = 0
var current_value = 0

var tween

func _ready():
	set_shader_value(current_value)

func set_value(value):
	target_value = value
	if tween:
		tween.stop()
		tween.kill()
	tween = create_tween()
	tween.tween_method(set_shader_value, current_value, target_value, 1)
	tween.play()


func set_shader_value(value: float):
	material.set_shader_parameter("current_val", value);
	current_value = value
