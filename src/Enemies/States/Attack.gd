extends State

export var animation_speed := 1.4
export var damage := 10

func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	$Timer.connect("timeout", self, "_on_Timeout")
	owner.anim.connect("animation_finished", self, "_on_Animation_finished")
	owner.anim.play("Attack")
	owner.damage_source.connect("body_entered", self, "_on_Body_entered")


func exit() -> void:
	owner.anim.disconnect("animation_finished", self, "_on_Animation_finished")
	owner.damage_source.disconnect("body_entered", self, "_on_Body_entered")
	$Timer.disconnect("timeout", self, "_on_Timeout")


func _on_Animation_finished(anim_name: String) -> void:
	assert(anim_name == "Attack")
	$Timer.start()


func _on_Timeout() -> void:
	_state_machine.transition_to("Follow")


func _on_Body_entered(body: Player) -> void:
	owner.damage_source.get_node("CollisionShape").disabled = true
	body.stats.bullet_hit(damage, owner.damage_source.global_transform)
