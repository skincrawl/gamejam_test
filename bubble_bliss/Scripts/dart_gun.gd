extends Node2D

class_name DartGun


const LASER_DISTANCE:float = 2500.0


@export var shoot_period:float = 1.0:
	set(_new_value):
		shoot_period = _new_value
		$shoot_timer.wait_time = shoot_period

@export var type:String = "own_timer" # Can be own_timer, synced_timer, or detector
 
var can_shoot:bool = true
var laser_color:Color = Color.RED


func _ready() -> void:
	
	$VisibleOnScreenEnabler2D.show()
	
	var laser:RayCast2D = $Laser
	var line:Line2D = $Laser/Line2D
	if not type == "detector":
		laser.hide()
		laser.enabled = false
	
	match type:
		"own_timer":
			$shoot_timer.timeout.connect(shoot)
			$shoot_timer.start()
		"synced_timer":
			Game.get_instance().current_level.shoot.connect(shoot)
		"detector":
			laser_color.a = 0.5
			line.default_color = laser_color
			laser.target_position = laser.target_position.normalized() * LASER_DISTANCE
		_:
			pass


func _physics_process(_delta: float) -> void:
	
	if not type == "detector":
		return
	 
	var laser:RayCast2D = $Laser
	_update_laser()
	
	# Checking if the laser is hitting the monkey
	if can_shoot and laser.is_colliding() and laser.get_collider().is_in_group("Bubbles"):
		shoot()


func shoot() -> void:
	
	can_shoot = false
	$cool_down.start()
	Game.get_instance().current_level.spawn_dart(self)


func _update_laser() -> void:
	
	var laser:RayCast2D = $Laser
	var line:Line2D = $Laser/Line2D
	var end_point:Vector2 = Vector2.RIGHT * LASER_DISTANCE
	if laser.is_colliding():
		end_point = to_local(laser.get_collision_point())
		# pass
	line.points = [Vector2.ZERO, end_point]


func _on_cool_down_timeout() -> void:
	
	can_shoot = true
