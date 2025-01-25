extends Node2D

class_name Level


func _ready() -> void:
	
	Globals.level = self
	
	$CanvasLayer/lose_text.hide()
	$CanvasLayer/lose_bg.hide()
	$CanvasLayer/lose_bg.size = DisplayServer.window_get_size()


func hit_wall() -> void:
	
	$Bubbles.freeze = true
	$CanvasLayer/lose_text.show()
	$CanvasLayer/lose_bg.show()
