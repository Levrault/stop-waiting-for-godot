extends State

export var animation_name := "%MyWeapon_idle"
export var animation_speed := 1.0


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	assert(animation_name != "%MyWeapon_idle")
	owner.hand.gun.anim.play(animation_name, -1, animation_speed)


func exit() -> void:
	pass
