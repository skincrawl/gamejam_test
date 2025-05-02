extends Menu

class_name LevelSeceltMenu


signal level_selected(level_name:String)


func _ready() -> void:
	
	super._ready()


func _on_level_selected(level_name: String) -> void:
	
	level_selected.emit(level_name)
