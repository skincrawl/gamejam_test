extends Control

func _ready() -> void:
	
	if not Globals.sound_on:
		return
	$music.volume_db = Globals.sound_volume
	$music.stream = Globals.audio_stream
	$music.play(Globals.music_spot)


func _on_return_pressed():
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
