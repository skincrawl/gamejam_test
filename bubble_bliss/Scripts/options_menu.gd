extends Control


var menu_music_intro:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Intro.mp3")
var menu_music:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")


const MIN_VOLUME:float = -72.0
const MAX_VOLUME:float = 0.0


func _ready() -> void:
	
	# Setting the volume slider to match the volume of the master bus
	var volume:float = clamp(AudioServer.get_bus_volume_db(0), MIN_VOLUME, MAX_VOLUME)
	var volume_ratio:float = (volume - MIN_VOLUME) / MAX_VOLUME
	print("volume: ", volume)
	print("volume_ratio: ", volume_ratio)
	$VBoxContainer/Volume/volume_slider.value = volume_ratio
	
	# Updating the toggle to match the master audio bus mute state
	$VBoxContainer/SoundOnOff.button_pressed = not AudioServer.is_bus_mute(0)
	
	if AudioServer.is_bus_mute(0):
		return
	
	if not Globals.intro_finished:
		
		$music.stream = menu_music_intro
	
	$music.play(Globals.music_spot)


func _on_return_pressed():
	Globals.music_spot = $music.get_playback_position()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_volume_slider_value_changed(_value: float) -> void:
	
	var new_volume:float = lerp(MIN_VOLUME, MAX_VOLUME, _value / 100.0)
	AudioServer.set_bus_volume_db(0, new_volume)


func _on_sound_on_off_toggled(_toggled_on: bool) -> void:
	
	var sound_muted:bool = not _toggled_on
	
	# Muting the master audio bus depending on the new state
	AudioServer.set_bus_mute(0, sound_muted)
	
	if sound_muted:
		Globals.music_spot = $music.get_playback_position()
		$music.stop()
	else:
		$music.play(Globals.music_spot)
