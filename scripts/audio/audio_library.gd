class_name AudioLibrary extends Resource

@export var audio_tracks: Array[AudioTrack]


func get_audio_track(title: String) -> AudioStream:
	var index = audio_tracks.filter(func(track): return track.title == title)[0]
	
	if !index:
		return null
	else:
		return index.stream
