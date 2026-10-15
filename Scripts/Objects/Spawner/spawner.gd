class_name Spawner extends Node2D

@export var spawner_config: Array[SpawnerConfig]

@onready var timer: Timer = $Timer
@onready var clock: Clock

var spawn_position: Array[SpawnerConfig.SpawnPosition]
var spawn_cooldown: Array[float]
var car_packed_scene: Array[PackedScene]
var car_config: Array[CarConfig]
var timer_configured: bool

enum SpawnPosition {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var world: Node2D = get_tree().current_scene
	
	if world.has_node("Clock"):
		clock = world.get_node_or_null("Clock") as Clock
		
	for spawner in spawner_config:
		spawn_position.append(spawner.spawn_position)
		car_packed_scene.append(spawner.car_packed_scene)
		car_config.append(spawner.car_config)
		spawn_cooldown.append(spawner.spawn_cooldown)
		

func _process(delta: float) -> void:
	if (not timer_configured) and (clock != null):
		var spawner_config: SpawnerConfig = get_current_configuration(clock.current_time)
		if spawner_config != null:
			timer.wait_time = spawner_config.spawn_cooldown
			timer.start()
			timer_configured = true

func _on_timer_timeout() -> void:
	if clock == null:
		return
	
	var spawner_config: SpawnerConfig = get_current_configuration(clock.current_time)
	
	if spawner_config == null:
		return
	
	var car: Car = spawner_config.car_packed_scene.instantiate()

	configurate_car_stats(car, spawner_config)
	
	manage_direction(car, spawner_config)
	
	get_tree().current_scene.add_child(car)
	car.global_position = global_position
	
	timer.wait_time = spawner_config.spawn_cooldown
	
func manage_direction(car: Car, spawner_config: SpawnerConfig) -> void:
	if (car != null) and (spawner_config != null):
		match spawner_config.spawn_position:
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
			
func configurate_car_stats(car: Car, spawner_config: SpawnerConfig) -> void:
	if (car != null) and (spawner_config != null):
		car.speed = spawner_config.car_config.speed
		car.anger_speed_increase = spawner_config.car_config.anger_speed_increase
		car.anger_speed_decrease = spawner_config.car_config.anger_speed_decrease
		car.anger_speed_car = spawner_config.car_config.anger_speed_car
		car.anger_max_speed = spawner_config.car_config.anger_max_speed

func get_current_configuration(current_time: int) -> SpawnerConfig:
	for spawner in spawner_config:
		if (current_time >= spawner.start_hour) and (current_time < spawner.finish_hour):
			return spawner
	return null
