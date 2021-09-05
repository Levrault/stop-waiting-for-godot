extends Spatial

var BULLET_SPEED := 870
var BULLET_DAMAGE := 15

const KILL_TIMER := 4
var timer := 0.0

var hit_something := false


func _ready():
	$Area.connect("body_entered", self, "_on_Body_entered")


func _physics_process(delta: float) -> void:
	var forward_dir = global_transform.basis.z.normalized()
	global_translate(forward_dir * BULLET_SPEED * delta)

	timer += delta
	if timer >= KILL_TIMER:
		queue_free()


func _on_Body_entered(body) -> void:
	if hit_something == false:
		if body.has_method("bullet_hit"):
			body.bullet_hit(BULLET_DAMAGE, global_transform)

	hit_something = true
	queue_free()
