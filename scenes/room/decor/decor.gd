class_name Decor extends Sprite2D

@export var variations: Array[Texture]
@export var chance_of_spawning: float

func _ready() -> void:
	var dice_roll = randf_range(0, 1)
	
	if chance_of_spawning >= dice_roll:
		var index = randi_range(0, variations.size() - 1)
		texture = variations[index]
	else:
		queue_free()
