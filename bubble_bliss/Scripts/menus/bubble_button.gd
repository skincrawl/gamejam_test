extends Control



@export var button_action:String
@export var label:Label

@onready var original_scale:Vector2 = label.scale

var mouse_inside:bool = false
var pressing:bool = false


func _ready() -> void:
	
	$Label.text = button_action.capitalize()
	# var random_frame:int = randi_range(1, 5)
	# $swirl_back.frame = random_frame
	# $swirl_front.frame = random_frame


func _unhandled_input(_event: InputEvent) -> void:
	
	if not mouse_inside:
		if Input.is_action_just_released("blowing"):
			pressing = false
		return
	
	if Input.is_action_just_pressed("blowing"):
		pressing = true
	if pressing and Input.is_action_just_released("blowing"):
		pressing = false
		_button_pressed()


func _button_pressed() -> void:
	
	var game:Game = Game.get_instance()
	
	var menu:MainMenu = game.main_menu
	menu.button_was_pressed(button_action)


func _on_area_2d_mouse_entered() -> void:
	
	mouse_inside = true
	
	# var original_scale:Vector2 = label.scale
	label.scale = original_scale * 1.2
	var pink_hue:Color = modulate
	pink_hue.g = 0.7
	var yellow_hue:Color = modulate
	yellow_hue.b = 0.2
	var green_hue:Color = modulate
	green_hue.b = 0.2
	green_hue.r = 0.2
	
	# if $swirl_back.frame = 
	# $bubble_bg.modulate = pink_hue
	# $swirl_back.modulate = pink_hue
	# $swirl_front.modulate = yellow_hue
	$Sprite2D.modulate = pink_hue


func _on_area_2d_mouse_exited() -> void:
	
	mouse_inside = false
	
	label.scale = original_scale
	var regular_hue:Color = Color.WHITE
	
	# $bubble_bg.modulate = regular_hue
	# $swirl_back.modulate = regular_hue
	# $swirl_front.modulate = regular_hue
	$Sprite2D.modulate = regular_hue
