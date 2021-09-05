extends State


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if owner.is_on_floor():
		if _parent.get_input_direction() == Vector2.ZERO:
			_state_machine.transition_to("Move/Idle")
	else:
		_state_machine.transition_to("Move/Air", {coyote_time = true})
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	owner.hand.anim.play("Hand_walk")
	owner.hand.gun.anim.playback_speed = 1
	_parent.enter(msg)
	_parent.max_speed = _parent.max_speed_default


func exit() -> void:
	owner.hand.anim.play("Hand_idle")
	_parent.exit()
