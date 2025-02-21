extends Node2D

@onready var happy_bar = $HappyBar
@onready var happy_image = $Happy
@onready var angry_image = $Angry

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.happiness_changed.connect(_on_update_happiness_bar)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	happy_bar.value = GameManager.get_happy_metric_value()
	show_image(happy_bar.value)
