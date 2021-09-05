extends Node


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event: InputEvent):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		owner.rotation_helper.rotate_x(deg2rad(event.relative.y * owner.MOUSE_SENSITIVITY))
		owner.rotate_y(deg2rad(event.relative.x * owner.MOUSE_SENSITIVITY * -1))

		var camera_rot = owner.rotation_helper.rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		owner.rotation_helper.rotation_degrees = camera_rot
