extends State

export var animation_name := "%MyWeapon_unequip"
export var animation_speed := 1.4

var next_state := ""


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	assert(animation_name != "%MyWeapon_unequip")
	if "next_state" in msg:
		next_state = msg.next_state

	owner.animation_player.connect("animation_finished", self, "_on_Animation_finished")
	owner.animation_player.play(animation_name, -1, animation_speed)
	owner.is_changing_weapon = true


func exit() -> void:
	owner.animation_player.disconnect("animation_finished", self, "_on_Animation_finished")
	owner.is_changing_weapon = false


func _on_Animation_finished(anim_name: String) -> void:
	assert(anim_name == animation_name)
	_state_machine.transition_to(next_state)
