extends Area2D

class_name Checkpoint


func _ready() -> void:
	# Globals.checkpoint_manager = CheckpointManager.new()
	pass


func _on_body_entered(_body: Node2D) -> void:
	# print("body entered checkpoint")
	if _body.is_in_group("Bubbles"):
		var game:Game = Game.get_instance()
		if game.checkpoint_manager == null:
			game.checkpoint_manager = CheckpointManager.new()
		Game.get_instance().checkpoint_manager.last_location = $Marker2D.global_position
