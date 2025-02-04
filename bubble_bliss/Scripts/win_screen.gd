extends Control


var menu_music_intro:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Intro.mp3")
var menu_music:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")


func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Menu.grab_focus()
	
	if AudioServer.is_bus_mute(0):
		$music.stop()


func _on_credits_pressed() -> void:
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_menu_pressed() -> void:
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
