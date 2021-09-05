extends Button

func _ready():
	connect("pressed", self, "_on_Pressed")
	grab_focus()
	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Pressed() -> void:
	get_tree().paused = false
	AsyncLoading.goto_scene("res://src/UI/MainMenu.tscn")
