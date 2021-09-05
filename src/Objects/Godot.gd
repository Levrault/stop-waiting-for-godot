extends Spatial

export var next_level := ""


func _ready() -> void:
	$Area.connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body) -> void:
	if next_level.empty():
		print_debug("not next level set")
	AsyncLoading.goto_scene(next_level)
	Game.current_level = next_level
