extends HBoxContainer

signal states_updated(new_states)

var states: Dictionary
const min_state_value = 0
const max_state_value = 10

func _ready():
	for n in get_children():
		states[n.name] = 0

func update_states(action_effects):
	for n in action_effects:
		states[n] = max(states[n] + action_effects[n], 0)
		var texture_rect = get_node(n) as TextureRect
		texture_rect.material.set_shader_parameter("current_val", states[n])
	states_updated.emit(states)
