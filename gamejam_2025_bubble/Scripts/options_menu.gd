extends Control


func _ready() -> void:
	$music.stream = Globals.audio_stream


func _on_return_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
