extends State


func unhandled_input(event: InputEvent) -> void:
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if owner.is_on_floor() and _parent.get_input_direction() != Vector2.ZERO:
		if Input.is_action_pressed("sprint"):
			_state_machine.transition_to("Move/Sprint")
		else:
			_state_machine.transition_to("Move/Walk")
		return

	if not owner.is_on_floor():
		_state_machine.transition_to("Move/Air", {coyote_time = true})
		return

	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)


func exit() -> void:
	_parent.exit()
