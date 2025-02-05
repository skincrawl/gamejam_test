extends Node2D

class_name Level


var dart_packed:PackedScene = preload("res://Scenes/dart.tscn")

@onready var spawn_pos:Marker2D = $level_objects/spawn_pos

const LOSE_TIME:float = 3.0

var screen_size:Vector2
var collected_bananas:int = 0

var game_music:AudioStream = preload("res://Assets/Audio/Music/PeliTheme.mp3")


func _ready() -> void:
	
	get_viewport().size_changed.connect(viewport_size_changed)
	
	screen_size = DisplayServer.window_get_size()
	
	Globals.level = self
	Globals.bubbles = $Bubbles
	
	# Hiding the mouse
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	$GUI/bananas_label.show()
	
	if Globals.first_play:
		Globals.checkpoint_manager = CheckpointManager.new()
		Globals.checkpoint_manager.last_location = $level_objects/spawn_pos.global_position
		Globals.first_play = false
	spawn_pos.global_position = Globals.checkpoint_manager.last_location
	$Bubbles.global_position = $level_objects/spawn_pos.global_position
	
	if AudioServer.is_bus_mute(0):
		$music.stop()
		return
		
	$music.play(Globals.music_spot)


func _process(_delta:float) -> void:
	
	# var screen_in_game:Rect2 = get_viewport().get_visible_rect()
	# mouse_pos = get_global_mouse_position()
	# var mouse_pos:Vector2 = get_viewport().get_mouse_position()
	
	# print("screen in game: ", screen_in_game)
	# print("mouse_pos: ", Globals.mouse_pos)
	
	# print("desired resolution: ", desired_resolution)
	# print("window size: ", window_size)
	# print("viewport scale: ", viewport_scale)
	# var window_size:Vector2 = DisplayServer.window_get_size()
	
	$banana_mouse.position = get_global_mouse_position()
	# $banana_mouse.global_position = $Bubbles.get_viewport_rect().position + Globals.mouse_pos - 0.5 * window_size
	# $banana_mouse.global_position = $Bubbles.position + Globals.mouse_pos - 0.5 * screen_size


func lose() -> void:
	
	Globals.music_spot = $music.get_playback_position()
	
	# var callable:Callable = get_tree().reload_current_scene
	# get_tree().process_frame.connect(callable, CONNECT_ONE_SHOT)
	get_tree().reload_current_scene.call_deferred()


func spawn_dart(_dart_gun:DartGun) -> void:
	var dart:Dart = dart_packed.instantiate()
	dart.shooting_cannon = _dart_gun
	dart.global_transform = _dart_gun.global_transform
	dart.global_position = _dart_gun.get_node("dart_spawn").global_position
	# print("_dart_gun.rotation: ", _dart_gun.rotation)
	dart.velocity = Vector2.RIGHT * dart.speed
	dart.velocity = dart.velocity.rotated(dart.rotation)
	
	add_child(dart)


func banana_collected(_banana:Banana) -> void:
	
	# _banana.destination = $bananas.
	collected_bananas += 1
	$GUI/bananas_label.text = "bananas: " + str(collected_bananas)


func viewport_size_changed() -> void:
	
	# print("screen size changed")
	screen_size = DisplayServer.window_get_size()
