class_name Dog extends Node2D

@export var dog_trait_library: Array[Trait]

var trait_chance_table: Dictionary = {
	1: 5,
	2: 3,
	3: 2
}

var dog_traits: Array[Trait]
var random_number_generator = RandomNumberGenerator.new()
var dog_traits_in_string: String


func _ready() -> void:
	var sprite = get_node("DogSprite")
	set_random_dog_texture(sprite)
	_generate_traits()


func set_random_dog_texture(sprite: Sprite2D):
	var texture_atlas = preload("res://scenes/dog/dog_atlas_texture.tres")
	var random_collumn = random_number_generator.randi_range(0, 15)
	var random_row = random_number_generator.randi_range(0, 2)
	var region = Rect2(random_collumn * 16,random_row * 16,16,16)
	var new_texture = texture_atlas.duplicate()
	new_texture.region = region
	sprite.texture = new_texture


func _generate_traits() -> void:
	var trait_count = _get_trait_count()
	
	for i in trait_count:
		dog_trait_library.shuffle()
		var dog_trait = dog_trait_library.pop_back()
		dog_traits.append(dog_trait)
		dog_traits_in_string += dog_trait.TraitType.keys()[dog_trait.current_trait] + "\n"
	
	$TraitTextBoxComponent.update_traits(dog_traits_in_string, dog_traits.size())


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
