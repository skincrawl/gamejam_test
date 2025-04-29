extends Control

class_name MainMenu


var button_pressed:String = "none"

func _ready():
	
	$start_button.pressed.connect(button_was_pressed)


func button_was_pressed(_button:String) -> void:
	$pop.play()
	print("button was pressed")
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
