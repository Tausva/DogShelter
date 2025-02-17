class_name Room extends Node2D

@onready var droppable_area: Area2D = $DroppableArea
@onready var ground_layer: TileMapLayer = $TileMap/GroundLayer
@onready var wall_layer: TileMapLayer = $TileMap/WallLayer
@onready var window: Sprite2D = $Window

@export var ground_presets : Array[PackedScene]
@export var wall_presets: Array[PackedScene]


func get_room_area() -> Area2D:
	return droppable_area


func create_room(has_window: bool) -> void:
	var ground_index = randi_range(0, ground_presets.size() - 1)
	var ground_instance = ground_presets[ground_index].instantiate()
	ground_layer.get_parent().add_child(ground_instance)
	ground_instance.position = ground_layer.position
	ground_instance.scale = ground_layer.scale
	ground_layer.queue_free()
	
	var wall_index = randi_range(0, wall_presets.size() - 1)
	var wall_instance = wall_presets[wall_index].instantiate()
	wall_layer.get_parent().add_child(wall_instance)
	wall_instance.position = wall_layer.position
	wall_instance.scale = wall_layer.scale
	wall_layer.queue_free()
	
	window.visible = has_window
