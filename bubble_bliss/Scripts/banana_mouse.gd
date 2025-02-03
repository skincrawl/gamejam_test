extends AnimatedSprite2D


# Rotation speed in degrees
const MAX_ROT_SPEED:float = 60.0
const SLOWDOWN_SPEED:float = 90.0

var speed:float = 0.0

func _process(_delta:float) -> void:
	
	if Input.is_action_pressed("blowing"):
		$Part.look_at(Globals.bubbles.position)
		$Part.rotation -= deg_to_rad(90.0)
		$Part.position = position
		$Part/Node2D/CPUParticles2D.emitting = true
		speed = MAX_ROT_SPEED
	else:
		speed = move_toward(speed, 0.0, SLOWDOWN_SPEED * _delta)
		$Part/Node2D/CPUParticles2D.emitting = false
	
	rotation += deg_to_rad(speed)
