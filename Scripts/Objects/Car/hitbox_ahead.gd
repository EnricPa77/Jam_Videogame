class_name HitboxCheckerCar extends Area2D

@onready var car: Car = get_parent()

func _process(delta: float) -> void:
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area.get_parent() is Car:
			var other_car: Car = area.get_parent()
			if (other_car.stopped and not car.berserk):
				self.car.stop()
			elif other_car.rotation == car.rotation:
				if other_car.speed < car.speed:
					self.car.speed = other_car.speed
				else:
					self.car.speed = car.speed
					self.car.go()
