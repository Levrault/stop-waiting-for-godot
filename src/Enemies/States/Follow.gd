extends State

export var speed := 40.0
export var look_at_speed := 12.0
var path := []
var path_index := 0


func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	smooth_look_at(delta)
	if path_index < path.size():
		var direction = (path[path_index] - owner.global_transform.origin)
		if direction.length() < 1:
			path_index += 1
			return
		owner.move_and_slide(direction.normalized() * speed, Vector3.UP)


func enter(msg: Dictionary = {}) -> void:
	if "bullet_hit" in msg:
		owner.target = Game.player_instance
		print("was hit")
	$Timer.connect("timeout", self, "_on_Timeout")
	$Timer.start()

	if not owner.has_been_alerted:
		owner.anim.play("Alert")
		owner.has_been_alerted = true


func exit() -> void:
	$Timer.disconnect("timeout", self, "_on_Timeout")


func move_to(target_pos) -> void:
	path = owner.navigation.get_simple_path(owner.global_transform.origin, target_pos)
	path_index = 0


func smooth_look_at(delta: float) -> void:
	var new_transform = owner.rotation_helper.global_transform.looking_at(owner.target.transform.origin, Vector3.UP)
	var scale_fix =owner.rotation_helper.scale
	owner.rotation_helper.global_transform  = owner.rotation_helper.global_transform.interpolate_with(new_transform, look_at_speed * delta)
	owner.rotation_helper.rotation_degrees.x = 0
	owner.rotation_helper.scale = scale_fix

func _on_Timeout() -> void:
	move_to(owner.target.global_transform.origin)
