extends Node2D

@onready var happy_bar = $HappyBar
@onready var happy_image = $Happy
@onready var angry_image = $Angry


func _ready() -> void:
	GameManager.happiness_changed.connect(_on_update_happiness_bar)



func _process(delta: float) -> void:
	pass


func update_bar_color(value: int):
	pass

func show_image(value: int):
	if happy_bar.value > 0:
		happy_image.show()
		angry_image.hide()
		
	if happy_bar.value == 0:
		happy_image.show()
		angry_image.show()

	if happy_bar.value < 0:
		angry_image.show()
		happy_image.hide()


func _on_update_happiness_bar():
	var target_value = GameManager.get_happy_metric_value()
	#var tween = create_tween()
	
	#tween.tween_property(happy_bar, "value", target_value, 1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	happy_bar.value = GameManager.get_happy_metric_value()
	show_image(happy_bar.value)
	print(happy_bar.value)
