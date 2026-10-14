class_name Clock extends Node2D

@onready var label = $Label
@onready var timer = $Timer
@export var time_start: int
@export var time_ends: int

var hour: int
var minutes: int
var current_time: int

func _ready():
	timer.start()
	update_time()

func _on_timer_timeout() -> void:
	if time_start < time_ends:
		time_start += 10
		update_time()
	
func update_time() -> void:
	hour = (time_start / 60)
	minutes = time_start - hour * 60
	current_time = time_start + minutes
	label.text = '%02d:%02d' % [hour, minutes]
