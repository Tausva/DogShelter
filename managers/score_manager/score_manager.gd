extends Node

var save_path = "user://high_score.dat"


func get_high_score():
	var dictionary = _load()
	if !dictionary:
		return null
	
	var highscore = HighScore.new()
	highscore.date = dictionary.get("date")
	highscore.score = dictionary.get("score")
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
	for i in content.size():
		file.store_line(str(content.keys()[i],":",content.values()[i],"\r").replace(" ","")) 
	
	file.close()


func _load():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var content = {}
		for i in file.get_as_text().count(":"):
			var line = file.get_line()
			var key = line.split(":")[0]
			var value = line.split(":")[1]
			if value.is_valid_integer():
				value = int(value)
			elif value.is_valid_float():
				value = float(value)
			elif value.begins_with("["):
				value = value.trim_prefix("[")
				value = value.trim_suffix("]")
				value = value.split(",")
			content[key] = value
		file.close()
		
		return content
	return null
