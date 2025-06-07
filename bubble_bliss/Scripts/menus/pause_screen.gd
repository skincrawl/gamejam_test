extends Menu

class_name PauseScreen


func _unhandled_input(_event: InputEvent) -> void:
	
	if Game.get_instance().in_level and _event is InputEventKey and Input.is_action_just_released("pause"):
		
		_toggle_paused()


func _toggle_paused() -> void:
	
	var paused:bool = not get_tree().paused
	get_tree().paused = paused
	
	visible = paused
	
	if paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _on_retry_button_pressed() -> void:
	
	var game:Game = Game.get_instance()
	game.bubbles.reset()
	var level_name:String = game.current_level.level_name
	game.start_level(level_name)
	_toggle_paused()


func _on_menu_button_pressed() -> void:
	
	pass


func _on_quit_button_pressed() -> void:
	
	get_tree().quit()


func _on_resume_button_pressed() -> void:
	
	_toggle_paused()
