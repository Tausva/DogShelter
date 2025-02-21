extends Node2D
@onready var happy = $"Happyness Component"
@onready var happy2 = $"Happyness Component2"
@onready var happy3 = $"Happyness Component3"
@onready var happy4 = $"Happyness Component4"
@onready var happy_button = $Button
@onready var happy_button2 = $Button2
@onready var happy_button3 = $Button3
@onready var happy_button4 = $Button4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	happy_button.pressed.connect(_on_button_pressed)
	happy_button2.pressed.connect(_on_button_pressed2)
	happy_button3.pressed.connect(_on_button_pressed3)
	happy_button4.pressed.connect(_on_button_pressed4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	happy.is_happy = !happy.is_happy


func _on_button_pressed2() -> void:
	happy2.is_happy = !happy2.is_happy


func _on_button_pressed3() -> void:
	happy3.is_happy = !happy3.is_happy


func _on_button_pressed4() -> void:
	happy4.is_happy = !happy4.is_happy
