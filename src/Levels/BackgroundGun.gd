extends Spatial



func _ready():
	$Tween.interpolate_property($portal_gun, "rotation_degrees:y", 0, 360, 4, Tween.TRANS_LINEAR, Tween.TRANS_LINEAR)
	$Tween.start()
