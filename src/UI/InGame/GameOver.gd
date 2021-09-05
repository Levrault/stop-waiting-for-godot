extends Control


func show() -> void:
	visible = true
	$ColorRect/CenterContainer/VBoxContainer/HBoxContainer/Restart.grab_focus()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
