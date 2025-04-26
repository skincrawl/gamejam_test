extends Control

var level_packed:PackedScene = preload("res://Scenes/levels/og_level.tscn")


func _ready() -> void:
	
	pass


func _on_return_pressed() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Game.get_instance().show_main_menu()


func _on_start_pressed() -> void:
	var level:Level = level_packed.instantiate()
	Game.get_instance().start_level(level)
