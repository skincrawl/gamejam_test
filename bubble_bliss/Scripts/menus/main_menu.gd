extends Control

class_name MainMenu


var button_pressed:String = "none"

func _ready():
	
	var game:Game = Game.get_instance()
	if game == null:
		game = preload("res://Scenes/game.tscn").instantiate()
		get_tree().root.call_deferred("add_child", game)
		get_tree().root.call_deferred("remove_child", self)
		game.call_deferred("add_child", self)


func button_was_pressed(_button:String) -> void:
	$pop.play()
	button_pressed = _button



func _on_about_us_pressed():
	$pop.play()
	button_pressed = "about_us"

func _on_options_pressed():
	$pop.play()
	button_pressed = "settings"

func _on_level_select_pressed() -> void:
	$pop.play()
	button_pressed = "level_select"

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
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	match button_pressed:
		"start game":
			game.start_pressed()
		"how to play":
			game.show_how_to_screen()
		"about us":
			game.show_about_us_screen()
		"settings":
			game.show_settings_menu()
		"level select":
			game.show_level_select()
		"quit":
			get_tree().quit()
		_:
			pass
