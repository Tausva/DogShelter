extends Node2D

@export var press_delay: float = 0.1

@onready var play_button = $PlayButton
@onready var quit_button = $QuitButton

var tree = get_tree()

func _ready() -> void:
	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)


func _on_play_button_pressed() -> void:
	var tree = get_tree()
	await tree.create_timer(press_delay).timeout
	tree.change_scene_to_file("res://scenes/game_scene/game_scene.tscn")


func _on_quit_button_pressed() -> void:
	var tree = get_tree()
	await tree.create_timer(press_delay).timeout
	tree.quit()
