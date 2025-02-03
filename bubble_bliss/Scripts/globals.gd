extends Node

var audio_stream:AudioStream = preload("res://Assets/Audio/Music/MainMenuTheme_Ilman_Introa.mp3")

var level:Level

var checkpoint_manager:CheckpointManager
var first_play:bool = true

var bubbles:Bubbles

var sound_volume:float = -20.0
var sound_on:bool = true
var music_spot:float
var intro_finished:bool = false
