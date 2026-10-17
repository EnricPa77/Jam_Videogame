class_name Camera extends Camera2D

@onready var world: World = get_tree().root.find_child("World", true, false) as World

var collision_impact: Vector2
var handled_sum: bool
var handled_pos: bool

var position_to: Vector2
var zoom_to: Vector2

func sum_impacts(car_position: Vector2, other_car_position: Vector2):
	if handled_sum:
		return
	collision_impact += car_position + other_car_position
	handled_sum = true
	
func move_to_collision():
	if handled_pos:
		return
	handled_pos = true
	
	position_to = collision_impact/2 + Vector2(32, 0)
	
	zoom_to = Vector2(3, 3)
		
	get_tree().paused = true
	
	var tween: Tween = create_tween()
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	tween.set_parallel(true)
	
	tween.tween_property(self, "position", position_to, 1.0)
	
	tween.tween_property(self, "zoom", zoom_to, 1.0)
	
	world.lost()
	
	
	
