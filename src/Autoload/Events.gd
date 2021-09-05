# Signal Autoload Pattern
# @see https://www.youtube.com/watch?v=S6PbC4Vqim4
extends Node

# notification
signal notification_started(text, size)

# level
signal level_preload_finished

# in-game interfaces
signal game_paused
signal game_unpaused

# menu
signal menu_route_changed(route)

# input
signal keybinding_started(scancode)
signal keybinding_canceled
signal keybinding_resetted
signal keybinding_key_selected(scancode)

# serialize
signal game_saved

# transitions
signal transition_started(anim_name)
signal transition_mid_animated
signal transition_finished

signal game_over

signal input_activated
signal input_desactivated
