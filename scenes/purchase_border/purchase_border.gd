class_name PurchaseBorder extends Node2D

signal purchased(border_position: RoomPosition)

var border_position: RoomPosition


func _try_purchase() -> void:
	#TODO: if statement to check if it can be purchased
	
	purchased.emit(border_position)
	queue_free()


func _on_button_pressed() -> void:
	_try_purchase()
