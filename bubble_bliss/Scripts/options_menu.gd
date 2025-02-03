extends Control


const MIN_VOLUME:float = -32.0
const MAX_VOLUME:float = -5.0


func _ready() -> void:
	$VBoxContainer/Volume/volume_slider.value = 70
	
	if not Globals.sound_on:
		return
	
	$music.volume_db = Globals.sound_volume
	$music.stream = Globals.audio_stream
	$music.play(Globals.music_spot)


func _on_return_pressed():
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_volume_slider_value_changed(_value: float) -> void:
	Globals.sound_volume = lerp(MIN_VOLUME, MAX_VOLUME, _value / 100.0)
	$music.volume_db = Globals.sound_volume


func _on_sound_on_off_pressed() -> void:
	var sound_on:bool = $VBoxContainer/SoundOnOff.button_pressed
	$music.playing = sound_on
	Globals.sound_on = sound_on
