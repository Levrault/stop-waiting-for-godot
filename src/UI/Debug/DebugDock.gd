extends MarginContainer
"""
Contains UI widgets that display debug info about the game world
"""


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_debug_menu"):
		visible = not visible
