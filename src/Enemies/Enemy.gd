extends Actor

var target = null

var has_been_alerted := false

onready var navigation = get_parent()
onready var body := $RotationHelper/Body
onready var google := $RotationHelper/Google
onready var rotation_helper := $RotationHelper
onready var vision := $RotationHelper/Vision
onready var attack_zone := $RotationHelper/AttackZone
onready var damage_source := $RotationHelper/DamageSource
onready var anim := $AnimationPlayer
onready var fist := $RotationHelper/Fist
onready var alert := $RotationHelper/Alert


func _ready() -> void:
	add_to_group("enemies")
	set_axis_lock(self.move_lock_x, true)
	attack_zone.connect("body_entered", self, "_on_Body_entered")


func _on_Body_entered(body: Player) -> void:
	state_machine.transition_to("Attack")
