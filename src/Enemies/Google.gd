extends RigidBody

var has_played_audio := false


func _ready() -> void:
	connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body) -> void:
	if has_played_audio:
		return
	print("_on_Body_entered")
	$AudioStreamPlayer3D.play()
	has_played_audio = true
