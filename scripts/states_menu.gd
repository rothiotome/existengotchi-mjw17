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
		var state = get_node(n)
		state.set_value(states[n])
	states_updated.emit(states)
