extends State

signal jumped

const TIME_BEFORE_WALL_RUN := .750

export var min_jump_impulse := 10.0
export var jump_impulse := 50.0
export var max_jump_count := 1
export var acceleration := Vector2(6.0, 0)
export var decceleration := Vector2(2.75, 0)

var jump_count := 1
var is_coyote_time := false
var is_controlled := true
var can_wall_run := true

onready var _coyote_time: Timer = $CoyoteTime
onready var _wall_run_timer: Timer = $WallRunTimer


func unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		emit_signal("jumped")
		if _coyote_time.time_left > 0.0:
			_coyote_time.stop()
			jump(jump_impulse)
		elif jump_count < max_jump_count:
			jump(jump_impulse)


func physics_process(delta: float) -> void:
	_parent.physics_process(delta)

	# Landing
	if owner.is_on_floor():
		var target_state := "Move/Idle" if _parent.get_input_direction().x == 0 else "Move/Walk"
		_state_machine.transition_to(target_state, {contact = true})
		return
	elif (
		owner.is_on_wall()
		and can_wall_run
		and Input.is_action_pressed("move_forward")
		and (owner.raycast_right.is_colliding() or owner.raycast_left.is_colliding())
	):
		if _wall_run_timer.time_left == 0.0:
			_state_machine.transition_to("Move/WallRun")


func enter(msg: Dictionary = {}) -> void:
	_parent.enter(msg)
	_parent.acceleration = acceleration
	_parent.decceleration = decceleration
	owner.is_snapped_to_floor = false

	if "coyote_time" in msg:
		_coyote_time.start()
		return

	if "was_wall_running" in msg:
		can_wall_run = false

	if "impulse" in msg:
		jump(jump_impulse)
		_parent.dash_count = 0
		if can_wall_run:
			_wall_run_timer.start()


func exit() -> void:
	owner.is_snapped_to_floor = true
	_coyote_time.stop()
	_wall_run_timer.stop()
	is_controlled = true
	can_wall_run = true
	jump_count = 0
	_parent.acceleration = _parent.acceleration_default
	_parent.decceleration = _parent.decceleration_default
	_parent.exit()


func jump(force: float) -> void:
	_parent.velocity.y = force
	jump_count += 1
