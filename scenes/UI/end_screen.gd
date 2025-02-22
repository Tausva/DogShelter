class_name EndScreen extends Node

@onready var score_label: Label = $CanvasLayer/TextureRect/MarginContainer/VBoxContainer/Label3
@onready var highscore_label: Label = $CanvasLayer/TextureRect/MarginContainer/VBoxContainer/Label4


func _ready() -> void:
	var score: int = GameManager.get_dogs_saved()
	
	ScoreManager.save_high_score(score)
	var highscore = ScoreManager.get_high_score() as HighScore
	
	score_label.text = "You saved " + str(score) + " dogs!"
	highscore_label.text =  "Highscore: " + str(highscore.score) + " dogs!"
