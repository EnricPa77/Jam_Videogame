class_name Camera extends Camera2D


var collision_impact: Vector2
var handled_sum: bool
var handled_pos: bool

func sum_impacts(car_position: Vector2, other_car_position: Vector2):
	if handled_sum:
		return
	collision_impact += car_position + other_car_position
	handled_sum = true
	
func move_to_collision():
	if handled_pos:
		return
	handled_pos = true
	
	position = collision_impact/2 + Vector2(32, 0)
	zoom = Vector2(3, 3)
	
	get_tree().paused = true
	
