extends Node

signal happiness_changed
signal prepare_end_game
signal happiness_funds_changed(int)

var total_funds: int = 0
var happy_metric_value: int = 0
var dogs_saved: int = 0
var end_game_counter: int = 0
var finish_game_seconds: int = 10

func _ready():
	_start_happiness_timer()


func get_dogs_saved() -> int:
	return dogs_saved


func set_dogs_saved(value: int):
	dogs_saved = value
	get_tree().change_scene_to_file("res://scenes/UI/end_screen.tscn")


func add_funds(amount: int):
	total_funds += amount
	happiness_funds_changed.emit(total_funds)


func get_funds() -> int:
	return total_funds


func spend_funds(price: int) -> bool:
	if price > total_funds:
		return true
	total_funds = total_funds - price
	happiness_funds_changed.emit(total_funds)
	return true


func add_happy(is_Happy: bool, value: int):
	if is_Happy:
		happy_metric_value += value
	else:
		happy_metric_value -= value
	happy_metric_value = clamp(happy_metric_value, -100, 100)


func get_happy_metric_value() -> int:
	return happy_metric_value


func _start_happiness_timer():
	var timer = get_tree().create_timer(1.0)
	timer.timeout.connect(_on_happiness_timer_timeout)
	
	if happy_metric_value == -100:
		end_game_counter += 1
	else:
		end_game_counter = 0
	if finish_game_seconds == end_game_counter:
		emit_signal("prepare_end_game")


func _on_happiness_timer_timeout():
	emit_signal("happiness_changed")
	_start_happiness_timer()
