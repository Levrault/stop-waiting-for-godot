extends Actor
class_name Player

const MOUSE_SENSITIVITY := 0.15

var is_handling_input := true
var is_snapped_to_floor := true
var is_attacking := false

onready var animation_player := $RotationHelper/Model/AnimationPlayer
onready var muzzle_flash := $RotationHelper/Gun_Fire_Points/MuzzleFlash

onready var hand := $RotationHelper/Model/Weapon/Hand

onready var weapons_state_machine := $WeaponsStateMachine
onready var camera = $RotationHelper/Camera
onready var rotation_helper = $RotationHelper
onready var body_collision_shape := $BodyCollisionShape
onready var head_bunker := $RotationHelper/HeadBunker
onready var raycast_left := $RotationHelper/RayCastLeft
onready var raycast_right := $RotationHelper/RayCastRight
onready var raycast_gun := $RotationHelper/Gun_Fire_Points/RayCast
onready var look_at := $LookAt
onready var damage_anim := $HUD/Damage/AnimationPlayer
onready var crosshair_anim := $HUD/Crosshair/AnimationPlayer
onready var pause := $HUD/Pause


func _ready() -> void:
	Events.connect("input_desactivated", self, "_on_Handling_input", [false])
	Events.connect("input_activated", self, "_on_Handling_input", [true])
	Game.player_instance = self


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire"):
		weapons_state_machine.transition_to("Gun/Fire")
		is_attacking = true
		return

	if event.is_action_released("fire"):
		is_attacking = false
		return


func _on_Handling_input(value: bool) -> void:
	set_process_input(value)
	pause.set_process_input(value)
