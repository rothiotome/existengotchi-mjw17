extends Window

@onready var popup_menu: PopupMenu = %PopupMenu

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		set_flag(FLAG_BORDERLESS, false)
