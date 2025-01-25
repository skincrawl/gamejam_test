extends RigidBody2D

class_name Bubbles


const MIN_BLOW_STRENGTH:float = 10.0
const MAX_BLOW_STRENGTH:float = 100.0

const MAX_SPEED:float = 300.0

const MAX_CONTROL_DISTANCE:float = 500.0
# Making a little area outside the bubble, where the strength doesn't increase
const CONTROL_MARGIN:float = 1.1


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
	
	var monkey_distance:float = max(0, mouse_pos.distance_to(screen_middle) - $CollisionShape2D.shape.radius * CONTROL_MARGIN)
	
	# print("monkey distance: ", monkey_distance)
	
	var force:Vector2
	var distance_attenuation:float = 0.0
	
	if monkey_distance > 1.0:
		distance_attenuation = MAX_CONTROL_DISTANCE / min(monkey_distance, MAX_CONTROL_DISTANCE)
	
	# force = monkey_distance * dir.normalized() * distance_attenuation
	var blow_strength:float = lerp(MIN_BLOW_STRENGTH, MAX_BLOW_STRENGTH, distance_attenuation)
	force = MAX_BLOW_STRENGTH * dir.normalized() * blow_strength * _delta
	
	# print("force strength: ", force.length())
	apply_central_force(force)
	

func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if _state.linear_velocity.length() > MAX_SPEED:
		_state.linear_velocity = _state.linear_velocity.normalized() * MAX_SPEED
