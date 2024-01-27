extends AnimatedSprite2D

signal start_performing_action(action_name)

const action_number_of_loops = 5

var is_doing_action = false

func do_action(action_name):
	if is_doing_action: return false
	is_doing_action = true
	animation = action_name
	var loops = 0
	while loops < action_number_of_loops:
		await animation_looped
		loops = loops + 1
	animation = "Idle"
	is_doing_action = false
	return true
