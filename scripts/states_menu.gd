extends HBoxContainer

var states: Dictionary
const min_state_value = 0
const max_state_value = 10

func _ready():
	for n in get_children():
		states[n.name] = 0
