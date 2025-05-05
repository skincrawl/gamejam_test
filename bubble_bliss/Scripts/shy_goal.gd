extends RigidBody2D


@onready var bubbles:Bubbles = Game.get_instance().bubbles

const DRIFT_SPEED:float = 10.0 # If we're going slowly, we stop dropping bananas
const BANANA_SPEED:float = 100.0 # The speed at which we're dropping bananas
const MAX_SPEED:float = 2000.0 # The speed at which we stop accelerating away from the monkey

const MAX_BANANAS:int = 200 # Maximum amount of bananas kept around at once

var force_strength:float = 15000.0

var fleeing:bool = false
var drifting:bool = false

var bananas:Array = []


func _physics_process(_delta: float) -> void:
	
	
	if not fleeing:
		if linear_velocity.length() > DRIFT_SPEED:
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


# Making sure the shy goal doesn't become too fast!
func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	
	var velocity:Vector2 = _state.linear_velocity
	if velocity.length() > MAX_SPEED:
		_state.linear_velocity = velocity.normalized() * MAX_SPEED


func _on_detection_area_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles"):
		fleeing = true
		$banana_timer.start()


func _on_detection_area_body_exited(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles"):
		fleeing = false
		# $banana_timer.stop()


func _on_banana_timer_timeout() -> void:
	
	# print("speed: ", linear_velocity.length())
	
	var banana:Banana = preload("res://Scenes/level_objects/banana.tscn").instantiate()
	bananas.append(banana)
	
	# Removing oldest banana when we have max bananas
	# if bananas.size() > MAX_BANANAS:
	# 	var old_banana:Banana = bananas.pop_front()
	# 	old_banana.queue_free()
	
	Game.get_instance().current_level.add_child(banana)
	banana.global_position = global_position
