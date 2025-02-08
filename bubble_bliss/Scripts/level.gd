extends Node2D

class_name Level


var dart_packed:PackedScene = preload("res://Scenes/dart.tscn")

@onready var spawn_pos:Marker2D = $level_objects/spawn_pos

const LOSE_TIME:float = 3.0

var collected_bananas:int = 0


func _ready() -> void:
	
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


func _process(_delta:float) -> void:
	
	var threshold:float = 30.0
	var milliseconds:float = _delta * 1000.0
	if milliseconds > threshold:
		print("milliseconds: ", str(milliseconds) + " ms" )
	
	$banana_mouse.position = get_global_mouse_position()


func spawn_dart(_dart_gun:DartGun) -> void:
	
	var dart:Dart = dart_packed.instantiate()
	dart.shooting_cannon = _dart_gun
	dart.global_transform = _dart_gun.global_transform
	dart.global_position = _dart_gun.get_node("dart_spawn").global_position
	
	dart.velocity = Vector2.RIGHT * dart.speed
	dart.velocity = dart.velocity.rotated(dart.rotation)
	
	add_child(dart)


func banana_collected(_banana:Banana) -> void:
	
	# Moving the banana to the GUI element
	# _banana.destination = $bananas.
	
	collected_bananas += 1
	$GUI/bananas_label.text = "bananas: " + str(collected_bananas)
