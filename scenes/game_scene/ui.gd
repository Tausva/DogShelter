extends CanvasLayer

@export var press_delay: float = 0.15


func _on_texture_button_pressed() -> void:
	AudioManager.play_audio("Button")
	await get_tree().create_timer(press_delay).timeout
	#funk here
