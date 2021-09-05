extends State

export var max_speed := Vector2(100, 0)


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("sprint"):
		_state_machine.transition_to("Move/Walk")
		return
	if event.is_action_pressed("crouch"):
		_state_machine.transition_to("Move/Slide")
		return
	_parent.unhandled_input(event)


func physics_process(delta: float) -> void:
	if not owner.is_on_floor():
		_state_machine.transition_to("Move/Air", {coyote_time = true})
		return
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)
	_parent.max_speed = max_speed


func exit() -> void:
	_parent.exit()
	_parent.max_speed = _parent.max_speed_default
