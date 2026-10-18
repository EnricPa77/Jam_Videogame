class_name HitboxCheckerCar extends Area2D

@onready var car: Car = get_parent()
var previous_speed: float

func _physics_process(delta: float) -> void:
	var must_stop := car.stopped_by_light

	for area in get_overlapping_areas():
		if area.get_parent() is Car:
			var other_car: Car = area.get_parent() as Car

			if car.berserk:
				continue

			if other_car.rotation == car.rotation:
				if other_car.stopped:
					must_stop = true
					break
				if other_car.speed < car.speed:
					car.speed = other_car.speed
	if must_stop:
		car.stop()
	else:
		car.go()
