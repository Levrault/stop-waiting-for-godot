extends KinematicBody
class_name Actor

export var gravity_default := -118.8
export var max_slope_angle := 40
export var life := 40.0

var gravity := gravity_default
var is_death := false

onready var stats := $Stats
onready var state_machine := $StateMachine
