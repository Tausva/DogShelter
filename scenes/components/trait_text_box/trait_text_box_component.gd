class_name TraitTextBoxComponent extends Area2D

@onready var control: Control = $Node2D/Control
@onready var node_2d: Node2D = $Node2D
@onready var second_label: Label = $Node2D/Control/NinePatchRect/MarginContainer/VBoxContainer/Label2
@onready var first_label: Label = $Node2D/Control/NinePatchRect/MarginContainer/VBoxContainer/Label

@export var box_spawn_point: Node2D

var camera: Camera2D
var initialized: bool
var is_entered: bool


func _ready() -> void:
	control.hide()
	camera = get_tree().get_first_node_in_group("camera")


func _process(delta: float) -> void:
	if camera:
		control.scale = Vector2.ONE / camera.zoom


func update_traits(first_text: String, first_text_color: Color, second_text: String, second_text_color: Color, line_count: int) -> void:
	var line_height = 25
	
	if !first_text.is_empty() and !second_text.is_empty():
		line_count += 1
		control.size.y = line_count * line_height
	else:
		control.size.y = (line_count + .5) * line_height
	
	control.position.y = line_count * line_height / -2
	
	first_label.text = first_text
	second_label.text = second_text
	
	first_label.add_theme_color_override("font_color", first_text_color)
	second_label.add_theme_color_override("font_color", second_text_color)
	
	initialized = !first_text.is_empty() or !second_text.is_empty()
	
	if is_entered:
		control.show()
		node_2d.global_position = box_spawn_point.global_position


func _on_area_entered(area: Area2D) -> void:
	if area is Cursor:
		if initialized:
			control.show()
			node_2d.global_position = box_spawn_point.global_position
		else:
			is_entered = true


func _on_area_exited(area: Area2D) -> void:
	if area is Cursor:
		control.hide()
		is_entered = false
