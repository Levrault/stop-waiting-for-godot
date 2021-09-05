extends State

var wall_normal: KinematicCollision = null
var stick_to_wall_force = null
var force = .1
var gravity = -11
var min_speed_requiremed := 15

onready var _tween := $Tween


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air", {impulse = true, was_wall_running = true})


func physics_process(delta: float) -> void:
	if not owner.is_on_wall():
		_state_machine.transition_to("Move/Air")
		return
	if owner.is_on_floor():
		_state_machine.transition_to("Move/Idle")
		return

	if (
		abs(_parent.velocity.x) < min_speed_requiremed
		and abs(_parent.velocity.z) < min_speed_requiremed
	):
		_state_machine.transition_to("Move/Air")
		return

	wall_normal = owner.get_slide_collision(0)
	stick_to_wall_force = -wall_normal.normal * force

	_parent.player_direction = Vector3()

	var input_direction: Vector2 = _parent.get_input_direction()
	var cam_xform = owner.camera.get_global_transform()
	_parent.player_direction = -wall_normal.normal * force

	# Basis vectors are already normalized.
	_parent.player_direction += -cam_xform.basis.z * input_direction.y
	_parent.player_direction += cam_xform.basis.x * input_direction.x

	_parent.velocity = _parent.calculate_velocity(
		delta,
		_parent.velocity,
		_parent.player_direction,
		_parent.max_speed.x,
		owner.gravity,
		_parent.acceleration.x,
		_parent.decceleration.x
	)

	_parent.velocity = owner.move_and_slide(
		_parent.velocity, Vector3.UP, true, 4, deg2rad(owner.max_slope_angle)
	)


func enter(msg: Dictionary = {}) -> void:
	owner.gravity = gravity
	var camera_tilt := -15 if owner.raycast_right.is_colliding() else 15

	_tween.interpolate_property(
		owner.rotation_helper,
		"rotation_degrees:z",
		0,
		camera_tilt,
		.25,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	_tween.start()


func exit() -> void:
	owner.gravity = owner.gravity_default
	_tween.interpolate_property(
		owner.rotation_helper,
		"rotation_degrees:z",
		owner.rotation_helper.rotation_degrees.z,
		0,
		.25,
		Tween.TRANS_LINEAR,
		Tween.TRANS_LINEAR
	)
	_tween.start()
