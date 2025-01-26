extends Control


func _ready() -> void:
	
	$music.stream = Globals.audio_stream
	$music.play(Globals.music_spot)


func _on_return_pressed() -> void:
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_start_pressed() -> void:
	Globals.music_spot = 0.0
	get_tree().change_scene_to_file("res://Scenes/level.tscn")
