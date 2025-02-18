extends Camera2D

@export var zoom_minimum: float = .1
@export var zoom_maximum: float = 2.5
@export var zoom_speed: float = .3
@export var camera_speed: float = 200

@export var maximum_left: float = -120
@export var maximum_right: float = 740
@export var maximum_top: float = -85
@export var maximum_bottom: float = 750

var edge_margin: float = 5
var viewport_size: Vector2


func _ready() -> void:
	viewport_size = get_viewport().size


func _process(delta: float) -> void:
	var mouse_position = get_viewport().get_mouse_position()
	var move_vector = Vector2.ZERO
	
	if mouse_position.x <= edge_margin or Input.is_action_pressed("Left"):
		move_vector.x = -camera_speed * delta / zoom.x
	elif mouse_position.x >= viewport_size.x - edge_margin or Input.is_action_pressed("Right"):
		move_vector.x = + camera_speed * delta / zoom.x
	
	if mouse_position.y <= edge_margin or Input.is_action_pressed("Up"):
		move_vector.y = -camera_speed * delta / zoom.y
	elif mouse_position.y >= viewport_size.y - edge_margin or Input.is_action_pressed("Down"):
		move_vector.y = + camera_speed * delta / zoom.y
	
	position += move_vector
	
	if position.x < maximum_left:
		position.x = maximum_left
	elif position.x > maximum_right:
		position.x = maximum_right
	
	if position.y < maximum_top:
		position.y = maximum_top
	elif position.y > maximum_bottom:
		position.y = maximum_bottom


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				if zoom.x > zoom_minimum:
					zoom -= Vector2(zoom_speed, zoom_speed)
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				if zoom.x < zoom_maximum:
					zoom += Vector2(zoom_speed, zoom_speed)
