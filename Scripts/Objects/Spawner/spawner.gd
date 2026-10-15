class_name Spawner extends Node2D

@export var spawner_config: Array[SpawnerConfig]
@onready var clock: Clock

var spawn_position: Array[SpawnerConfig.SpawnPosition]
var spawn_cooldown: Array[float]
var car_packed_scene: Array[PackedScene]
var car_config: Array[CarConfig]
var timers: Array[Timer]

var active_config_index: int = -1

enum SpawnPosition {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var world: Node2D = get_tree().root.find_child("World", true, false) as Node2D
	
	if world.has_node("Clock"):
		clock = world.get_node_or_null("Clock") as Clock
		
	for i in range(spawner_config.size()):
		spawn_position.append(spawner_config[i].spawn_position)
		car_packed_scene.append(spawner_config[i].car_packed_scene)
		car_config.append(spawner_config[i].car_config)
		spawn_cooldown.append(spawner_config[i].spawn_cooldown)
		
		create_timers(spawner_config[i].spawn_cooldown, i)
		

func _process(delta: float) -> void:
	if clock == null:
		return
		
	var new_index: int = get_index_current_configuration(clock.current_time)
	
	if new_index != active_config_index:
		change_configuration(new_index)

func _on_timer_timeout(index: int) -> void:
	if index != active_config_index:
		return
	
	var config: SpawnerConfig = spawner_config[index]
	
	spawn_car(config)
	
	if index == active_config_index:
		timers[index].start()
	
	
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

func create_timers(cooldown: float, i: int) -> void:
	var timer := Timer.new()
	timer.wait_time = cooldown
	timer.timeout.connect(_on_timer_timeout.bind(i))
	
	add_child(timer)
	timers.append(timer)

func get_index_current_configuration(current_time: int) -> int:
	for i in range(spawner_config.size()):
		if (current_time >= spawner_config[i].start_hour) and (current_time < spawner_config[i].finish_hour):
			return i
	return -1
	
func change_configuration(new_index: int) -> void:
	if active_config_index != -1:
		timers[active_config_index].stop()
	active_config_index = new_index
	if active_config_index == -1:
		return
	spawn_car(spawner_config[active_config_index])
	timers[active_config_index].start()
		
func spawn_car(config: SpawnerConfig) -> void:
	var car: Car = config.car_packed_scene.instantiate()
	
	configurate_car_stats(car, config)
	
	manage_direction(car, config)
	
	get_tree().current_scene.add_child(car)
	car.global_position = global_position
	
