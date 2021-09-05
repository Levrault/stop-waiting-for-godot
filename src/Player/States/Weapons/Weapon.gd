extends State

export var weapons_path := NodePath()
export var damage := 15.0

var weapons_point = null
var is_weapon_enabled = false


func _ready() -> void:
	yield(owner, "ready")
	assert(has_node(weapons_path))
	weapons_point = get_node(weapons_path)


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	owner.current_weapon = get_name()


func exit() -> void:
	return
