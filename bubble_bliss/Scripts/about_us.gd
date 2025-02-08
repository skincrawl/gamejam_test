extends Control


func _ready() -> void:
	
	pass


func _on_return_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
