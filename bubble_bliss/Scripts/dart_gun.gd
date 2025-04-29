extends Node2D

class_name DartGun


@export var shoot_period:float = 1.0:
	set(_new_value):
		shoot_period = _new_value
		$shoot_timer.wait_time = shoot_period
 

func _ready() -> void:
	
	$VisibleOnScreenEnabler2D.show()
	
	Game.get_instance().current_level.shoot.connect(shoot)


func shoot() -> void:
	Game.get_instance().current_level.spawn_dart(self)
