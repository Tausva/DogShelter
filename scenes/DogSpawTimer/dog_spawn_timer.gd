extends Node2D

@export var spawn_positions := [
	Vector2(200, 350),
	Vector2(250, 350),
	Vector2(300, 350),
	Vector2(350, 350),
	Vector2(400, 350)
]
var dragging_positions := {}


func _on_spawn_timer_timeout() -> void:
	var dog_scene: PackedScene = load("res://scenes/dog/dog.tscn")
	var dog = dog_scene.instantiate()
	
	var occupied_positions := []
	for child in $Dogs.get_children():
		if child is Node2D:
			occupied_positions.append(child.position)
	
	var free_positions = spawn_positions.filter(func(pos): 
		return not is_position_occupied(pos))
	
	var drag_component = dog.get_node("DraggableComponent") as DraggableComponent
	
	drag_component.connect("dragging_started", Callable(self, "_on_dragging_started"))
	if free_positions.size() > 0:
		dog.position = free_positions[0]
		$Dogs.add_child(dog)
	else:
		print("no free space")


func is_position_occupied(position: Vector2) -> bool:
	if position in dragging_positions.values():
		return true
	for child in $Dogs.get_children():
		if child is Node2D and child.position.distance_to(position) < 10:
			return true
	return false


func _on_dragging_started(is_dragging: bool, dragged_dog: Node2D):
	if is_dragging:
		if dragged_dog not in dragging_positions:
			dragging_positions[dragged_dog] = dragged_dog.position
	else:
		dragging_positions.erase(dragged_dog)
	
