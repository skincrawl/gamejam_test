extends Button

class_name LevelButton

@export var level_name:String

signal level_selected(level_name:String)




func _on_pressed() -> void:
	
	level_selected.emit(level_name)
