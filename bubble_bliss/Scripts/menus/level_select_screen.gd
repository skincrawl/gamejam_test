extends Control


func _on_level_1_button_pressed() -> void:
	var next_level:Level = preload("res://Scenes/levels/og_level.tscn").instantiate()
	Game.get_instance().start_level(next_level)
