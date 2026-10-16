class_name Light extends Node2D

@export var light_cooldown: float

@onready var color_up: Polygon2D = $ColorUp
@onready var color_down: Polygon2D = $ColorDown
@onready var timer: Timer = $Timer
@export var tex_red: Texture2D
@export var tex_green: Texture2D
@onready var sprite: Sprite2D = $Sprite2D

var cooldown_ready: bool
var stop: bool

func _ready() -> void:
	add_to_group("traffic_lights")
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
		sprite.texture = tex_red
		stop = true
	else:
		sprite.texture = tex_green
		stop = false
	cooldown_ready = false;
func get_stop() -> bool:
	return stop
	
func set_stop(value: bool) -> void:
	if stop == value:
		return
	change_color()
	cooldown_ready = true

func _on_timer_timeout() -> void:
	cooldown_ready = true
