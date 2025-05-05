extends Area2D

class_name Banana


var destination:Vector2

func _ready() -> void:
	Game.get_instance().current_level.bananas_amount += 1


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles") and not Game.get_instance().bubbles.dead:
		$AudioStreamPlayer.play()
		hide()
		$CollisionShape2D.set_deferred("disabled", true)
		Game.get_instance().bubbles.banana_eaten()
		Game.get_instance().current_level.banana_collected(self)


func _on_audio_stream_player_finished() -> void:
	queue_free()
