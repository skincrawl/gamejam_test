extends Node2D

class_name Game

var bubbles_packed:PackedScene = preload("res://Scenes/bubbles.tscn")

const MENU_MUSIC_VOLUME:float = -12.0
const LEVEL_MUSIC_VOLUME:float = -15.0

var menu_music:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")
var menu_music_intro:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Intro.mp3")
var level_music:AudioStream = preload("res://Assets/Audio/Music/PeliTheme.mp3")

@onready var bubbles:Bubbles = $bubbles
@onready var main_menu:Control = $Menus/MainMenu
@onready var settings_screen:Control = $Menus/Settings
@onready var level_select_screen:Control = $Menus/level_select_screen
@onready var about_us_screen:Control = $Menus/AboutUs
@onready var how_to_screen:Control = $Menus/HowToPlay
@onready var narrative_screen:Control = $Menus/narrative_screen
@onready var win_screen:Control = $Menus/win_screen
@onready var credits_screen:Control = $Menus/Credits

@onready var paused_label:Label = $Menus/Pause/paused_label

@onready var level_GUI:CanvasLayer = $level_GUI
@onready var banana_mouse:BananaMouse = $banana_mouse


static var _instance:Game

var levels_path:String = "res://Scenes/levels"

var current_level:Level

var in_level:bool = false


static func get_instance() -> Game:
	return _instance


func _init() -> void:
	_instance = self


func _ready() -> void:
	
	show_main_menu()
	
	$Menus/narrative_screen.return_pressed.connect(show_main_menu)
	$Menus/Settings.return_pressed.connect(show_main_menu)
	$Menus/AboutUs.return_pressed.connect(show_main_menu)


func _process(_delta:float) -> void:
	pass


func lose():
	
	bubbles.reset()
	bubbles.global_position = current_level.checkpoint_manager.last_location


# Shows the main menu
func show_main_menu() -> void:
	
	bubbles.hide()
	bubbles.process_mode = Node.PROCESS_MODE_DISABLED
	
	main_menu.show()
	main_menu.process_mode = Node.PROCESS_MODE_INHERIT
	main_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	level_GUI.hide()
	banana_mouse.hide()
	banana_mouse.process_mode = Node.PROCESS_MODE_DISABLED
	
	if $music_player.stream == level_music:
		$music_player.stream = menu_music_intro
		$music_player.play()


# Shows the narrative screen, before playing the game
func start_pressed() -> void:
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	
	narrative_screen.show()
	narrative_screen.mouse_filter = Control.MOUSE_FILTER_STOP


func start_level(_new_level:Level) -> void:
	
	in_level = true
	
	bubbles.show()
	bubbles.process_mode = Node.PROCESS_MODE_PAUSABLE
	bubbles.reset()
	
	narrative_screen.hide()
	narrative_screen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	level_select_screen.hide()
	level_select_screen.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	level_GUI.show()
	banana_mouse.show()
	banana_mouse.process_mode = Node.PROCESS_MODE_INHERIT
	
	if not current_level == null:
		current_level.queue_free()
	
	current_level = _new_level
	add_child(current_level)
	
	$music_player.stream = level_music
	$music_player.volume_db = LEVEL_MUSIC_VOLUME
	$music_player.play()


# Shows the settings menu
func show_settings_menu() -> void:
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	main_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	settings_screen.show()
	settings_screen.process_mode = Node.PROCESS_MODE_INHERIT
	settings_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	
	if $music_player.stream == level_music:
		$music_player.stream = menu_music_intro
		$music_player.play()


# Shows the settings menu
func show_level_select() -> void:
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	
	level_select_screen.show()
	level_select_screen.process_mode = Node.PROCESS_MODE_INHERIT
	
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
	
	in_level = false
	
	banana_mouse.hide()
	banana_mouse.process_mode = Node.PROCESS_MODE_DISABLED
	
	bubbles.hide()
	bubbles.process_mode = Node.PROCESS_MODE_DISABLED
	
	main_menu.hide()
	main_menu.process_mode = Node.PROCESS_MODE_DISABLED
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	win_screen.show()
	win_screen.mouse_filter = Control.MOUSE_FILTER_STOP
	
	current_level.queue_free()
	
	$music_player.stream = menu_music_intro
	$music_player.play()


# Shows the about us screen
func show_credits_screen() -> void:
	
	banana_mouse.hide()
	banana_mouse.process_mode = Node.PROCESS_MODE_DISABLED
	
	credits_screen.show()
	credits_screen.mouse_filter = Control.MOUSE_FILTER_STOP


func music_on(_on:bool) -> void:
	var paused:bool = not _on
	# print("paused: ", paused)
	$music_player.stream_paused = paused


func _on_music_player_finished() -> void:
	if $music_player.stream == menu_music_intro:
		$music_player.stream = menu_music
		$music_player.play()


func _on_main_menu_button_pressed(button_action: String) -> void:
	
	match button_action:
		"start game":
			start_pressed()
		"how to play":
			show_how_to_screen()
		"about us":
			show_about_us_screen()
		"settings":
			show_settings_menu()
		"level select":
			show_level_select()
		"quit":
			get_tree().quit()
		_:
			pass


func _on_narrative_screen_start_level(_level_name:String) -> void:
	
	var level:Level = preload("res://Scenes/levels/og_level.tscn").instantiate()
	start_level(level)


func _on_settings_return_pressed() -> void:
	show_main_menu()
