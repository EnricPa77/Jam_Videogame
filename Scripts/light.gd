class_name Light extends Node2D


@onready var color_up: Polygon2D = $ColorUp
@onready var color_down: Polygon2D = $ColorDown

var stop: bool

func _ready() -> void:
	change_color()

func _on_light_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
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
		
func get_stop() -> bool:
	return stop
