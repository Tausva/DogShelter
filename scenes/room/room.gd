class_name Room extends Node2D

signal room_changed

@onready var droppable_area: Area2D = $DroppableArea
@onready var ground_layer: TileMapLayer = $TileMap/GroundLayer
@onready var wall_layer: TileMapLayer = $TileMap/WallLayer
@onready var window: Sprite2D = $Window
@onready var trait_text_box_component: TraitTextBoxComponent = $TraitTextBoxComponent

@export var ground_presets : Array[PackedScene]
@export var wall_presets: Array[PackedScene]

var dogs: Array[Dog]
var traits: Dictionary
var adjacent_rooms: Array[Room]


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


func assign_dog(new_dog: Dog) -> void:
	dogs.append(new_dog)
	_recalculate_room_traits()
	room_changed.emit()


func remove_dog(dog_to_remove: Dog) -> void:
	dogs.erase(dog_to_remove)
	_recalculate_room_traits()
	room_changed.emit()


func get_room_traits() -> Dictionary:
	return traits


func set_adjecent_room(room: Room) -> void:
	adjacent_rooms.append(room)
	room.room_changed.connect(_on_adjecent_room_changed)


func get_adjacent_room_traits() -> Dictionary:
	var adjacent_traits: Dictionary
	for room in adjacent_rooms:
		for adjacent_trait in room.get_room_traits().keys():
			adjacent_traits.get_or_add(adjacent_trait, 0)
			adjacent_traits[adjacent_trait] += room.get_room_traits()[adjacent_trait]
	return adjacent_traits


func _recalculate_room_traits() -> void:
	traits.clear()
	
	for dog in dogs:
		for dog_trait in (dog as Dog).dog_traits:
			traits.get_or_add(dog_trait.current_trait, 0)
			traits[dog_trait.current_trait] += 1
	
	var trait_string: String
	var traits_size = traits.size()
	
	if !traits.is_empty():
		trait_string += "Room:\n"
		traits_size += 1
	
	for dog_trait in traits:
		trait_string += Trait.TraitType.keys()[dog_trait].capitalize()
		if traits[dog_trait] > 1:
			trait_string += " x " + str(traits[dog_trait])
		trait_string += "\n"

	var adjacent_traits = get_adjacent_room_traits()
	if !adjacent_traits.is_empty():
		if !traits.is_empty():
			traits_size += 1
			trait_string += "\n"
		trait_string += "Adjacent:\n"
		for dog_trait in adjacent_traits:
			trait_string += Trait.TraitType.keys()[dog_trait].capitalize()
			if adjacent_traits[dog_trait] > 1:
				trait_string += " x " + str(adjacent_traits[dog_trait])
			trait_string += "\n"
		traits_size += adjacent_traits.size() + 1
	
	trait_text_box_component.update_traits(trait_string, traits_size)


func _on_adjecent_room_changed() -> void:
	_recalculate_room_traits()
