class_name PurchaseBorder extends Node2D

signal purchased(border_position: RoomPosition)

@onready var label: Label = $Control/Label

var border_position: RoomPosition
var current_price: int


func _try_purchase() -> void:
	if GameManager.spend_funds(current_price):
		purchased.emit(border_position)
		queue_free()


func _on_button_pressed() -> void:
	_try_purchase()


func _on_price_increase(new_price: int) -> void:
	current_price = new_price
	label.text = str(current_price)
