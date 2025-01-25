extends Node2D

class_name Level


var collected_bananas:int = 0

func _ready() -> void:
	
	Globals.level = self
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	$CanvasLayer/lose_text.hide()
	$CanvasLayer/lose_bg.hide()
	$CanvasLayer/lose_bg.size = DisplayServer.window_get_size()


func _process(_delta:float) -> void:
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	$banana_mouse.position = $Bubbles.global_position + mouse_pos


func hit_wall() -> void:
	
	$Bubbles.set_deferred("freeze", true)
	
	$CanvasLayer/lose_text.show()
	$CanvasLayer/lose_bg.show()
	
	await get_tree().create_timer(4.0).timeout
	get_tree().reload_current_scene()


func banana_collected() -> void:
	
	collected_bananas += 1
	$CanvasLayer/bananas.text = "bananas: " + str(collected_bananas)
