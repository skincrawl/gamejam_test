extends Control


var screen_size:Vector2i

var game_path:String = "res://Scenes/game.tscn"


func _ready() -> void:
	
	screen_size = DisplayServer.window_get_size()
	get_viewport().size_changed.connect(_screen_size_changed)
	
	_start_loading_game()
	


func _start_loading_game() -> void:
	
	var err:Error = ResourceLoader.load_threaded_request(game_path)
	if err != OK:
		push_error("Failed to load game from %s!" %game_path)
	await _check_load_complete()


func _check_load_complete() -> void:
	while true:
		var status:ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(game_path)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			var packed_game:PackedScene = ResourceLoader.load_threaded_get(game_path)
			get_tree().change_scene_to_packed(packed_game)
			break
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Loading the game failed. D*rn, what do you even do then...?")
			break
		await get_tree().process_frame


func _screen_size_changed() -> void:
	
	screen_size = DisplayServer.window_get_size()
