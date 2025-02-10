extends Area2D

class_name Checkpoint


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles"):
		Game.get_instance().level.checkpoint_manager.last_location = $Marker2D.global_position
