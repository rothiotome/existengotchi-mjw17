extends HBoxContainer

signal do_action(action_name)

var actions: PackedStringArray

var current_highlighted_action: String
var default_highlighted_action: String = "LookOutWindow"
const highlighted_alfa = 1
const faded_alfa = 0.5

func _ready():
	for n in get_children():
		actions.append(n.name)
	highlight_action(default_highlighted_action)


func highlight_action(action_name):
	if current_highlighted_action:
		remove_highlight_action(current_highlighted_action)
	current_highlighted_action = action_name
	var action_texture: TextureRect = get_texture_from_name(action_name)
	action_texture.self_modulate.a = highlighted_alfa


func remove_highlight_action(action_name):
	if actions.has(action_name):
		var action_texture: TextureRect = get_texture_from_name(action_name)
		action_texture.self_modulate.a = faded_alfa


func on_button_clicked(action_type):
	match action_type:
		"right":
			var action_index = actions.find(current_highlighted_action)
			if action_index == actions.size() - 1:
				return
			highlight_action(actions[action_index + 1])
			
		"left":
			var action_index = actions.find(current_highlighted_action)
			if action_index == 0:
				return
			highlight_action(actions[action_index - 1])
		"select":
			do_action.emit(current_highlighted_action)


func get_texture_from_name(action_name):
	if actions.has(action_name):
		return get_child(actions.find(action_name)) as TextureRect
