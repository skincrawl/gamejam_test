extends RigidBody2D

class_name Bubbles


const MIN_BLOW_STRENGTH:float = 1.0
const MAX_BLOW_STRENGTH:float = 70.0

const MAX_SPEED:float = 900.0

const MAX_CONTROL_DISTANCE:float = 500.0
# Making a little area outside the bubble, where the strength doesn't increase
const CONTROL_MARGIN:float = 1.1

const MAX_MONKEY_SPIN_SPEED:float = 30.0

var dead:bool = false

var monkey_spin_speed:float = 0.0
var monkey_rotation:float = 0.0

func _ready() -> void:
	
	$bubble_top_layer.play("rolling")
	$Bubbles.play("default")
	name = "Bubbles"


func _process(_delta:float) -> void:
	
	monkey_spin_speed = (linear_velocity.length() / MAX_SPEED) * MAX_MONKEY_SPIN_SPEED
	$Bubbles.rotation = -rotation
	monkey_rotation += deg_to_rad(monkey_spin_speed) * _delta
	$Bubbles.rotation += monkey_rotation
	
	# var monkey_reset_speed:float = 50.0
	# var reset_dir:Vector2 = position - $Bubbles.position
	# $Bubbles.position = $Bubbles.position.move_toward(position, 3.0)
	
	# Reset graphics rotation
	$bubble_top_layer.rotation = -rotation
	$bubble_bg_Sprite.rotation = -rotation
	# $Bubbles.rotation = -rotation
	
	if not Input.is_action_pressed("blowing") or dead:
		return
	
	$Bubbles.play("blink")
	
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


func death() -> void:
	dead = true
	$Bubbles.play("lose")
	$bubble_bg_Sprite.hide()
	$bubble_top_layer.play("burst")


func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if _state.linear_velocity.length() > MAX_SPEED:
		_state.linear_velocity = _state.linear_velocity.normalized() * MAX_SPEED


func _on_bubbles_animation_finished() -> void:
	
	match $Bubbles.animation:
		"lose":
			Globals.level.lose()
		"blink":
			$Bubbles.play("default")


func _on_bubble_top_layer_animation_finished() -> void:
	
	$bubble_top_layer.hide()
