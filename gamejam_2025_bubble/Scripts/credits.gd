extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Menu.grab_focus()
	
	if not Globals.sound_on:
		$music.stop()
		return
	$music.volume_db = Globals.sound_volume
	$music.play(Globals.music_spot)


func _on_menu_pressed() -> void:
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
