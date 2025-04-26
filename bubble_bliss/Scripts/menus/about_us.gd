extends Control


func _ready() -> void:
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass


func _on_return_pressed():
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Game.get_instance().show_main_menu()
