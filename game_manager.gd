extends Node

signal happiness_changed

var total_funds: int = 0
var happy_metric_value: int = 0

func _ready():
	_start_happiness_timer()


func add_funds(amount: int):
	total_funds += amount


func get_funds() -> int:
	return total_funds


func spend_funds(price: int) -> bool:
	if price > total_funds:
		return false
	total_funds = total_funds - price
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


func _on_happiness_timer_timeout():
	emit_signal("happiness_changed")
	_start_happiness_timer()
