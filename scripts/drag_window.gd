extends Control


var following: bool
var dragging_start_position: Vector2

@onready var action_menu = %ActionMenu
@onready var existentialgotchi = %Existentialgotchi
@onready var state_menu = %StateMenu

var speed_multiplier: = 5


const low_threshold := 4
const high_threshold := 8

var actions: Dictionary = {
	"ListenMusic": {
		"InnerThoughts": -5,
		"Overwhelmed": 2,
	},
	"LookOutWindow":{
		"Overwhelmed": -5,
	},
	"Compliment":{
		"FearDeath": -3,
		"Overwhelmed": 2,
	},
	"PlayWaxHeads":{
		"FearDeath": -7,
		"Overwhelmed": 7,
	}
}

var ticks: Dictionary = {
	"InnerThoughts": 2,
	"Overwhelmed": -1,
	"FearDeath": 1,
}

func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 0)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true, 0)
	game_tick()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			following = true
			dragging_start_position = get_global_mouse_position()
		if event.is_released():
			following = false


func _gui_input(event):
	if following and InputEventMouseMotion:
		DisplayServer.window_set_position(DisplayServer.window_get_position_with_decorations() as Vector2 + get_global_mouse_position() - dragging_start_position)


func _on_select_pressed():
	action_menu.on_button_clicked("select")


func _on_right_pressed():
	action_menu.on_button_clicked("right")


func _on_left_pressed():
	action_menu.on_button_clicked("left")


func _on_action_menu_do_action(action_name):
	if await existentialgotchi.do_action(action_name):
		state_menu.update_states(actions[action_name])

func _on_states_updated(new_states):
	var altered_state = ""
	for state in new_states:
		if new_states[state] > low_threshold:
			if altered_state.is_empty() or new_states[state] > new_states[altered_state]:
				altered_state = state
			elif new_states[state] == new_states[altered_state]:
				randomize()
				if randi() & 0x01:
					altered_state = state
	if altered_state.is_empty():
		existentialgotchi.set_state("Idle", 0)
	elif new_states[altered_state] > high_threshold:
		existentialgotchi.set_state(altered_state, 1)
	else:
		existentialgotchi.set_state(altered_state, 0)

func game_tick():
	randomize()
	var random_tick = ticks.keys().pick_random()
	state_menu.update_states({random_tick: ticks[random_tick]})
	await get_tree().create_timer((20 + randi_range(-20, 20))/speed_multiplier).timeout
	game_tick()

