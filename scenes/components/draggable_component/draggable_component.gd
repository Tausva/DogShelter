class_name DraggableComponent extends Area2D

var starting_position: Vector2 = Vector2.ZERO
var current_room: Room


func drag(new_position: Vector2) -> void:
	if starting_position == Vector2.ZERO:
		starting_position = get_parent().global_position
	
	get_parent().global_position = new_position


func release() -> void:
	if !current_room:
		get_parent().global_position = starting_position
	else:
		starting_position = Vector2.ZERO
		print("assigned to room")


func _on_area_entered(area: Area2D) -> void:
	if area.owner is Room and !current_room:
		current_room = area.owner


func _on_area_exited(area: Area2D) -> void:
	if area.owner is Room and current_room == area.owner:
		current_room = null
