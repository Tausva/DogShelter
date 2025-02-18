class_name DraggableComponent extends Area2D

var starting_position: Vector2 = Vector2.ZERO
var current_room: Room
var half_size: Vector2
var occupied_position: Vector2
var is_being_dragged: bool = false

signal position_changed(old_position: Vector2, new_position: Vector2)
signal dragging_started(is_being_dragged: bool, dragged_dog: Node2D)


func _ready() -> void:
	var collision = get_child(0) as CollisionShape2D
	var collision_shape = collision.shape as RectangleShape2D
	half_size = collision_shape.size / 2 * global_scale


func drag(new_position: Vector2) -> void:
	if starting_position == Vector2.ZERO:
		starting_position = get_parent().global_position
	is_being_dragged = true
	emit_signal("dragging_started", is_being_dragged, get_parent())
	get_parent().global_position = new_position


func release() -> void:
	if !current_room:
		get_parent().global_position = starting_position
	else:
		starting_position = Vector2.ZERO
		_snap_to_room(current_room.get_room_area())
	is_being_dragged = false
	emit_signal("dragging_started", is_being_dragged, get_parent())


func _snap_to_room(area_to_snap: Area2D) -> void:
	var snap_rect: Rect2 = ((area_to_snap.get_child(0) as CollisionShape2D).shape as RectangleShape2D).get_rect()
	snap_rect.position = snap_rect.position + area_to_snap.global_position
	var parent_position: Vector2 = get_parent().global_position
	
	if parent_position.x - half_size.x < snap_rect.position.x:
		get_parent().global_position.x = snap_rect.position.x + half_size.x
	elif parent_position.x + half_size.x > snap_rect.position.x + snap_rect.size.x:
		get_parent().global_position.x = snap_rect.position.x + snap_rect.size.x - half_size.x
	
	if parent_position.y - half_size.y < snap_rect.position.y:
		get_parent().global_position.y = snap_rect.position.y + half_size.y
	elif parent_position.y + half_size.y > snap_rect.position.y + snap_rect.size.y:
		get_parent().global_position.y = snap_rect.position.y + snap_rect.size.y - half_size.y


func _on_area_entered(area: Area2D) -> void:
	if area.owner is Room:
		current_room = area.owner


func _on_area_exited(area: Area2D) -> void:
	if area.owner is Room and current_room == area.owner:
		current_room = null
