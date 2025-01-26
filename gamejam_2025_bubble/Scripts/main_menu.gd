extends Control

var menu_music:AudioStream = preload("res://Assets/Music/MainMenu_Theme_FGJ25.mp3")

func _ready():
	
	get_viewport().size_changed.connect(viewport_size_changed)
	
	$music.stream = menu_music
	$music.play()
	
	await get_tree().create_timer(1.01).timeout
	# update_GUI()


func _on_start_game_pressed():
	get_tree().change_scene_to_file("res://Scenes/narrative_screen.tscn")

func _on_how_to_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/how_to_play.tscn")

func _on_about_us_pressed():
	get_tree().change_scene_to_file("res://Scenes/about_us.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()


func update_GUI() -> void:
	var title_control_rect:Rect2 = $CanvasLayer/HBoxContainer/Control/Title_control.get_viewport_rect()
	print("title control rect: ", title_control_rect)
	var title_center:Vector2 = title_control_rect.position + 0.5 * title_control_rect.size
	$CanvasLayer/HBoxContainer/Control/Title_control/title.position = title_center


func viewport_size_changed() -> void:
	# update_GUI()
	pass
