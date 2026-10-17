extends Area2D

##Mide cuanta velocidad le quita al vehículo mientras esté encima
@export var speed_reduction: float

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxCar:
		var car: Car = area.get_parent()
		car.speed = car.speed - speed_reduction


func _on_area_exited(area: Area2D) -> void:
	if area is HitboxCar:
		var car: Car = area.get_parent()
		car.speed = car.speed + speed_reduction
