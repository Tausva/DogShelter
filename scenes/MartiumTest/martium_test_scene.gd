extends Node2D
@onready var happy = $"Happyness Component"
@onready var happy_button = $Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	happy_button.pressed.connect(_on_button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	happy.is_happy = !happy.is_happy
