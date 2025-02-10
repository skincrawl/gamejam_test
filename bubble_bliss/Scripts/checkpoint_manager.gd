extends Node

class_name CheckpointManager

var last_location:Vector2

func _ready() -> void:
	last_location = Game.get_instance().bubbles.global_position
