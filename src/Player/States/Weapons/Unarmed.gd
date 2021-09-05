extends State


func unhandled_input(event: InputEvent) -> void:
	return


func physics_process(delta: float) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	owner.animation_player.play("Idle_unarmed")


func exit() -> void:
	return
