extends Area2D

class_name Banana


var destination:Vector2

func _on_body_entered(_body: Node2D) -> void:
	
	if _body.name == "Bubbles":
		Globals.level.banana_collected(self)
		queue_free()
