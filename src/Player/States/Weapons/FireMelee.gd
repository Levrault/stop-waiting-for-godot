extends State

export var animation_name := "%MyWeapon_attack"
export var next_state := "MyWeapon/Idle"
export var animation_speed := 1.0
export var area_path := NodePath()


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	assert(animation_name != "%MyWeapon_fire")
	assert(next_state != "%MyWeapon/Idle")
	assert(area_path != null)

	owner.animation_player.connect("animation_finished", self, "_on_Animation_finished")
	owner.animation_player.play(animation_name, -1, animation_speed)
	owner.animation_player.callback_function = funcref(self, "fire_weapon")


func exit() -> void:
	owner.animation_player.disconnect("animation_finished", self, "_on_Animation_finished")
	owner.animation_player.playback_speed = 1.0


func _on_Animation_finished(anim_name: String) -> void:
	assert(anim_name == animation_name)
	if owner.is_attacking:
		owner.animation_player.queue(animation_name)
		owner.animation_player.playback_speed = animation_speed
		return
	_state_machine.transition_to(next_state)


func fire_weapon():
	var area = get_node(area_path)
	var bodies = area.get_overlapping_bodies()

	for body in bodies:
		if body == owner:
			continue

		if body.has_method("bullet_hit"):
			body.bullet_hit(_parent.damage, area.global_transform)
