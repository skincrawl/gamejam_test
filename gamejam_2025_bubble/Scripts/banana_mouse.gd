extends AnimatedSprite2D


# Rotation speed in degrees
const MAX_ROT_SPEED:float = 60.0
const SLOWDOWN_SPEED:float = 90.0

var speed:float = 0.0

func _process(_delta:float) -> void:
	
	if Input.is_action_pressed("blowing"):
		speed = MAX_ROT_SPEED
	else:
		speed = move_toward(speed, 0.0, SLOWDOWN_SPEED * _delta)
	
	rotation += deg_to_rad(speed)
