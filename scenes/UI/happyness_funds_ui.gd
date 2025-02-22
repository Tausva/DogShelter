class_name HappynessFundUI extends Control

@onready var label: Label = $HBoxContainer/Label


func _ready() -> void:
	visible = false
	GameManager.happiness_funds_changed.connect(_on_changed_value)


func _on_changed_value(value: int) -> void:
	if value <= 0:
		visible = false
	else:
		visible = true
		label.text = str(value)
