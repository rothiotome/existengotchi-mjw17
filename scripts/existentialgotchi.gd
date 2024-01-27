extends AnimatedSprite2D

signal start_performing_action(action_name)

const action_number_of_loops = 5

var is_doing_action = false

var current_idle_animation = "Idle"


func do_action(action_name):
	if is_doing_action: return false
	is_doing_action = true
	animation = action_name
	var loops = 0
	while loops < action_number_of_loops:
		await animation_looped
		loops = loops + 1
	is_doing_action = false
	animation = current_idle_animation
	return true

func set_state(state_name, state_level):
	if state_level > 0:
		current_idle_animation = state_name+str(2)
	else:
		current_idle_animation = state_name
	
	if !is_doing_action:
		animation = current_idle_animation
