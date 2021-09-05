extends Control


func _ready() -> void:
	Events.emit_signal("input_desactivated")
	get_tree().paused = true
	$AnimationPlayer.playback_speed = 2


func countdown_over() -> void:
	get_tree().paused = false
	queue_free()
	Events.emit_signal("input_activated")

