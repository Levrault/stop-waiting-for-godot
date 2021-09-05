extends State

export var max_speed := Vector2(20, 0)


func unhandled_input(event: InputEvent) -> void:
	if not owner.head_bunker.is_colliding():
		if event.is_action_released("crouch"):
			_state_machine.transition_to("Move/Idle")
			return


func physics_process(delta: float) -> void:
	if not owner.is_on_floor():
		_state_machine.transition_to("Move/Air", {coyote_time = true})
		return
	if not Input.is_action_pressed("crouch") and not owner.head_bunker.is_colliding():
		_state_machine.transition_to("Move/Idle")
		return
	_parent.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	_parent.max_speed = max_speed
	owner.animation_player.play("Position_standing_to_crouch")


func exit() -> void:
	_parent.max_speed = _parent.max_speed_default
	owner.animation_player.play("Position_crouch_to_standing")
