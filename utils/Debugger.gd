extends Node
class_name Debugger

func _process(delta : float) -> void:
	if Input.is_action_just_pressed('debug_fullscreen'):
		OS.window_fullscreen = not OS.window_fullscreen
	elif Input.is_action_just_pressed('ui_cancel'):
		get_tree().quit()