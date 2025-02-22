extends Node2D

@export var dog_count: int = 50


func _ready() -> void:
	var dog_resource = preload("res://scenes/menu_dog/menu_dog.tscn") as PackedScene
	
	for i in dog_count:
		var dog_instance = dog_resource.instantiate()
		add_child(dog_instance)
		dog_instance.global_position = dog_instance.get_wonder_destination(get_viewport_rect())
		dog_instance.start_wandering(get_viewport_rect())
