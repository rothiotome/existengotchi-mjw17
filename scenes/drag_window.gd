extends Control
func _ready():
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_TRANSPARENT, true, 0)
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true, 0)
