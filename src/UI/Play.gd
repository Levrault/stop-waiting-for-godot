extends NavigationButton


func _on_Pressed() -> void:
	AsyncLoading.goto_scene("res://src/Levels/Level_01.tscn")
	Game.current_level = "res://src/Levels/Level_01.tscn"
