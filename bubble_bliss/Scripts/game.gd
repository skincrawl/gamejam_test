extends Node2D

class_name Game

var bubbles_packed:PackedScene = preload("res://Scenes/bubbles.tscn")

const MENU_MUSIC_VOLUME:float = -12.0

var menu_music:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")
var menu_music_intro:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Intro.mp3")
# var level_music:AudioStream = preload("res://Assets/Audio/Music/PeliTheme.mp3")

@onready var bubbles:Bubbles = $bubbles
@onready var main_menu:MainMenu = $Menus/MainMenu
@onready var settings_screen:SettingsMenu = $Menus/Settings
@onready var level_select_screen:LevelSelectMenu = $Menus/level_select_screen
@onready var about_us_screen:Menu = $Menus/AboutUs
@onready var how_to_screen:Menu = $Menus/HowToPlay
@onready var narrative_screen:NarrativeMenu = $Menus/narrative_screen
@onready var win_screen:Menu = $Menus/win_screen
@onready var credits_screen:Menu = $Menus/Credits
@onready var loading_screen:LoadingScreen = $Menus/LoadingScreen
@onready var pause_screen:PauseScreen = $Menus/PauseMenu

@onready var level_GUI:CanvasLayer = $level_GUI
@onready var banana_mouse:BananaMouse = $banana_mouse

@onready var music_player:AudioStreamPlayer = $music_player


static var _instance:Game

var menus:Dictionary = {}
var current_menu:Menu = main_menu

var levels_path:String = "res://Scenes/levels/"

var current_level:Level

var in_level:bool = false


static func get_instance() -> Game:
	return _instance


func _init() -> void:
	_instance = self


func _ready() -> void:
	
	_setup_menus()
	


func _setup_menus() -> void:
	
	menus["main"] = main_menu
	menus["narrative"] = narrative_screen
	menus["settings"] = settings_screen
	menus["about_us"] = about_us_screen
	menus["how_to_play"] = how_to_screen
	menus["win_screen"] = win_screen
	menus["credits_screen"] = credits_screen
	menus["level_select"] = level_select_screen
	menus["loading_screen"] = loading_screen
	menus["pause_screen"] = pause_screen
	
	var function:Callable = show_menu
	function.bind("main")
	
	narrative_screen.return_pressed.connect(function)
	settings_screen.return_pressed.connect(function)
	about_us_screen.return_pressed.connect(function)
	how_to_screen.return_pressed.connect(function)
	win_screen.return_pressed.connect(function)
	credits_screen.return_pressed.connect(function)
	level_select_screen.return_pressed.connect(function)
	pause_screen.return_pressed.connect(function)
	
	show_menu("main")


func lose():
	
	bubbles.reset()
	bubbles.global_position = current_level.checkpoint_manager.last_location


func hide_menu(_menu_name:String) -> void:
	
	current_menu.hide()
	current_menu = null
	pass


func show_menu(_menu_name:String) -> void:
	
	# print("showing menu: ", _menu_name)
	
	# banana_mouse.process_mode = Node.PROCESS_MODE_DISABLED
	# Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if not current_menu == null:
		current_menu.hide()
		current_menu.mouse_filter = Control.MOUSE_FILTER_IGNORE
		current_menu.process_mode = Node.PROCESS_MODE_DISABLED
	
	current_menu = menus[_menu_name]
	current_menu.show()
	current_menu.mouse_filter = Control.MOUSE_FILTER_PASS
	current_menu.process_mode = Node.PROCESS_MODE_INHERIT
	
	if _menu_name == "loading_screen":
		$Menus/LoadingScreen.show()


func start_level(level_name:String) -> void:
	
	var full_path:String = levels_path + level_name + ".tscn"
	
	if not ResourceLoader.exists(full_path):
		push_error("failed to load level: ", level_name)
		return
	
	loading_screen.next_scene_path = full_path
	loading_screen.next_level_name = level_name
	
	show_menu("loading_screen")


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
			show_menu("narrative")
		"how to play":
			show_menu("how_to_play")
		"about us":
			show_menu("about_us")
		"settings":
			show_menu("settings")
		"level select":
			show_menu("level_select")
		"quit":
			get_tree().quit()
		_:
			pass


func _on_no_longer_in_level() -> void:
	
	$music_player.stream = menu_music_intro
	$music_player.play()
	
	level_GUI.hide()
	banana_mouse.hide()
	banana_mouse.process_mode = Node.PROCESS_MODE_DISABLED
	bubbles.hide()
	bubbles.process_mode = Node.PROCESS_MODE_DISABLED
	
	in_level = false
	current_level.queue_free()
	current_level = null


func _on_scene_loaded(_scene: PackedScene) -> void:
	
	if not current_level == null:
		current_level.queue_free()
	current_level = _scene.instantiate()
	
	current_level.level_name = loading_screen.next_level_name
	
	in_level = true
	
	bubbles.show()
	bubbles.process_mode = Node.PROCESS_MODE_PAUSABLE
	
	level_GUI.show()
	banana_mouse.show()
	banana_mouse.process_mode = Node.PROCESS_MODE_PAUSABLE
	
	add_child(current_level)
