extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var stop: bool = get_parent().get_stop()
	var areas = get_overlapping_areas()
	for area in areas:
		if area.get_parent() is Car:
			var car: Car = area.get_parent()
			if stop:
				car.stop()
			else:
				car.go()
