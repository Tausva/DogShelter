extends CanvasLayer

@export var press_delay: float = 0.15

@export var pause_menu: PackedScene

var pause_menu_instance: Node


func _on_texture_button_pressed() -> void:
	AudioManager.play_audio("Button")
	await get_tree().create_timer(press_delay).timeout
	pause_menu_instance = pause_menu.instantiate()
	add_child(pause_menu_instance)
	get_tree().paused = true
