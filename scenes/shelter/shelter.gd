class_name Shelter extends Node2D

@onready var room_container: Node2D = $RoomContainer

@export var room_x_offset: float = 118
@export var room_y_offset: float = 192
@export var room_spots: Array[RoomPosition]


func _ready() -> void:
	for room in room_spots:
		add_room(room)


func add_room(position: RoomPosition) -> void:
	var room_scene: PackedScene
	if position.direction == position.Direction.SOUTH:
		room_scene = preload("res://scenes/room/room_south.tscn")
	elif position.direction == position.Direction.NORTH:
		room_scene = preload("res://scenes/room/room_north.tscn")
	
	var room_instance: Room = room_scene.instantiate()
	
	room_container.add_child(room_instance)
	room_instance.position = position.coordinates
	room_instance.create_room(position.has_window)
