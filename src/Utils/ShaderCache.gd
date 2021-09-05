extends Spatial

var countdown := 2


func _process(delta: float) -> void:
	if countdown > 0:
		countdown -= 1
		return
	visible = false
	set_process(false)
