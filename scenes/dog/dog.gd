class_name Dog extends Node2D

@export var dog_trait_library: Array[Trait]
@export var adjacent_room_hatred_multiplier: float = .3
@export var irritation_threashold: float = 1

@export var wander_speed: float = 10

@onready var happyness_component: Node2D = $HappynessComponent
@onready var draggable_component: DraggableComponent = $DraggableComponent
@onready var dog_sprite: Sprite2D = $DogSprite

var trait_chance_table: Dictionary = {
	1: 8,
	2: 2
}

var dog_traits: Array[Trait]
var random_number_generator = RandomNumberGenerator.new()
var dog_traits_in_string: String

var wander_tween: Tween
var movement_tween: Tween

var bark_sound: String


func _ready() -> void:
	var sprite = get_node("DogSprite")
	set_random_dog_texture(sprite)
	bark_sound = "Bark" + str(randi_range(1, 4))
	_generate_traits()


func set_random_dog_texture(sprite: Sprite2D):
	var texture_atlas = preload("res://scenes/dog/dog_atlas_texture.tres")
	var random_collumn = random_number_generator.randi_range(0, 15)
	var random_row = random_number_generator.randi_range(0, 2)
	var region = Rect2(random_collumn * 16,random_row * 16,16,16)
	var new_texture = texture_atlas.duplicate()
	new_texture.region = region
	sprite.texture = new_texture


func validate_happyness(current_room_traits: Dictionary, adjasent_room_traits: Array) -> void:
	var irritation_value: int = 0
	var room_traits = _get_unique_values(current_room_traits)
	
	for dog_trait in dog_traits:
		irritation_value += adjacent_room_hatred_multiplier * _count_overlapping_values(dog_trait.hated_traits, adjasent_room_traits)
		irritation_value += _count_overlapping_values(dog_trait.hated_traits, room_traits)
	
	happyness_component.is_happy = irritation_value < irritation_threashold


func _count_overlapping_values(arr1: Array, arr2: Array) -> int:
	return arr1.filter(func(x): return x in arr2).size()


func _get_unique_values(current_room_traits: Dictionary) -> Array:
	var traits: Dictionary
	for current_room_trait in current_room_traits.keys():
		var amount = current_room_traits[current_room_trait]
		for dog_trait in dog_traits:
			if dog_trait.current_trait == current_room_trait:
				amount -= 1
		if amount > 0:
			traits.get_or_add(current_room_trait)
	return traits.keys()


func _generate_traits() -> void:
	var trait_count = _get_trait_count()
	
	for i in trait_count:
		dog_trait_library.shuffle()
		var dog_trait = dog_trait_library.pop_back()
		dog_traits.append(dog_trait)
		dog_traits_in_string += dog_trait.TraitType.keys()[dog_trait.current_trait].capitalize() + "\n"
	
	var hated_traits: Dictionary
	for dog_trait in dog_traits:
		for hated_trait in dog_trait.hated_traits:
			hated_traits.get_or_add(hated_trait)
	
	var hated_traits_in_string: String
	for hated_trait in hated_traits.keys():
		hated_traits_in_string += Trait.TraitType.keys()[hated_trait].capitalize() + "\n"
	
	$TraitTextBoxComponent.update_traits(dog_traits_in_string, Color(0, 0, 0), hated_traits_in_string, Color(1, 0, 0), dog_traits.size() + hated_traits.size())


func _get_trait_count() -> int:
	var totol_chance_count = 0
	for key in trait_chance_table:
		totol_chance_count += trait_chance_table[key]
	var trait_count_picker = random_number_generator.randi_range(1, totol_chance_count)
	
	for key in trait_chance_table:
		if trait_chance_table[key] >= trait_count_picker:
			return key
		else:
			trait_count_picker -= trait_chance_table[key]
	
	return 0


func start_wandering(rect: Rect2) -> void:
	var wander_to: Vector2 = get_wonder_destination(rect)
	var wander_duration: float = wander_to.distance_to(global_position) / wander_speed
	
	wander_tween = create_tween()
	wander_tween.tween_property(self, "global_position", wander_to, wander_duration)
	
	movement_tween = create_tween()
	movement_tween.tween_property(dog_sprite, "scale", Vector2(1.15, .85), .3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	movement_tween.chain()
	movement_tween.tween_property(dog_sprite, "scale", Vector2(1, 1), .3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	movement_tween.set_loops(20)
	
	await wander_tween.finished
	movement_tween.stop()
	start_wandering(rect)


func stop_wandering() -> void:
	if wander_tween:
		wander_tween.stop()
		movement_tween.stop()


func get_wonder_destination(room_rect: Rect2) -> Vector2:
	var half_size: Vector2 = draggable_component.half_size

	var x = randf_range(room_rect.position.x + half_size.x, room_rect.position.x + room_rect.size.x - half_size.x)
	var y = randi_range(room_rect.position.y + half_size.y, room_rect.position.y + room_rect.size.y - half_size.y)
	
	return Vector2(x,y)
