# @tool
extends StaticBody2D

class_name Fan


const MAX_DISTANCE:float = 5.0
const MIN_DISTANCE:float = 0.5

const MIN_PUSH_STRENGTH:float = 10.0
const MAX_PUSH_STRENGTH:float = 500.0

@export var push_distance_multiplier:float = 0.5:
	set(_new_value):
		push_distance_multiplier = _new_value
		push_distance = lerp(MIN_DISTANCE, MAX_DISTANCE, push_distance_multiplier)
		if has_node("Area2D"):
			$Area2D.scale.y = push_distance
@export var push_strength_multiplier:float = 0.5:
	set(_new_value):
		push_strength_multiplier = _new_value
		push_strength = lerp(MIN_PUSH_STRENGTH, MAX_PUSH_STRENGTH, push_strength_multiplier)

var push_distance:float
var push_strength:float

var bubbles:Bubbles = null


func _ready() -> void:
	
	$Part/Node2D/CPUParticles2D.emitting = true
	
	push_distance = lerp(MIN_DISTANCE, MAX_DISTANCE, push_distance_multiplier)
	if has_node("Area2D"):
		$Area2D.scale.y = push_distance
	push_strength = lerp(MIN_PUSH_STRENGTH, MAX_PUSH_STRENGTH, push_strength_multiplier)


func _physics_process(_delta: float) -> void:
	
	if bubbles == null:
		return
	
	var dir:Vector2 = Vector2.DOWN.rotated(rotation)
	var push_force:Vector2 = -dir.normalized() * push_strength
	bubbles.apply_central_force(push_force)


func _on_area_2d_body_entered(_body: Node2D) -> void:
	
	if _body.name == "Bubbles":
		bubbles = _body


func _on_area_2d_body_exited(_body: Node2D) -> void:
	if _body.name == "Bubbles":
		bubbles = null
