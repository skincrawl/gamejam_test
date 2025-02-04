extends Control

var menu_music_intro:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Intro.mp3")
var menu_music:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")


func _ready() -> void:
	
	if AudioServer.is_bus_mute(0):
		return
	
	if not Globals.intro_finished:
		
		$music.stream = menu_music_intro
	
	$music.play(Globals.music_spot)


func _on_return_pressed():
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_music_finished() -> void:
	$music.stream = menu_music
	Globals.music_spot = 0.0
	$music.play()
