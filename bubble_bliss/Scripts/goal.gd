extends Area2D


func _ready() -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	
	if _body.name == "Bubbles" and not _body.dead:
		Game.get_instance().show_win_screen()
