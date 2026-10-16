class_name HitboxCheckerCar extends Area2D

@onready var car: Car = get_parent()

func _process(delta: float) -> void:
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area.get_parent() is Car:
			var car: Car = area.get_parent()
			if (car.stopped and not self.car.berserk):
				self.car.stop()
			else:
				self.car.speed = car.speed
				self.car.go()
