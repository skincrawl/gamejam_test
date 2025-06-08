extends Menu

class_name NarrativeMenu


signal start_level(level_name:String)


func _ready() -> void:
	
	super._ready()


func _on_start_pressed() -> void:
	
	start_level.emit("og_level")
