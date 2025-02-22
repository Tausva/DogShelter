extends Node

var save_path = "user://high_score.dat"


func get_high_score():
	var highscore = _load()
	if !highscore:
		return null
	
	return highscore


func save_high_score(score: int):
	var old_highscore = _load() as HighScore
	
	if !old_highscore or old_highscore.score < score:
		var highscore: Dictionary
		highscore["date"] = Time.get_datetime_string_from_system()
		highscore["score"] = score
		
		_save(highscore)


func _save(content: Dictionary):
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(content)
	file.store_line(json_string)
	
	file.close()


func _load():
	var highscore = HighScore.new()
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	if not file:
		return
	if file == null:
		return
	if FileAccess.file_exists(save_path):
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				highscore.date = current_line["date"]
				highscore.score = current_line["score"]
		file.close()
		
		return highscore
	return null
