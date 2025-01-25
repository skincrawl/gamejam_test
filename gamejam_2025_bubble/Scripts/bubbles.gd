extends RigidBody2D

class_name Bubbles


const MAX_BLOW_STRENGTH:float = 100.0


func _process(_delta:float) -> void:
	
	
	if not Input.is_action_pressed("blowing"):
		return
	
	var screen_size:Vector2 = DisplayServer.window_get_size()
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	mouse_pos = clamp(mouse_pos, Vector2.ZERO, screen_size)
	
	var dir:Vector2 = position - mouse_pos
	
	var monkey_distance:float = mouse_pos.distance_to(global_position) - $CollisionShape2D.shape.radius
	
	var force:Vector2
	var distance_attenuation:float = 1.0
	
	if monkey_distance > 1.0:
		distance_attenuation = 100.0 / monkey_distance
	
	force = MAX_BLOW_STRENGTH * dir.normalized() * distance_attenuation
	
	# print("force strength: ", force.length())
	apply_central_force(force)
	
