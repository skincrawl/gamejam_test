extends Area2D

class_name Checkpoint


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles") and not Game.get_instance().bubbles.dead:
		Game.get_instance().current_level.checkpoint_reached($Marker2D.global_position)
