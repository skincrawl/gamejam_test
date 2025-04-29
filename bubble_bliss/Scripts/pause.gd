extends VBoxContainer



func _unhandled_input(_event: InputEvent) -> void:
	
	if Game.get_instance().in_level and _event is InputEventKey and Input.is_action_just_released("pause"):
		
		_toggle_pause(not get_tree().paused)


func _toggle_pause(_paused:bool) -> void:
	
	get_tree().paused = _paused
	Game.get_instance().paused_label.visible = _paused
	if _paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
