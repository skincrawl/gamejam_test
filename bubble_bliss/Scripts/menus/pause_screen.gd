extends Menu

class_name PauseScreen


signal no_longer_in_level


func _unhandled_input(_event: InputEvent) -> void:
	
	if Game.get_instance().in_level and _event is InputEventKey and Input.is_action_just_released("pause"):
		# print("pause pressed from pause screen")
		_toggle_paused()


func _toggle_paused() -> void:
	
	var were_we_paused:bool = get_tree().paused
	var do_we_want_to_be_paused:bool = not were_we_paused
	
	if do_we_want_to_be_paused:
		show_menu()
	else:
		hide_menu()


func _on_retry_button_pressed() -> void:
	
	var game:Game = Game.get_instance()
	game.bubbles.reset()
	var level_name:String = game.current_level.level_name
	game.start_level(level_name)
	
	hide_menu()


func _on_menu_button_pressed() -> void:
	
	get_tree().paused = false
	hide()
	
	no_longer_in_level.emit()


func _on_quit_button_pressed() -> void:
	
	get_tree().quit()


func _on_resume_button_pressed() -> void:
	
	hide_menu()


func show_menu() -> void:
	
	super()
	
	get_tree().paused = true
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func hide_menu() -> void:
	
	super()
	
	get_tree().paused = false
	
	if Game.get_instance().in_level:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func level_starts() -> void:
	
	process_mode = Node.PROCESS_MODE_ALWAYS


func level_ends() -> void:
	
	process_mode = Node.PROCESS_MODE_DISABLED
