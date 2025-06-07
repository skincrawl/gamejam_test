extends Menu

class_name LoadingScreen


var screen_size:Vector2i

@export var next_scene_path:String

@onready var progress_bar:ProgressBar = $MarginContainer/VBoxContainer/ProgressBar

var next_level_name:String = ""

var is_loading:bool = false

signal scene_loaded(_scene:PackedScene)


func _ready() -> void:
	
	screen_size = DisplayServer.window_get_size()
	get_viewport().size_changed.connect(_screen_size_changed)
	
	progress_bar.custom_minimum_size.x = screen_size.x / 5.0


func _physics_process(_delta:float) -> void:
	
	if not is_loading:
		return
	
	var progress = []
	var status = ResourceLoader.load_threaded_get_status(next_scene_path, progress)
	if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		progress_bar.value = progress[0] * 100.0
	elif status == ResourceLoader.THREAD_LOAD_LOADED:
		progress_bar.value = 100.0
		var packed_scene:PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
		await get_tree().create_timer(0.4).timeout
		scene_loaded.emit(packed_scene)
		hide()
	elif status == ResourceLoader.THREAD_LOAD_FAILED:
		push_error("Loading the game failed. D*rn, what do you even do then...?")
		is_loading = false


func start_loading_threaded() -> void:
	
	# print("loading scene: %s" %next_scene_path)
	
	var err:Error = ResourceLoader.load_threaded_request(next_scene_path)
	if not err == OK:
		push_error("Failed to request threaded load: %s" %next_scene_path)
		return
	is_loading = true


func _on_visibility_changed() -> void:
	
	if not visible:
		return
	start_loading_threaded()


func _screen_size_changed() -> void:
	print("screen size changed")
