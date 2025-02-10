extends Control


func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Menu.grab_focus()


func _on_credits_pressed() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Game.get_instance().show_credits_screen()


func _on_menu_pressed() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Game.get_instance().show_main_menu()
