extends Node2D

class_name Game

var level_packed:PackedScene = preload("res://Scenes/level.tscn")
var bubbles_packed:PackedScene = preload("res://Scenes/bubbles.tscn")

const MENU_MUSIC_VOLUME:float = -12.0
const LEVEL_MUSIC_VOLUME:float = -15.0

var number:int = 20000

var menu_music:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")
var menu_music_intro:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Intro.mp3")
var level_music:AudioStream = preload("res://Assets/Audio/Music/PeliTheme.mp3")

@onready var main_menu:Control = $Menus/MainMenu
@onready var settings_screen:Control = $Menus/Settings
@onready var about_us_screen:Control = $Menus/AboutUs
@onready var how_to_screen:Control = $Menus/HowToPlay
@onready var narrative_screen:Control = $Menus/narrative_screen
@onready var win_screen:Control = $Menus/win_screen
@onready var credits_screen:Control = $Menus/Credits


static var _instance:Game

var level:Level
var bubbles:Bubbles


static func get_instance() -> Game:
	return _instance


func _ready() -> void:
	
	_instance = self


func lose():
	
	bubbles.reset()
	bubbles.global_position = level.checkpoint_manager.last_location


# Shows the main menu
func show_main_menu() -> void:
	
	$Menus.show()
	main_menu.show()
	main_menu.process_mode = Node.PROCESS_MODE_INHERIT
	
	if $music_player.stream == level_music:
		$music_player.stream = menu_music_intro
		$music_player.play()


# Shows the narrative screen, before playing the game
func start_pressed() -> void:
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	
	narrative_screen.show()
	narrative_screen.mouse_filter = Control.MOUSE_FILTER_STOP


func start_level() -> void:
	$Menus.hide()
	narrative_screen.hide()
	narrative_screen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	if not level == null:
		level.queue_free()
	
	level = level_packed.instantiate()
	add_child(level)
	$music_player.stream = level_music
	$music_player.volume_db = LEVEL_MUSIC_VOLUME
	$music_player.play()


# Shows the settings menu
func show_settings_menu() -> void:
	
	$Menus.show()
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	settings_screen.show()
	about_us_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	
	if $music_player.stream == level_music:
		$music_player.stream = menu_music_intro
		$music_player.play()


# Shows the about us screen
func show_about_us_screen() -> void:
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	about_us_screen.show()
	about_us_screen.mouse_filter = Control.MOUSE_FILTER_STOP


# Shows the about us screen
func show_how_to_screen() -> void:
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	how_to_screen.show()
	how_to_screen.mouse_filter = Control.MOUSE_FILTER_STOP


# Shows the about us screen
func show_win_screen() -> void:
	
	$Menus.show()
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	win_screen.show()
	win_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	
	level.queue_free()
	
	$music_player.stream = menu_music_intro
	$music_player.play()


# Shows the about us screen
func show_credits_screen() -> void:
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	credits_screen.show()
	credits_screen.mouse_filter = Control.MOUSE_FILTER_STOP


func music_on(_on:bool) -> void:
	var paused:bool = not _on
	print("paused: ", paused)
	$music_player.stream_paused = paused


func _on_music_player_finished() -> void:
	if $music_player.stream == menu_music_intro:
		$music_player.stream = menu_music
		$music_player.play()
