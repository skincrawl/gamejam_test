extends Menu


func _ready() -> void:
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass


func _on_return_pressed():
	
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	return_pressed.emit()
