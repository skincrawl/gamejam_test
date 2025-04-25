extends Level


func _ready() -> void:
	
	next_level = preload("res://Scenes/levels/og_level.tscn").instantiate()
