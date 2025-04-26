extends Control


const MIN_VOLUME:float = -30.0
const MAX_VOLUME:float = 0.0


func _ready() -> void:
	
	# Setting the volume slider to match the volume of the master bus
	var volume:float = clamp(AudioServer.get_bus_volume_db(0), MIN_VOLUME, MAX_VOLUME)
	var volume_ratio:float = (volume - MIN_VOLUME) / (MAX_VOLUME - MIN_VOLUME)
	
	# print("volume: ", volume)
	# print("volume_ratio: ", volume_ratio)
	$VBoxContainer/Volume/volume_slider.value = volume_ratio * 100.0
	
	# Updating the toggle to match the master audio bus mute state
	$VBoxContainer/SoundOnOff.button_pressed = not AudioServer.is_bus_mute(0)


func _on_return_pressed():
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Game.get_instance().show_main_menu()


func _on_volume_slider_value_changed(_value:float) -> void:
	
	# print("volume slider value: ", _value)
	
	var new_volume:float = lerp(MIN_VOLUME, MAX_VOLUME, _value / 100.0)
	AudioServer.set_bus_volume_db(0, new_volume)


func _on_sound_on_off_toggled(_toggled_on:bool) -> void:
	
	var sound_muted:bool = not _toggled_on
	
	# Muting the master audio bus depending on the new state
	AudioServer.set_bus_mute(0, sound_muted)
	
	Game.get_instance().music_on(not sound_muted)
