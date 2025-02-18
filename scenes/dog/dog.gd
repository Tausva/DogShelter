extends Node2D

@export var dog_traits: Array[String] = []
var random_number_generator = RandomNumberGenerator.new()


func _ready() -> void:
	var sprite = get_node("Area2D/DogSprite")
	set_random_dog_texture(sprite)
	$TraitTextBox.hide()


func _process(delta: float) -> void:
	pass


func set_random_dog_texture(sprite: Sprite2D):
	var texture_atlas = preload("res://scenes/dog/dog_atlas_texture.tres")
	var random_collumn = random_number_generator.randi_range(0, 15)
	var random_row = random_number_generator.randi_range(0, 2)
	var region = Rect2(random_collumn * 16,random_row * 16,16,16)
	var new_texture = texture_atlas.duplicate()
	new_texture.region = region
	sprite.texture = new_texture


func _on_area_2d_area_entered(area: Area2D) -> void:
	var line_count = dog_traits.size()
	var line_height = 25
	$TraitTextBox.custom_minimum_size.y = line_count
	$TraitTextBox.size.y = line_count * line_height
	$TraitTextBox.text = "\n".join(dog_traits)
	$TraitTextBox.show()


func _on_area_2d_area_exited(area: Area2D) -> void:
	$TraitTextBox.hide()
	pass # Replace with function body.
