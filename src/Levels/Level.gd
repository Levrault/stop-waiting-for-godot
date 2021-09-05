extends Spatial

onready var player := $Player
onready var out_of_bounds := $OutOfBounds
onready var game_over := $CanvasLayer/GameOver


func _ready() -> void:
	Events.connect("game_over", self, "_on_Game_over")
	Game.kills = 0


func _process(delta: float) -> void:
	if player.global_transform.origin.y < out_of_bounds.global_transform.origin.y:
		game_over.show()
		set_process(false)
		get_tree().paused = true


func _on_Game_over() -> void:
	game_over.show()
	get_tree().paused = true
