extends Area2D

class_name Banana


var destination:Vector2

func _on_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles"):
		$AudioStreamPlayer.play()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		Game.get_instance().bubbles.banana_eaten()
		Game.get_instance().level.banana_collected(self)


func _on_audio_stream_player_finished() -> void:
	queue_free()
