extends Control


func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Menu.grab_focus()


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
