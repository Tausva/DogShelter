class_name EndScreen extends Node

@onready var score_label: Label = $CanvasLayer/TextureRect/MarginContainer/VBoxContainer/Label3
@onready var highscore_label: Label = $CanvasLayer/TextureRect/MarginContainer/VBoxContainer/Label4

@export var press_delay: float = 0.15


func _ready() -> void:
	var score: int = GameManager.get_dogs_saved()
	
	ScoreManager.save_high_score(score)
	var highscore = ScoreManager.get_high_score() as HighScore
	
	score_label.text = "You saved " + str(score) + " dogs!"
	highscore_label.text =  "Highscore: " + str(highscore.score) + " dogs!"


func _on_quit_button_pressed() -> void:
	AudioManager.play_audio("Button")
	var tree = get_tree()
	await tree.create_timer(press_delay).timeout
	tree.change_scene_to_file("res://scenes/game_menu/game_menu.tscn")
