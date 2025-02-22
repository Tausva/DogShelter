extends Node

@onready var audio_player_pool: AudioPlayerPool = $AudioPlayerPool

@export var audio_library: AudioLibrary


func _ready() -> void:
	play_audio("Music", true, "Music")
	play_audio("Ambience", true, "Ambience")


func play_audio(track_name: String, looping: bool = false, bus: String = "SFX") -> void:
	var audio_track = audio_library.get_audio_track(track_name)
	
	if !audio_track:
		pass
	
	var player = _create_playing_audio_stream(audio_track, bus)
	
	if looping:
		player.finished.connect(_on_track_finish.bind(track_name))
	else:
		_create_playing_audio_stream(audio_track, "SFX")


func _create_playing_audio_stream(stream: AudioStream, bus: String = "Master") -> AudioStreamPlayer:
	var audio_stream_player: AudioStreamPlayer = audio_player_pool.get_audio_stream_player(bus)
	audio_stream_player.stream = stream
	audio_stream_player.play()
	
	return audio_stream_player


func _on_track_finish(track_name: String) -> void:
	play_audio(track_name, true)
