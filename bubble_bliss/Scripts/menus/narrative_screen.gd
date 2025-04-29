extends Menu

class_name NarrativeMenu


var level_packed:PackedScene = preload("res://Scenes/levels/test_level_1.tscn")

signal start_level(level_name:String)


func _ready() -> void:
	
	pass


func _on_return_pressed() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	return_pressed.emit()


func _on_start_pressed() -> void:
	
	start_level.emit("og_level")
