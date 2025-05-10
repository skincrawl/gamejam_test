extends Menu

class_name LoadingScreen


@export var next_scene_path:String


func _ready() -> void:
	
	pass


func start_loading_threaded() -> void:
	
	var err:Error = ResourceLoader.load_threaded_request(next_scene_path)
	if not err == OK:
		push_error("Failed to request threaded load: %s" %next_scene_path)
		return
	await _check_load_complete()


func _check_load_complete() -> void:
	while true:
		var status = ResourceLoader.load_threaded_get_status(next_scene_path)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			var packed_scene:PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
			get_tree().change_scene_to_packed(packed_scene)
			break
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Loading the game failed. D*rn, what do you even do then...?")
			break
		await get_tree().process_frame


func _on_visibility_changed() -> void:
	
	if not visible:
		return
	start_loading_threaded()
