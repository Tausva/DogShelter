class_name Cursor extends Area2D

var active_draggable_component: DraggableComponent
var active_happyness_component: HappynessComponent

var dragging: bool = false


func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	global_position = mouse_position 
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and active_happyness_component:
		active_happyness_component.press()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and active_draggable_component:
		_drag_component()
		
		if active_draggable_component.get_parent() is Dog:
			active_draggable_component.get_parent().stop_wandering()
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
	elif area is HappynessComponent and !active_happyness_component:
		active_happyness_component = area


func _on_area_exited(area: Area2D) -> void:
	if area is DraggableComponent:
		if active_draggable_component == area:
			active_draggable_component = null
	elif area is HappynessComponent:
		if active_happyness_component == area:
			active_happyness_component = null
