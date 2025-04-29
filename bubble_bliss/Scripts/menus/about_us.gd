extends Menu

class_name AboutUsMenu


func _ready() -> void:
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE


func _on_return_pressed():
	
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	return_pressed.emit()
