class_name TraitTextBoxComponent extends Area2D

@onready var trait_text_box: RichTextLabel = $Node2D/Control/TraitTextBox
@onready var control: Control = $Node2D/Control
@onready var node_2d: Node2D = $Node2D

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


func update_traits(traits_text: String, line_count: int) -> void:
	var line_height = 25
	control.size.y = line_count * line_height
	control.position.y = line_count * line_height / -2
	trait_text_box.text = traits_text
	
	initialized = !traits_text.is_empty()
	
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
