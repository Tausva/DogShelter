class_name PurchaseBorder extends Node2D

signal purchased(border_position: RoomPosition)

@onready var label: Label = $Control/Label

var new_dog_spawn_positions: Array[Vector2]
var border_position: RoomPosition
var current_price: int


func _try_purchase() -> void:
	if GameManager.spend_funds(current_price):
		purchased.emit(border_position)
		GameManager.add_new_dog_spawns(new_dog_spawn_positions)
		AudioManager.play_audio("Buy")
		queue_free()
	else:
		AudioManager.play_audio("Deny")


func _on_button_pressed() -> void:
	_try_purchase()


func _on_price_increase(new_price: int) -> void:
	current_price = new_price
	label.text = str(current_price)
