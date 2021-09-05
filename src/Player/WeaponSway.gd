extends Spatial
class_name WeaponSway


var mouse_mov:float
var sway_threshold := 10
var sway_lerp := 10

export var sway_left := Vector3.UP
export var sway_right := Vector3.DOWN
export var sway_normal := Vector3.ZERO


func _input(event) -> void:
	if event is InputEventMouseMotion:
		mouse_mov = -event.relative.x


func _process(delta: float) -> void:
	if  mouse_mov != null:
		if mouse_mov > sway_threshold:
			rotation = rotation.linear_interpolate(sway_left, sway_lerp * delta)
		elif mouse_mov < -sway_threshold:
			rotation = rotation.linear_interpolate(sway_right, sway_lerp * delta)
		else:
			rotation = rotation.linear_interpolate(sway_normal, sway_lerp * delta)
