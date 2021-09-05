extends Button


func _ready() -> void:
	connect("pressed", self, "_on_Pressed")
	grab_focus()


func _on_Pressed() -> void:
	get_tree().paused = false
	AsyncLoading.goto_scene(Game.current_level)
