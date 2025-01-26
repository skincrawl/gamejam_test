extends Node

var audio_stream:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")

var level:Level
var bubbles:Bubbles

var sound_volume:float = 1.0
var sound_on:bool = true
var music_spot:float
