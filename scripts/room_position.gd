class_name RoomPosition extends Resource

enum Direction {SOUTH, NORTH}

@export var coordinates: Vector2
@export var has_window: bool
@export var direction: Direction
@export var adjecent_positions: Array[int]

var assigned_room: Room
var index
