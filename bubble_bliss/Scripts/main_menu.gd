extends Control


var button_pressed:String = "none"


func _ready():
	
	if not Engine.is_editor_hint():
		$bg.hide()


func _on_start_game_pressed():
	$pop.play()
	button_pressed = "start"

func _on_how_to_play_pressed():
	$pop.play()
	button_pressed = "how_to_play"

func _on_about_us_pressed():
	$pop.play()
	button_pressed = "about_us"

func _on_options_pressed():
	$pop.play()
	button_pressed = "settings"

func _on_quit_pressed():
	$pop.play()
	button_pressed = "quit"


func update_GUI() -> void:
	var title_control_rect:Rect2 = $CanvasLayer/HBoxContainer/Control/Title_control.get_viewport_rect()
	print("title control rect: ", title_control_rect)
	var title_center:Vector2 = title_control_rect.position + 0.5 * title_control_rect.size
	$CanvasLayer/HBoxContainer/Control/Title_control/title.position = title_center


func viewport_size_changed() -> void:
	# update_GUI()
	pass


func _on_pop_finished() -> void:
	
	var game:Game = Game.get_instance()
	
	match button_pressed:
		"start":
			game.start_pressed()
		"how_to_play":
			game.show_how_to_screen()
		"about_us":
			game.show_about_us_screen()
		"settings":
			game.show_settings_menu()
		"quit":
			get_tree().quit()
		_:
			pass
