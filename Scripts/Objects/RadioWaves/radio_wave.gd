class_name RadioWave extends Node2D


@export var max_radius: float = 200.0
@export var wave_speed: float = 100.0
@export var wave_color: Color = Color.CYAN

var radius: float = 0.0

func _process(delta: float) -> void:
	radius += wave_speed * delta
	queue_redraw()

	if radius >= max_radius:
		radius = 0.0

func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 24, wave_color, 2.0,true)


func _on_calm_wave_area_entered(area: Area2D) -> void:
	if area.get_parent() is Car:
		var car: Car = area.get_parent()
		car.calmness = true
		


func _on_calm_wave_area_exited(area: Area2D) -> void:
	if area.get_parent() is Car:
		var car: Car = area.get_parent()
		car.calmness = false
