extends CSGBox

export var kill_count := 0

var has_been_unlocked := false


func _ready() -> void:
	$AudioStreamPlayer.connect("finished", self, "_on_Finished")


func _process(delta):
	if has_been_unlocked:
		set_process(false)
	if Game.kills >= kill_count:
		print_debug("%s has been unlocked" % get_name())
		$AudioStreamPlayer.play()
		has_been_unlocked = true


func _on_Finished() -> void:
	queue_free()
