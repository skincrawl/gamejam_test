extends Area2D

class_name Banana


var destination:Vector2

func _on_body_entered(_body: Node2D) -> void:
	
	if _body.name == "Bubbles":
		$AudioStreamPlayer.play()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		Globals.bubbles.banana_eaten()
		Globals.level.banana_collected(self)


func _on_audio_stream_player_finished() -> void:
	queue_free()
