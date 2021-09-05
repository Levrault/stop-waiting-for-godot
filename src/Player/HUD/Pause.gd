extends Control

func _ready() -> void:
	$CenterContainer/VBoxContainer/Resume.connect("pressed", self, "_on_Pressed")


func _input(event: InputEvent) -> void:
	if not owner.is_handling_input:
		return
	if event.is_action_pressed("ui_cancel"):
		_on_Pressed()


func _on_Pressed() -> void:
	get_tree().paused = not visible
	visible = not visible
	
	if visible:
		$CenterContainer/VBoxContainer/Resume.grab_focus()

	if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
