class_name Shelter extends Node2D

@onready var room_container: Node2D = $RoomContainer

@export var room_x_offset: float = 118
@export var room_y_offset: float = 192


func _ready() -> void:
	add_room(Vector2i(0,0))
	add_room(Vector2i(1,0))
	add_room(Vector2i(0,1))
	add_room(Vector2i(1,1))


func add_room(index: Vector2i) -> void:
	var room_scene: PackedScene
	if index.y == 0:
		room_scene = preload("res://scenes/room/room_south.tscn")
	elif index.y == 1:
		room_scene = preload("res://scenes/room/room_north.tscn")
	
	var room_instance: Room = room_scene.instantiate()
	
	room_container.add_child(room_instance)
	room_instance.position = Vector2(-room_x_offset * index.x, room_y_offset * index.y)
