extends Area2D

class_name Goal


func _ready() -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	
	if not _body.is_in_group("Bubbles"):
		return
	
	if Game.get_instance().bubbles.dead:
		return
	
	var game:Game = Game.get_instance()
	var next_level:Level = game.level.next_level
	
	if next_level == null:
		Game.get_instance().show_win_screen()
		return
	
	game.level.queue_free()
	game.level = next_level
	game.call_deferred("add_child", game.level)
		
