extends Area2D

class_name Checkpoint


func _ready() -> void:
	# Globals.checkpoint_manager = CheckpointManager.new()
	pass


func _on_body_entered(_body: Node2D) -> void:
	if _body.is_in_group("Bubbles"):
		Globals.checkpoint_manager.last_location = $Marker2D.global_position
