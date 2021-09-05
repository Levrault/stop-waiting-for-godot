extends Node


func bullet_hit(damage, bullet_global_trans):
	if owner.is_death:
		return
	$AudioStreamPlayer.play_sound()
	health_depleted(damage)


func health_depleted(damage: float) -> void:
	owner.life -= damage

	if owner.life <= 0.0 and not owner.is_death:
		owner.is_death = true
		Events.emit_signal("game_over")
		print_debug("Player is death")
		return
	owner.damage_anim.play("Damage")
