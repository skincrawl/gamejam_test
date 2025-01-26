extends AnimatedSprite2D


var spin_speed:float = 5.0


func _process(_delta:float) -> void:
	
	rotation += deg_to_rad(spin_speed) * _delta
