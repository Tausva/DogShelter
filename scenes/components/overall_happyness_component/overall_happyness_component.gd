extends Node2D

@onready var is_happy_timer = $IsHappyTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_happy_timer.timeout.connect(_on_happy_timer_timeout)
	is_happy_timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_happy_timer_timeout():
	pass
