extends AnimationPlayer

var current_state = null
var callback_function = null


func animation_callback():
	if callback_function == null:
		print(
			"AnimationPlayer_Manager.gd -- WARNING: No callback function for the animation to call!"
		)
	else:
		callback_function.call_func()
