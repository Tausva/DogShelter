extends Node2D

@export var press_delay: float = .1

var alfa: Resource = preload("res://resources/traits/alfa.tres")
var barking: Resource = preload("res://resources/traits/barking.tres")
var energetic: Resource = preload("res://resources/traits/energetic.tres")
var friendly: Resource = preload("res://resources/traits/firendly.tres")
var mischevious: Resource = preload("res://resources/traits/mischevious.tres")
var nosy: Resource = preload("res://resources/traits/nosy.tres")
var sleppy: Resource = preload("res://resources/traits/sleepy.tres")


func _ready() -> void:
	populate_text_box()

func _exit_screen() -> void:
	visible = false
	get_tree().paused = false


func populate_text_box():
	populate_resource_to_text_box(alfa)
	populate_resource_to_text_box(barking)
	populate_resource_to_text_box(energetic)
	populate_resource_to_text_box(mischevious)
	populate_resource_to_text_box(nosy)
	populate_resource_to_text_box(sleppy)
	populate_resource_to_text_box(friendly)


func _on_resume_button_pressed() -> void:
	await get_tree().create_timer(press_delay).timeout
	_exit_screen()


func _on_exit_main_menu_button_pressed() -> void:
	await get_tree().create_timer(press_delay).timeout
	
	GameManager.reset_all_parameters_to_default()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/game_menu/game_menu.tscn")


func populate_resource_to_text_box(resource: Resource):
	var name = resource.get_trait_name(resource.current_trait)
	if resource.hated_traits.is_empty():
		$Description.text += name + " Likes everybody :)\n"
	elif resource.hated_traits.size() == 6:
		$Description.text += name + " Hates everybody except himself :)\n"
	else:
		var hate = []
		for hate_trait in resource.hated_traits:
			hate.append(resource.get_trait_name(hate_trait))
		var hate_values = ", ".join(hate)
		$Description.text += name + " Hates: " + hate_values + "\n"
