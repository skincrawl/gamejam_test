extends Node

class_name CheckpointManager

var last_location:Vector2

func _ready() -> void:
	last_location = Globals.bubbles.global_position
