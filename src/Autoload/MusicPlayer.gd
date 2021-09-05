extends AudioStreamPlayer


func _ready():
	connect("finished", self, "play")
