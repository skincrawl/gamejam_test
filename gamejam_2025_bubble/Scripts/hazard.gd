extends Area2D

class_name Hazard


func _on_body_entered(_body: Node2D) -> void:
	
	if not _body.has_method("death"):
		printerr("Hazard body entered: ", _body)
		return
	
	_body.death()
