extends CharacterBody2D

class_name Dart


var speed:float = 300.0

func _ready() -> void:
	velocity = speed * Vector2.RIGHT


func _process(_delta:float):
	move_and_slide()


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.name == "Bubbles":
		Globals.bubbles.death()
	else:
		queue_free()
