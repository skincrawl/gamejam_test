extends Control


var level_path:String = "res://Scenes/levels/"

signal level_selected(level_name:String)
signal return_pressed


func _on_return_button_pressed() -> void:
	
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()
	
	return_pressed.emit()


func _on_level_selected(level_name: String) -> void:
	
	level_selected.emit(level_name)
