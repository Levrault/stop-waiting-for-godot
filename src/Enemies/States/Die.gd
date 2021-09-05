extends State


func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	owner.anim.stop()
	owner.body.connect("body_disolved", self, "_on_Body_Disolved")
	owner.is_death = true
	owner.get_node("CollisionShape").disabled = true
	owner.attack_zone.get_node("CollisionShape").disabled = true
	owner.vision.queue_free()
	owner.attack_zone.queue_free()
	owner.fist.queue_free()
	owner.alert.queue_free()
	owner.get_node("AudioStreamPlayer3D_alert").stop()
	owner.get_node("AudioStreamPlayer3D_alert").queue_free()
	owner.get_node("AudioStreamPlayer3D_woosh").stop()
	owner.get_node("AudioStreamPlayer3D_woosh").queue_free()
	owner.body.dissolve()
	Game.kills += 1


func exit() -> void:
	return


func _on_Body_Disolved() -> void:
	owner.google.mode = owner.google.MODE_RIGID
	owner.google.get_node("CollisionShape").disabled = false
