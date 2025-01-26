extends Control


func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Menu.grab_focus()
	if not Globals.sound_on:
		$music.stop()
		return
	
	$music.play(Globals.music_spot)
	$music.volume_db = Globals.sound_volume


func _on_credits_pressed() -> void:
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_menu_pressed() -> void:
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
