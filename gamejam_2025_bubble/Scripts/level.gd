extends Node2D

class_name Level


const LOSE_TIME:float = 3.0

var screen_size:Vector2
var collected_bananas:int = 0

func _ready() -> void:
	
	get_viewport().size_changed.connect(viewport_size_changed)
	
	screen_size = DisplayServer.window_get_size()
	
	Globals.level = self
	Globals.bubbles = $Bubbles
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	$GUI/bananas_label.show()
	$GUI/lose_text.hide()
	$GUI/lose_bg.hide()
	$GUI/lose_bg.size = DisplayServer.window_get_size()
	
	$Bubbles.position = $level_objects/spawn_pos.position


func _process(_delta:float) -> void:
	
	var screen_in_game:Rect2 = get_viewport().get_visible_rect()
	var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	
	# print("screen in game: ", screen_in_game)
	# print("mouse_pos: ", mouse_pos)
	
	$banana_mouse.global_position = mouse_pos + $Bubbles.position - 0.5 * screen_in_game.size


func lose() -> void:
	
	$Bubbles.set_deferred("freeze", true)
	$Bubbles.death()
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$GUI/lose_text.show()
	$GUI/lose_bg.show()
	$GUI/bananas_label.hide()
	
	await get_tree().create_timer(LOSE_TIME).timeout
	get_tree().reload_current_scene()


func banana_collected(_banana:Banana) -> void:
	
	# _banana.destination = $bananas.
	collected_bananas += 1
	$GUI/bananas_label.text = "bananas: " + str(collected_bananas)


func viewport_size_changed() -> void:
	
	print("screen size changed")
	screen_size = DisplayServer.window_get_size()
