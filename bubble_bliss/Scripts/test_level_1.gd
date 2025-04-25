extends Level


func _ready() -> void:
	
	next_level = preload("res://Scenes/levels/test_level_2.tscn").instantiate()
