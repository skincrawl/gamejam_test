extends Node2D

class_name Level


@onready var banana_mouse:BananaMouse = Game.get_instance().banana_mouse
@onready var spawn_pos:Marker2D = $level_objects/spawn_pos

@onready var level_objects:Node2D = $level_objects

const LOSE_TIME:float = 3.0


var game:Game
var checkpoint_manager:CheckpointManager

var dart_packed:PackedScene = preload("res://Scenes/dart.tscn")

var bananas_amount:int = 0
var collected_bananas:int = 0

var next_level:Level

signal shoot


func _ready() -> void:
	
	game = Game.get_instance()
	game.current_level = self
	
	process_mode = Node.PROCESS_MODE_PAUSABLE
	
	checkpoint_manager = CheckpointManager.new()
	
	# Hiding the mouse
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	banana_mouse.process_mode = Node.PROCESS_MODE_INHERIT
	
	var bubbles:Bubbles = game.bubbles
	bubbles.global_position = $level_objects/spawn_pos.global_position
	bubbles.linear_velocity = Vector2.ZERO
	
	Game.get_instance().level_GUI.bananas_label.text = "bananas: " + str(collected_bananas)


func _process(_delta:float) -> void:
	
	banana_mouse.position = get_global_mouse_position()


func checkpoint_reached(_global_position:Vector2) -> void:
	
	Game.get_instance().current_level.checkpoint_manager.last_location = _global_position


func spawn_dart(_dart_gun:DartGun) -> void:
	
	var dart:Dart = dart_packed.instantiate()
	dart.shooting_cannon = _dart_gun
	dart.global_transform = _dart_gun.global_transform
	dart.global_position = _dart_gun.get_node("dart_spawn").global_position
	
	dart.velocity = Vector2.RIGHT * dart.speed
	dart.velocity = dart.velocity.rotated(dart.rotation)
	
	if not level_objects.has_node("darts"):
		var darts:Node2D = Node2D.new()
		darts.name = "darts"
		level_objects.add_child(darts)
	
	level_objects.get_node("darts").add_child(dart)


func banana_collected(_banana:Banana) -> void:
	
	# Moving the banana to the GUI element
	# _banana.destination = $bananas.
	
	collected_bananas += 1
	Game.get_instance().level_GUI.bananas_label.text = "bananas: " + str(collected_bananas)


func _on_shoot_timer_timeout() -> void:
	print("shoot timer from test level 1")
	shoot.emit()
