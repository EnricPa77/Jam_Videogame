class_name HitboxCheckerCar extends Area2D

@onready var car: Car = get_parent()
var previous_speed: float

func _process(delta: float) -> void:
	var areas = get_overlapping_areas()
	
	for area in areas:
		if area.get_parent() is Car:
			var other_car: Car = area.get_parent()
			if (other_car.stopped) and not (car.berserk) and (other_car.rotation == car.rotation):
				self.car.stop()
			elif (other_car.rotation == car.rotation) and not (car.berserk):
				if other_car.speed < car.speed:
					previous_speed = car.speed
					self.car.speed = other_car.speed
				else:
					car.speed = car.original_speed
					self.car.go()
	if areas == null:
		print(car.anger)
		car.speed = previous_speed
		self.car.go()
