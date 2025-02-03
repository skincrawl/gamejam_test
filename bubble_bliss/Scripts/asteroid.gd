extends CharacterBody2D


var rot_speed:float = 5.0


func _process(_delta:float) -> void:
	
	rotation += deg_to_rad(rot_speed * _delta)
