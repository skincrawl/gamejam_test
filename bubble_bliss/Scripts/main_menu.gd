extends Control


var button_pressed:String = "none"


func _ready():
	
	get_viewport().size_changed.connect(viewport_size_changed)
	
	# print("globals sound on: ", Globals.sound_on)
	
	if AudioServer.is_bus_mute(0):
		return
	
	if Globals.intro_finished:
		$music.play(Globals.music_spot)
	else:
		$menu_music_intro.play(Globals.music_spot)


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
	button_pressed = "options"

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
	
	Globals.music_spot = $music.get_playback_position()
	
	var callable:Callable
	match button_pressed:
		"start":
			get_tree().change_scene_to_file.call_deferred("res://Scenes/narrative_screen.tscn")
		"how_to_play":
			get_tree().change_scene_to_file.call_deferred("res://Scenes/how_to_play.tscn")
		"about_us":
			get_tree().change_scene_to_file.call_deferred("res://Scenes/about_us.tscn")
		"options":
			get_tree().change_scene_to_file.call_deferred("res://Scenes/options_menu.tscn")
		"quit":
			get_tree().quit()
		_:
			pass


func _on_menu_music_intro_finished() -> void:
	Globals.intro_finished = true
	Globals.music_spot = 0.0
	$music.play()
