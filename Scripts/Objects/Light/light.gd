class_name Light extends Node2D

@export var light_cooldown: float

@onready var color_up: Polygon2D = $ColorUp
@onready var color_down: Polygon2D = $ColorDown
@onready var timer: Timer = $Timer

var cooldown_ready: bool
var stop: bool

func _ready() -> void:
	if light_cooldown > 0:
		timer.wait_time = light_cooldown
		timer.start()
		change_color()
		cooldown_ready = true

func _on_light_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and (cooldown_ready):
		change_color()

func change_color() -> void:
	stop = not stop
	if stop:
		color_up.visible = true
		var target_color: Color = Color(1.0, 0.0, 0.0)
		color_down.visible = false
		color_up.color = target_color
		stop = true
	else:
		color_down.visible = true
		var target_color: Color = Color(0.0, 1.0, 0.0)
		color_up.visible = false
		color_down.color = target_color
		stop = false
	cooldown_ready = false;
func get_stop() -> bool:
	return stop


func _on_timer_timeout() -> void:
	cooldown_ready = true
