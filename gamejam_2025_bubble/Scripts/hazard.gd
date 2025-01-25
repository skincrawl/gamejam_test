extends Area2D

class_name Hazard


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.name == "Bubbles":
		_body.death()
