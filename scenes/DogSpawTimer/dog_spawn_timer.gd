extends Node2D

var spawn_offset := 50
@export var start_x := 150
@export var start_y := 150

func _on_spawn_timer_timeout() -> void:
	var dog_scene: PackedScene = load("res://scenes/dog/dog.tscn")
	var dog = dog_scene.instantiate()
	var rightmost_x = start_x
	for child in $Dogs.get_children():
		if child is Node2D:
			rightmost_x = max(rightmost_x, child.position.x)
	
	dog.position = Vector2(rightmost_x + spawn_offset, 150)
	$Dogs.add_child(dog)
