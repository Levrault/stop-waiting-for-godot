extends State

export var max_speed_default := Vector2(70.0, 100.0)
export var acceleration_default := Vector2(6.0, 0)
export var decceleration_default := Vector2(9.0, 0)
export var max_speed_fall := 900.00
export var max_dash_count := 1

var acceleration := acceleration_default
var decceleration := decceleration_default
var max_speed := max_speed_default
var dash_count := 0
var velocity := Vector3.ZERO
var player_direction = Vector3()

static func get_input_direction() -> Vector2:
	return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), Input.get_action_strength("move_forward") - Input.get_action_strength("move_backward")).normalized()

static func calculate_velocity(
	delta: float,
	old_velocity: Vector3,
	direction: Vector3,
	max_speed: float,
	gravity: int,
	acceleration: float,
	decceleration: float
) -> Vector3:
	var velocity = old_velocity
	var hvel = Vector3.ZERO
	velocity.y += delta * gravity
	hvel = velocity

	direction.y = 0
	direction = direction.normalized()

	var target = direction
	target *= max_speed

	var computed_acceleration: float = acceleration if direction.dot(hvel) > 0 else decceleration
	hvel = hvel.linear_interpolate(target, computed_acceleration * delta)
	velocity.x = hvel.x
	velocity.z = hvel.z

	return velocity


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and owner.is_on_floor():
		_state_machine.transition_to("Move/Air", {impulse = true})
		return
	if event.is_action_pressed("sprint") and owner.is_on_floor():
		_state_machine.transition_to("Move/Sprint")
		return
	if event.is_action_pressed("crouch"):
		_state_machine.transition_to("Move/Crouch")
		return


func physics_process(delta: float) -> void:
	player_direction = Vector3()
	var input_direction := get_input_direction()
	var cam_xform = owner.camera.get_global_transform()

	# Basis vectors are already normalized.
	player_direction += -cam_xform.basis.z * input_direction.y
	player_direction += cam_xform.basis.x * input_direction.x

	velocity = calculate_velocity(
		delta,
		velocity,
		player_direction,
		max_speed.x,
		owner.gravity,
		acceleration.x,
		decceleration.x
	)

	if owner.is_snapped_to_floor:
		velocity = owner.move_and_slide_with_snap(
			velocity, Vector3.DOWN, Vector3.UP, true, 4, deg2rad(owner.max_slope_angle)
		)
	else:
		velocity = owner.move_and_slide(
			velocity, Vector3.UP, true, 4, deg2rad(owner.max_slope_angle)
		)


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return
