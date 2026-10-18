class_name Light extends Node2D

@export var light_cooldown: float
@onready var timer: Timer = $Timer
@onready var light_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
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
	sprite.texture = tex_red if stop else tex_green
	_refresh_visual()

func _on_light_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and (cooldown_ready):
		light_sound.play()
		change_color()

func change_color() -> void:
	stop = not stop
	_refresh_visual()
	cooldown_ready = false

func get_stop() -> bool:
	return stop
	
func set_stop(value: bool) -> void:
	stop = value
	_refresh_visual()
	cooldown_ready = true

func _on_timer_timeout() -> void:
	cooldown_ready = true

func _refresh_visual() -> void:
	sprite.texture = tex_red if stop else tex_green
	var area = get_node_or_null("StopArea")
	if area:
		area.update_color(stop)
