extends Node


func bullet_hit(damage, bullet_global_trans):
	if owner.is_death:
		return
	health_depleted(damage)


func health_depleted(damage: float) -> void:
	owner.life -= damage

	if owner.life <= 0.0 and not owner.is_death:
		owner.state_machine.transition_to("Die")
		owner.is_death = true
		return
	owner.state_machine.transition_to("Follow", {bullet_hit=true})
