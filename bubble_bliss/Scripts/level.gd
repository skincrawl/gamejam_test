extends Node2D

class_name Level


var level_music:AudioStream = preload("res://Assets/Audio/Music/PeliTheme.mp3")
var dart_packed:PackedScene = preload("res://Scenes/level_objects/dart.tscn")

@onready var music_player:AudioStreamPlayer = Game.get_instance().music_player
@onready var banana_mouse:BananaMouse = Game.get_instance().banana_mouse
@onready var spawn_pos:Marker2D = $level_objects/spawn_pos

@onready var level_objects:Node2D = $level_objects
@onready var goal:Goal = $level_objects/goal

const LEVEL_MUSIC_VOLUME:float = -15.0
const LOSE_TIME:float = 3.0

var game:Game
var checkpoint_manager:CheckpointManager

var level_name:String

var bananas_amount:int = 0
var collected_bananas:int = 0

var next_level:Level

signal shoot
signal level_defeated


func _ready() -> void:
	
	game = Game.get_instance()
	game.current_level = self
	
	goal.level_defeated.connect(_level_defeated)
	
	# process_mode = Node.PROCESS_MODE_PAUSABLE
	
	music_player.volume_db = LEVEL_MUSIC_VOLUME
	music_player.stream = level_music
	music_player.play()
	
	var spawn_position:Vector2 = $level_objects/spawn_pos.global_position
	checkpoint_manager = CheckpointManager.new()
	checkpoint_manager.last_location = spawn_position
	
	# Hiding the mouse
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	var bubbles:Bubbles = game.bubbles
	bubbles.global_position = spawn_position
	bubbles.linear_velocity = Vector2.ZERO
	bubbles.reset()
	
	Game.get_instance().level_GUI.bananas_label.text = "bananas: " + str(collected_bananas)
	
	if has_node("dart_guns") and get_node("dart_guns").get_child_count() > 0:
		var shoot_timer:Timer = Timer.new()
		shoot_timer.wait_time = 1.0
		add_child(shoot_timer)
		shoot_timer.timeout.connect(_on_shoot_timer_timeout)
		shoot_timer.start()


func checkpoint_reached(_global_position:Vector2) -> void:
	
	checkpoint_manager.last_location = _global_position


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
	
	shoot.emit()


func _level_defeated() -> void:
	
	level_defeated.emit()
