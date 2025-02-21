extends Node

var total_funds: int = 0
var happy_metric_value: int = 0

func add_funds(amount: int):
	total_funds += amount


func get_funds() -> int:
	return total_funds


func spend_funds(price: int):
	total_funds = total_funds - price


func add_happy(isHappy: bool, value: int):
	if isHappy:
		happy_metric_value += value
	else:
		happy_metric_value -= value
