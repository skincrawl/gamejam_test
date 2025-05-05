extends Node2D


@onready var valikko_apina:AnimatedSprite2D = $ApinaBubbles

var spin_speed:float = 5.0

var mouse_pointing:bool = false
var screaming:bool = false

func _unhandled_input(_event:InputEvent) -> void:
	if not screaming and mouse_pointing and Input.is_action_just_pressed("blowing"):
		$monkey_scream.play()
		$ApinaBubbles.play("whoa!")
		screaming = true


func _process(_delta:float) -> void:
	
	valikko_apina.rotation += deg_to_rad(spin_speed) * _delta


func _on_area_2d_mouse_entered() -> void:
	mouse_pointing = true


func _on_area_2d_mouse_exited() -> void:
	mouse_pointing = false


func _on_apina_bubbles_animation_finished() -> void:
	$ApinaBubbles.play("default")
	screaming = false
