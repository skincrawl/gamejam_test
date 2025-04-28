extends RigidBody2D


@onready var bubbles:Bubbles = Game.get_instance().bubbles

const BANANA_SPEED:float = 100.0

var force_strength:float = 7000.0

var fleeing:bool = false
var drifting:bool = false


func _physics_process(_delta: float) -> void:
	
	
	if not fleeing:
		if linear_velocity.length() > 10.0:
			drifting = true
		return
	
	if drifting and linear_velocity.length() < BANANA_SPEED:
		$banana_timer.stop()
		drifting = false
	
	flee()


func flee() -> void:
	
	var dir:Vector2 = global_position - bubbles.global_position
	dir = dir.normalized()
	
	apply_central_force(dir * force_strength)


func _on_detection_area_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles"):
		fleeing = true
		$banana_timer.start()


func _on_detection_area_body_exited(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles"):
		fleeing = false
		# $banana_timer.stop()


func _on_banana_timer_timeout() -> void:
	var banana:Banana = preload("res://Scenes/banana.tscn").instantiate()
	Game.get_instance().level.add_child(banana)
	banana.global_position = global_position
