extends CanvasLayer


@onready var fps_label:Label = $MarginContainer/fps_label
@onready var fps_gradient:GradientTexture1D = preload("res://Resources/fps_gradient.tres")

const GOOD_FPS:int = 60
const MID_FPS:int = 30

var debug_on:bool = true


func _ready() -> void:
	_debug_on(debug_on)


func _unhandled_input(_event:InputEvent) -> void:
	if _event is InputEventKey and Input.is_action_just_pressed("debugging"):
		debug_on = not debug_on
		_debug_on(debug_on)


func _physics_process(_delta: float) -> void:
	
	var fps:int = Engine.get_frames_per_second()
	fps_label.text = str(int(fps)) + " fps"
	
	var fps_offset:float = fps / GOOD_FPS
	
	fps_label.add_theme_color_override("font_color", fps_gradient.gradient.sample(fps_offset))


func _debug_on(_on:bool) -> void:
	
	fps_label.visible = _on
