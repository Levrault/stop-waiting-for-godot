extends State

export var max_speed := Vector2(150, 0)

onready var _timer := $Timer


func unhandled_input(event: InputEvent) -> void:
	if not owner.head_bunker.is_colliding():
		if event.is_action_released("crouch"):
			_state_machine.transition_to("Move/Idle")
			return


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)
	if _timer.time_left == 0.0:
		_state_machine.transition_to("Move/Crouch")


func enter(msg: Dictionary = {}) -> void:
	owner.animation_player.play("Position_standing_to_crouch")
	_parent.acceleration = max_speed
	_parent.max_speed = max_speed
	_timer.start()


func exit() -> void:
	_parent.acceleration = _parent.acceleration_default
	_parent.max_speed = _parent.max_speed_default
	_timer.stop()
