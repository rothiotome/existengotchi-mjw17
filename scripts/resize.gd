extends TextureButton

func _pressed():
	var current_window = get_window() as Window
	current_window.borderless = !current_window.borderless
	
