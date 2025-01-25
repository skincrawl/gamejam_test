extends Control

func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/level.tscn")

func _on_how_to_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")

func _on_about_us_pressed():
	get_tree().change_scene_to_file("res://Scenes/about_us.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()
