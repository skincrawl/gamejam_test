extends Control

class_name Menu


@export var menu_name:String
@export var return_button:Button

signal start_pressed(_level_name:String)
signal return_pressed(_menu_we_want:String)


func _ready() -> void:
	
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	if return_button == null:
		return
	
	return_button.pressed.connect(_on_return_pressed)


func _on_return_pressed() -> void:
	
	print("return pressed from: ", menu_name)
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	process_mode = Node.PROCESS_MODE_DISABLED
	
	return_pressed.emit("main")


func _on_start_pressed() -> void:
	start_pressed.emit("og_level")
