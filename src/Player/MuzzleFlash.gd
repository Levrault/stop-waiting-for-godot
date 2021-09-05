extends Spatial

var muzzle_scene = preload("res://src/Weapons/MuzzleSmoke.tscn")


func play() -> void:
	var clone = muzzle_scene.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	clone.global_transform = self.global_transform
	clone.get_node("AnimationPlayer").play("DEFAULT")
