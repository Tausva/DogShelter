class_name MenuDog extends Node2D

@export var wander_speed: float = 10

@onready var dog_sprite: Sprite2D = $DogSprite

var wander_tween: Tween
var movement_tween: Tween

var random_number_generator = RandomNumberGenerator.new()

func _ready() -> void:
	var sprite = get_node("DogSprite")
	set_random_dog_texture(sprite)


func set_random_dog_texture(sprite: Sprite2D):
	var texture_atlas = preload("res://scenes/dog/dog_atlas_texture.tres")
	var random_collumn = random_number_generator.randi_range(0, 15)
	var random_row = random_number_generator.randi_range(0, 2)
	var region = Rect2(random_collumn * 16,random_row * 16,16,16)
	var new_texture = texture_atlas.duplicate()
	new_texture.region = region
	sprite.texture = new_texture


func start_wandering(rect: Rect2) -> void:
	var wander_to: Vector2 = get_wonder_destination(rect)
	var wander_duration: float = wander_to.distance_to(global_position) / wander_speed
	
	wander_tween = create_tween()
	wander_tween.tween_property(self, "global_position", wander_to, wander_duration)
	
	movement_tween = create_tween()
	movement_tween.tween_property(dog_sprite, "scale", Vector2(1.15, .85), .3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	movement_tween.chain()
	movement_tween.tween_property(dog_sprite, "scale", Vector2(1, 1), .3).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	movement_tween.set_loops(2000)
	
	await wander_tween.finished
	movement_tween.stop()
	start_wandering(rect)


func stop_wandering() -> void:
	if wander_tween:
		wander_tween.stop()
		movement_tween.stop()


func get_wonder_destination(room_rect: Rect2) -> Vector2:
	var half_size: Vector2 = dog_sprite.texture.get_size() / 2

	var x = randf_range(room_rect.position.x + half_size.x, room_rect.position.x + room_rect.size.x - half_size.x)
	var y = randi_range(room_rect.position.y + half_size.y, room_rect.position.y + room_rect.size.y - half_size.y)
	
	return Vector2(x,y)
