class_name TraitTextBoxComponent extends Area2D


func _ready() -> void:
	$TraitTextBox.hide()


func update_traits(traits_text: String, line_count: int) -> void:
	var line_height = 25
	$TraitTextBox.custom_minimum_size.y = line_count
	$TraitTextBox.size.y = line_count * line_height
	$TraitTextBox.text = traits_text


func _on_area_entered(area: Area2D) -> void:
	$TraitTextBox.show()


func _on_area_exited(area: Area2D) -> void:
	$TraitTextBox.hide()
