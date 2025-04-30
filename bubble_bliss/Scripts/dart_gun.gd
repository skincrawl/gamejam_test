extends Node2D

class_name DartGun


const LASER_DISTANCE:float = 2500.0


@export var shoot_period:float = 1.0:
	set(_new_value):
		shoot_period = _new_value
		$shoot_timer.wait_time = shoot_period

@export var type:String = "own_timer" # Can be own_timer, synced_timer, or detector
 
var can_shoot:bool = true


func _ready() -> void:
	
	$VisibleOnScreenEnabler2D.show()
	
	var laser:RayCast2D = $Laser
	match type:
		"own_timer":
			$shoot_timer.timeout.connect(shoot)
			$shoot_timer.start()
			laser.hide()
			laser.enabled = false
		"synced_timer":
			Game.get_instance().current_level.shoot.connect(shoot)
			laser.hide()
			laser.enabled = false
		"detector":
			laser.target_position = laser.target_position.normalized() * LASER_DISTANCE
			var line:Line2D = $Laser/Line2D
			line.default_color = Color.RED
			var end_point:Vector2 = Vector2.RIGHT * LASER_DISTANCE
			if laser.is_colliding():
				end_point = laser.get_collision_point()
			line.points = [Vector2.ZERO, end_point]
		_:
			pass


func _physics_process(_delta: float) -> void:
	
	if not type == "detector":
		return
	 
	var laser:RayCast2D = $Laser
	if can_shoot and laser.is_colliding() and laser.get_collider().is_in_group("Bubbles"):
		shoot()


func shoot() -> void:
	
	print("shooting from dart gun shoot()")
	
	can_shoot = false
	$cool_down.start()
	Game.get_instance().current_level.spawn_dart(self)


func _on_cool_down_timeout() -> void:
	
	can_shoot = true
