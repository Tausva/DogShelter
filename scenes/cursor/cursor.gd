class_name Cursor extends Area2D

var active_draggable_component: DraggableComponent
var dragging: bool = false


func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	global_position = mouse_position 
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and active_draggable_component:
		_drag_component()
	elif !Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and dragging:
		_release_component()


func _drag_component() -> void:
	dragging = true
	active_draggable_component.drag(global_position)


func _release_component() -> void:
	dragging = false
	active_draggable_component.release()


func _on_area_entered(area: Area2D) -> void:
	if area is DraggableComponent and !active_draggable_component:
		active_draggable_component = area


func _on_area_exited(area: Area2D) -> void:
	if !area is DraggableComponent:
		pass
	
	if active_draggable_component == area:
		active_draggable_component = null
