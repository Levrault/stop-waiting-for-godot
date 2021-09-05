extends MeshInstance

signal body_disolved

onready var tween := $Tween
onready var material := get_surface_material(0)


func _ready() -> void:
	tween.connect("tween_all_completed", self, "_on_Tween_tween_all_completed")
	material.set_shader_param("dissolve_amount", 0.0)


func dissolve():
	visible = true
	tween.interpolate_method(
		self, "animate_dissolve", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()


func animate_dissolve(progress: float) -> void:
	material.set_shader_param("dissolve_amount", ease(progress, 0.5))


func _on_Tween_tween_all_completed() -> void:
	visible = false
	emit_signal("body_disolved")
	queue_free()
