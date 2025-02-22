extends Node2D

@onready var happy_bar = $HappyBar
@onready var happy_image = $Happy
@onready var angry_image = $Angry


func _ready() -> void:
	GameManager.happiness_changed.connect(_on_update_happiness_bar)


func _process(delta: float) -> void:
	pass


func update_bar_color(value: int):
	var target_fill_color: Color
	var target_background_color: Color
	var stylebox_fill = happy_bar.get_theme_stylebox("fill")
	var stylebox_background = happy_bar.get_theme_stylebox("background")

	if value > 30:
		target_fill_color = Color(0,1,0)
		target_background_color = Color(0.683,0.894,0.663)
	if value < -30:
		target_fill_color = Color(1,0,0)
		target_background_color = Color(0.931,0.422,0.332)
	if value < 30 and value > - 30:
		target_fill_color = Color(1,1,0.4)
		target_background_color = Color(0.603,0.619,0.422)
	if value == -100:
		target_background_color = Color(1,0,0)

	var tween = create_tween()
	tween.tween_method(
		func(color): 
		stylebox_fill.bg_color = color,
		stylebox_fill.bg_color,
		target_fill_color,
		0.5
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_method(
		func(color): 
		stylebox_background.bg_color = color, 
		stylebox_background.bg_color,
		target_background_color, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)


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
	
	var tween = create_tween()
	tween.tween_property(happy_bar, "value", target_value, 0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	show_image(happy_bar.value)
	update_bar_color(happy_bar.value)
