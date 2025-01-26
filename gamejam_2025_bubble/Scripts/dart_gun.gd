extends Node2D

class_name DartGun

func _on_shoot_timer_timeout() -> void:
	# var dart_spawn_pos:Vector2 = $dart_spawn.global_position
	Globals.level.dart_spawned(self)
