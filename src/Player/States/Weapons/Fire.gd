extends State

export var animation_name := "%MyWeapon_fire"
export var next_state := "MyWeapon/Idle"
export var animation_speed := 1.0

var blood_particule_scene := preload("res://src/VFX/BloodParticules.tscn")
var dust_particule_scene := preload("res://src/VFX/DustParticules.tscn")
var bullet_impact_scene := preload("res://src/VFX/BulletImpact.tscn")

func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	assert(animation_name != "%MyWeapon_fire")
	assert(next_state != "%MyWeapon/Idle")
	owner.hand.gun.anim.connect("animation_finished", self, "_on_Animation_finished")
	owner.hand.gun.anim.play(animation_name, -1, animation_speed)
	owner.hand.gun.anim.callback_function = funcref(self, "fire_weapon")
	owner.crosshair_anim.play("Move", -1, animation_speed)


func exit() -> void:
	owner.hand.gun.anim.disconnect("animation_finished", self, "_on_Animation_finished")
	owner.hand.gun.anim.playback_speed = 1.0
	owner.crosshair_anim.play("Idle")


func _on_Animation_finished(anim_name: String) -> void:
	if owner.is_attacking:
		owner.hand.gun.anim.queue(animation_name)
		owner.hand.gun.anim.playback_speed = animation_speed
		return
	_state_machine.transition_to(next_state)


func fire_weapon():
	owner.raycast_gun.force_raycast_update()

	if not owner.raycast_gun.is_colliding():
		return

	var body = owner.raycast_gun.get_collider()
	var particules = null
	if body.is_in_group("enemies"):
		$AudioStreamPlayer.play_sound()
		body.stats.bullet_hit(_parent.damage, owner.raycast_gun.global_transform)
		particules = blood_particule_scene.instance()
	else:
		if body.has_method("bullet_hit"):
			body.bullet_hit(_parent.damage, owner.raycast_gun.global_transform)
		particules = dust_particule_scene.instance()
		var decal = bullet_impact_scene.instance()
		get_tree().root.get_children()[0].add_child(decal)
		decal.global_transform.origin = owner.raycast_gun.get_collision_point()
		decal.look_at(owner.raycast_gun.get_collision_point() + owner.raycast_gun.get_collision_normal(), Vector3.UP)
	
	get_tree().root.get_children()[0].add_child(particules)
	particules.global_transform.origin = owner.raycast_gun.get_collision_point()
	particules.look_at(owner.global_transform.origin, Vector3.UP)
	particules.emitting = true
	
