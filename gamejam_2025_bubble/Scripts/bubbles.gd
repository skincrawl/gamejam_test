extends RigidBody2D

class_name Bubbles


const MAX_BLOW_STRENGTH:float = 1500.0


func _ready() -> void:
	$AnimatedSprite2D.play("rolling")
	name = "Bubbles"


func _process(_delta:float) -> void:
	
	
	if not Input.is_action_pressed("blowing"):
		return
	
	var screen_size:Vector2 = DisplayServer.window_get_size()
	var screen_middle:Vector2 = 0.5 * screen_size
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	mouse_pos = clamp(mouse_pos, Vector2.ZERO, screen_size)
	
	var dir:Vector2 = screen_middle - mouse_pos
	
	var monkey_distance:float = max(0, mouse_pos.distance_to(screen_middle) - $CollisionShape2D.shape.radius)
	
	# print("monkey distance: ", monkey_distance)
	
	var force:Vector2
	var distance_attenuation:float = 0.0
	
	if monkey_distance > 1.0:
		distance_attenuation = 1.0 / monkey_distance
	
	# force = monkey_distance * dir.normalized() * distance_attenuation
	force = MAX_BLOW_STRENGTH * dir.normalized() * distance_attenuation
	
	# print("force strength: ", force.length())
	apply_central_force(force)
	
