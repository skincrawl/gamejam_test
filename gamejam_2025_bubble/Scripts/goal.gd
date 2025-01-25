extends Area2D



func _on_body_entered(_body: Node2D) -> void:
	
	if _body.name == "Bubbles":
		
		get_tree().change_scene_to_file.call_deferred("res://Scenes/win_screen.tscn")
