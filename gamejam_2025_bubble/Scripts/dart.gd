extends CharacterBody2D

class_name Dart


var speed:float = 500.0
var shooting_cannon:DartGun

func _ready() -> void:
	pass
	# velocity = speed * Vector2.RIGHT


func _process(_delta:float):
	# print("velocity: ", velocity)
	move_and_slide()


func _on_body_entered(_body: Node2D) -> void:
	
	if _body == shooting_cannon:
		return
	
	if _body.name == "Bubbles":
		Globals.bubbles.death()
	else:
		queue_free()
