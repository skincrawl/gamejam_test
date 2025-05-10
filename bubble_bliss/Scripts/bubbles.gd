extends RigidBody2D

class_name Bubbles


const MIN_BLOW_STRENGTH:float = 1.0
const MAX_BLOW_STRENGTH:float = 12.0 * 100.0 # Assume 1 m = 100 px, then 750 N = 750 kg * m/s^2 * 100 px/m = 750,000 px/s^2 

const MAX_SPEED:float = 2000.0

const MAX_CONTROL_DISTANCE:float = 500.0

# Making a little area where blowing air doesn't work
const CONTROL_MARGIN:float = 1.1

const MAX_MONKEY_SPIN_SPEED:float = 30.0

var dead:bool = false

var monkey_spin_speed:float = 0.0
var monkey_rotation:float = 0.0

var yum_sounds:Array


func _ready() -> void:
	
	add_to_group("Bubbles")
	
	hide()
	process_mode = Node.PROCESS_MODE_DISABLED
	
	$bubble_top_layer.play("rolling")
	$Bubbles.play("default")
	
	yum_sounds.append(preload("res://Assets/Audio/SFX/monkey_bubbles/yum_pitched_1.mp3"))
	yum_sounds.append(preload("res://Assets/Audio/SFX/monkey_bubbles/yum_pitched_2.mp3"))
	yum_sounds.append(preload("res://Assets/Audio/SFX/monkey_bubbles/yum_pitched_3.mp3"))
	yum_sounds.append(preload("res://Assets/Audio/SFX/monkey_bubbles/yum_pitched_4.mp3"))
	yum_sounds.append(preload("res://Assets/Audio/SFX/monkey_bubbles/yum_pitched_5.mp3"))


func _unhandled_input(_event:InputEvent):
	
	if dead:
		return
	
	if _event is InputEventMouseButton:
		if Input.is_action_just_pressed("blowing"):
			$Bubbles.play("blink")
		elif Input.is_action_just_released("blowing"):
			$Bubbles.play("default")


# Negating the rotation that arrises from the physics engine in the graphical elements,
# so that they can have an independent rotation
# I did try locking the rotation of the monkey in the RigidBody2D, but that affected how the bubble behaves when
# bouncing off walls and I didn't like it.
func _physics_process(_delta:float) -> void:
	
	# Spinning the monkey
	monkey_spin_speed = sign(linear_velocity.x) * sign(linear_velocity.y) * (linear_velocity.length() / MAX_SPEED) * MAX_MONKEY_SPIN_SPEED
	# Reset graphics rotation
	$Bubbles.rotation = -rotation
	monkey_rotation += deg_to_rad(monkey_spin_speed) * _delta
	$Bubbles.rotation += monkey_rotation
	
	# Bouncy monkey
	# var monkey_reset_speed:float = 50.0
	# var reset_dir:Vector2 = position - $Bubbles.position
	# $Bubbles.position = $Bubbles.position.move_toward(position, 3.0)
	
	# Reset graphics rotation
	$bubble_top_layer.rotation = -rotation
	$bubble_bg_Sprite.rotation = -rotation
	
	if dead or not Input.is_action_pressed("blowing"):
		return
	
	# var screen_size:Vector2 = DisplayServer.window_get_size()
	# var screen_middle:Vector2 = 0.5 * screen_size
	
	var mouse_pos:Vector2 = get_global_mouse_position()
	var dir:Vector2 = global_position - mouse_pos
	
	# var monkey_distance:float = max(0, mouse_pos.distance_to(screen_middle) - $CollisionShape2D.shape.radius * CONTROL_MARGIN)
	var monkey_distance:float = max(0, mouse_pos.distance_to(global_position) - $CollisionShape2D.shape.radius * CONTROL_MARGIN)
	
	# print("monkey distance: ", monkey_distance)
	
	var force:Vector2
	var distance_attenuation:float = clamp((MAX_CONTROL_DISTANCE - monkey_distance) / MAX_CONTROL_DISTANCE, 0.0, MAX_CONTROL_DISTANCE)
	
	# With distance attenuation
	var blow_strength:float = lerp(MIN_BLOW_STRENGTH, MAX_BLOW_STRENGTH, distance_attenuation)
	force = dir.normalized() * blow_strength
	
	# Without distance attenuation
	# Removing the distance attenuation, because you can affect the monkey movement slightly just by tapping the mouse button, instead
	# of blowing air from further away
	# force = MAX_BLOW_STRENGTH * dir.normalized()
	
	# print("force strength: ", force.length())
	apply_central_force(force)


func reset() -> void:
	
	dead = false
	linear_velocity = Vector2.ZERO
	
	rotation = 0.0
	monkey_rotation = 0.0
	$Bubbles.rotation = 0.0
	
	$Bubbles.play("default")
	
	$bubble_bg_Sprite.show()
	$bubble_top_layer.show()
	$bubble_top_layer.play("rolling")


func death() -> void:
	
	if dead:
		return
	
	dead = true
	
	$Bubbles.play("lose")
	$bubble_bg_Sprite.hide()
	$bubble_top_layer.play("burst")
	
	$pop.play()
	$scream.play()


func banana_eaten() -> void:
	
	var chance:float = randf()
	if chance < 0.2:
		$yum.stream = yum_sounds.pick_random()
		$yum.play()


func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if _state.linear_velocity.length() > MAX_SPEED:
		_state.linear_velocity = _state.linear_velocity.normalized() * MAX_SPEED


func _on_bubbles_animation_finished() -> void:
	
	match $Bubbles.animation:
		"lose":
			Game.get_instance().lose()
		"blink":
			$Bubbles.play("default")


func _on_bubble_top_layer_animation_finished() -> void:
	
	$bubble_top_layer.hide()


func _on_area_2d_body_entered(_body: Node2D) -> void:
	$sfx.play()
