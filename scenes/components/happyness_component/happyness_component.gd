extends Node2D

@onready var progress_bar = $HappyProgressBar
@onready var happy_progress_timer = $HappyProgressTimer
@onready var is_happy_check_timer = $IsHappyCheckTimer
@onready var angry_image = $AngryImage

@export var is_happy = true
@export var reward_amount: int = 10
@export var reward_multiplier: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_bar.value = 0
	happy_progress_timer.timeout.connect(_on_happy_progress_timer_timeout)
	is_happy_check_timer.timeout.connect(_on_is_happy_check_timer_timeout)
	progress_bar.mouse_filter = Control.MOUSE_FILTER_STOP
	progress_bar.gui_input.connect(_on_progress_bar_clicked)
	happy_progress_timer.start()
	angry_image.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_happy_progress_timer_timeout():
	if is_happy and progress_bar.value < 100:
		progress_bar.show()
		progress_bar.value += 1
		angry_image.hide()
	elif is_happy:
		progress_bar.show()
	else:
		is_happy_check_timer.start()
		progress_bar.value = 0
		progress_bar.hide()
		angry_image.show()


func _on_is_happy_check_timer_timeout():
	if is_happy and happy_progress_timer.is_stopped():
		happy_progress_timer.start()
		is_happy_check_timer.stop()


func _on_progress_bar_clicked(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		if progress_bar.value == 100 and is_happy:
			progress_bar.value = 0

			var final_reward = reward_amount * reward_multiplier
			GameManager.add_funds(final_reward)
