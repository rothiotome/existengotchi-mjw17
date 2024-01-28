extends TextureButton

func _pressed():
	get_tree().reload_current_scene() 
