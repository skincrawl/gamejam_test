extends Control

class_name MainMenu


var button_pressed:String = "none"

signal button_presseded(button_action:String)


func _ready():
	pass
	# $start_button.pressed.connect(button_was_pressed)
	# $how_to_play_button.pressed.connect(button_was_pressed)


func button_was_pressed(_button:String) -> void:
	$pop.play()
	# print("button was pressed")
	button_pressed = _button


func _on_pop_finished() -> void:
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	button_presseded.emit(button_pressed)
