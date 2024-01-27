extends Control

var following: bool
var dragging_start_position: Vector2

@onready var action_menu = %ActionMenu




func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 0)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true, 0)


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			following = true
			dragging_start_position = get_local_mouse_position()
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
