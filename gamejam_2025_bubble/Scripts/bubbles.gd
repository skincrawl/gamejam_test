extends RigidBody2D

class_name Bubbles


var strength:float = 50.0
var speed:float = 100.0


func _process(_delta:float) -> void:
	
	var dir:Vector2 = Input.get_vector("left", "right", "down", "up")
	
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	print("mouse pos: ", mouse_pos)
	var force:Vector2 = strength * dir.normalized()
	apply_central_force(force)
	
