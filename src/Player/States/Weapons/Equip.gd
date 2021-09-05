extends State

export var animation_name := "%MyWeapon_equip"
export var next_state := "%MyWeapon/Idle"
export var animation_speed := 1.4


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	assert(animation_name != "%MyWeapon_equip")
	assert(next_state != "%MyWeapon/Idle")

	_parent.enter(msg)
	owner.is_changing_weapon = true
	owner.animation_player.connect("animation_finished", self, "_on_Animation_finished")
	owner.animation_player.play(animation_name, -1, animation_speed)


func exit() -> void:
	owner.animation_player.disconnect("animation_finished", self, "_on_Animation_finished")
	owner.is_changing_weapon = false


func _on_Animation_finished(anim_name: String) -> void:
	assert(anim_name == animation_name)
	_state_machine.transition_to(next_state)
