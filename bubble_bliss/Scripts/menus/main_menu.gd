extends Menu

class_name MainMenu


var button_action:String = "none"

signal button_pressed(button_action:String)


func _ready():
	
	super._ready()
	pass


func button_was_pressed(_button_action:String) -> void:
	
	$pop.play()
	button_action = _button_action


func _on_pop_finished() -> void:
	
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	button_pressed.emit(button_action)
