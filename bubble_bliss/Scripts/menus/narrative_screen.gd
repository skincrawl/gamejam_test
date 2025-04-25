extends Control


func _ready() -> void:
	
	pass


func _on_return_pressed() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Game.get_instance().show_main_menu()


func _on_start_pressed() -> void:
	Game.get_instance().start_level()
