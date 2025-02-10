extends Area2D


func _ready() -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.is_in_group("Bubbles") and not Game.get_instance().bubbles.dead:
		Game.get_instance().show_win_screen()
