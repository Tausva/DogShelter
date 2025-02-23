class_name AudioPlayerPool extends Node

var ready_audio_players: Array[AudioStreamPlayer]


func get_audio_stream_player(bus: String = "Master") -> AudioStreamPlayer:
	var player: AudioStreamPlayer = ready_audio_players.pop_front()
	
	if !player:
		player = AudioStreamPlayer.new()
		player.finished.connect(_on_player_finished.bind(player))
		player.bus = bus
		add_child(player)
	
	return player


func _on_player_finished(stream_player: AudioStreamPlayer) -> void:
	ready_audio_players.append(stream_player)
	var connections = stream_player.finished.get_connections()
	for connection in connections:
		stream_player.finished.disconnect(connection["callable"])
