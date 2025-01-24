extends Node2D



func _ready() -> void:
	print("hello world!")
	queue_redraw()


func _draw() -> void:
	draw_circle(Vector2(150, 150), 50, Color.RED, true)
