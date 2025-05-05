extends Menu

class_name WinScreen


signal no_longer_in_level


func _ready() -> void:
	
	super._ready()
	
	$VBoxContainer/Menu.grab_focus()


func _on_credits_pressed() -> void:
	
	Game.get_instance().show_menu("credits")


func _on_visibility_changed() -> void:
	
	if visible:
		no_longer_in_level.emit()
