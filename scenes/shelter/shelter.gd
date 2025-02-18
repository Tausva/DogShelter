class_name Shelter extends Node2D

@onready var room_container: Node2D = $RoomContainer

@export var room_spots: Array[RoomPosition]

var purchase_border_y_offset: float = -30


func _ready() -> void:
	add_room(room_spots.pop_front())
	add_purchase_border(room_spots.pop_front())
	add_purchase_border(room_spots.pop_front())


func add_room(room_position: RoomPosition) -> void:
	var room_scene: PackedScene
	if room_position.direction == room_position.Direction.SOUTH:
		room_scene = preload("res://scenes/room/room_south.tscn")
	elif room_position.direction == room_position.Direction.NORTH:
		room_scene = preload("res://scenes/room/room_north.tscn")
	
	var room_instance: Room = room_scene.instantiate()
	
	room_container.add_child(room_instance)
	room_instance.position = room_position.coordinates
	room_instance.create_room(room_position.has_window)


func add_purchase_border(border_position: RoomPosition) -> PurchaseBorder:
	var purchase_border = preload("res://scenes/purchase_border/purchase_border.tscn")
	var purchase_border_instance: PurchaseBorder = purchase_border.instantiate()
	
	room_container.add_child(purchase_border_instance)
	purchase_border_instance.position = border_position.coordinates
	purchase_border_instance.border_position = border_position
	purchase_border_instance.purchased.connect(_on_room_purchased)
	
	if border_position.direction == border_position.Direction.SOUTH:
		purchase_border_instance.position.y += purchase_border_y_offset
	
	return purchase_border_instance


func _on_room_purchased(room_position: RoomPosition) -> void:
	add_room(room_position)
	
	if room_spots.size() > 0:
		add_purchase_border(room_spots.pop_front())
