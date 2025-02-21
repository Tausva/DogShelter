extends Node

var total_funds: int = 0

func add_funds(amount: int):
	total_funds += amount


func get_funds() -> int:
	return total_funds


func spend_funds(price: int) -> bool:
	if price > total_funds:
		return false
	
	total_funds = total_funds - price
	return true
