extends State


func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	owner.vision.connect("body_entered", self, "_on_Player_detected")


func exit() -> void:
	owner.vision.disconnect("body_entered", self, "_on_Player_detected")


func _on_Player_detected(body: Player) -> void:
	owner.target = body
	_state_machine.transition_to("Follow")
	print_debug("Player detected by %s" % owner.get_name())
