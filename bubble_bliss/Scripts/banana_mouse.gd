extends AnimatedSprite2D


# Rotation speed in degrees
const MAX_ROT_SPEED:float = 60.0
const SLOWDOWN_SPEED:float = 90.0

@onready var sound:AudioStreamPlayer = $AudioStreamPlayer

var speed:float = 0.0


func _unhandled_input(_event: InputEvent) -> void:
	if _event is InputEventMouseButton and Input.is_action_just_pressed("blowing"):
		sound.play(randf() * sound.stream.get_length())
	elif _event is InputEventMouseButton and Input.is_action_just_released("blowing"):
		sound.stop()


func _physics_process(_delta:float) -> void:
	
	if Input.is_action_pressed("blowing"):
		$Part.look_at(Game.get_instance().bubbles.global_position)
		$Part.rotation -= deg_to_rad(90.0)
		$Part.position = position
		$Part/Node2D/CPUParticles2D.emitting = true
		speed = MAX_ROT_SPEED
	else:
		speed = move_toward(speed, 0.0, SLOWDOWN_SPEED * _delta)
		$Part/Node2D/CPUParticles2D.emitting = false
	
	rotation += deg_to_rad(speed)
