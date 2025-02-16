class_name Room extends Node2D

@onready var droppable_area: Area2D = $DroppableArea


func _ready() -> void:
	pass


func get_room_area() -> Area2D:
	return droppable_area
