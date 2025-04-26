extends Area2D

class_name Goal


func _ready() -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	
	if not _body.is_in_group("Bubbles"):
		return
	
	if Game.get_instance().bubbles.dead:
		return
	
	Game.get_instance().show_win_screen()
