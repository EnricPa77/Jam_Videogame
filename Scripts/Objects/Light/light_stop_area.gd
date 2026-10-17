extends Area2D

@export var color_red := Color(0.85, 0.1, 0.1)
@export var color_green := Color(0.2, 0.8, 0.3)

@onready var color_rect: ColorRect = $ColorRect

func _process(delta: float) -> void:
	var stop: bool = get_parent().get_stop()
	var areas = get_overlapping_areas()
	for area in areas:
		if not (area is HitboxCheckerCar):
			if area.get_parent() is Car:
				var car: Car = area.get_parent()
				if (stop and not car.berserk):
					car.stop()
				else:
					car.go()

func update_color(stop: bool) -> void:
	var c := color_red if stop else color_green
	c.a = color_rect.color.a
	color_rect.color = c
