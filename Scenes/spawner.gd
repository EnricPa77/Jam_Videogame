class_name Spawner extends Node2D

@export var spawn_position: SpawnPosition
@export var car_packed_scene: PackedScene
@export var car_config: CarConfig
@export var spawn_cooldown: float

@onready var timer: Timer = $Timer

enum SpawnPosition {
	UP,
	DOWN,
	LEFT,
	RIGHT
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = spawn_cooldown
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var car: Car = car_packed_scene.instantiate()
	
	car.speed = car_config.speed
	car.anger_speed_increase = car_config.anger_speed_increase
	car.anger_speed_decrease = car_config.anger_speed_decrease
	car.anger_speed_car = car_config.anger_speed_car
	car.anger_max_speed = car_config.anger_max_speed
	
	manage_direction(car)
	
	get_tree().current_scene.add_child(car)
	car.global_position = global_position
	


func manage_direction(car: Car) -> void:
	match spawn_position:
		SpawnPosition.UP:
			car.rotation = deg_to_rad(180)
			car.direction = Vector2.UP
		SpawnPosition.DOWN:
			car.rotation = deg_to_rad(0)
			car.direction = Vector2.DOWN
		SpawnPosition.LEFT:
			car.rotation = deg_to_rad(90)
			car.direction = Vector2.LEFT
		SpawnPosition.RIGHT:
			car.rotation = deg_to_rad(270)
			car.direction = Vector2.RIGHT
