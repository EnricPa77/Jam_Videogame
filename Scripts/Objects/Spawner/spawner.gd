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
		car.global_position = global_position

func create_timers(cooldown: float, i: int) -> void:
	var timer := Timer.new()
	timer.wait_time = cooldown
	timer.timeout.connect(_on_timer_timeout.bind(i))
	
	add_child(timer)
	timers.append(timer)

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
	

  if await check_spawn(car):
		get_tree().current_scene.add_child(car)

	
	
func check_spawn(car: Car) -> bool:
	var check_spawn: Area2D = Area2D.new()
	var collision := CollisionShape2D.new()
	var rectangle := RectangleShape2D.new()
	
	var hitbox_car := car.get_node_or_null("HitboxCar") as Area2D
	var hitbox_checker := car.get_node_or_null("HitboxCheckerCar") as Area2D
	
	if hitbox_car == null or hitbox_checker == null:
		return false
	
	var shape_car := hitbox_car.get_child(0) as CollisionShape2D
	var shape_checker := hitbox_checker.get_child(0) as CollisionShape2D
	
	if shape_car == null or shape_checker == null:
		return false
	
	var rect_car := shape_car.shape as RectangleShape2D
	var rect_checker := shape_checker.shape as RectangleShape2D
	
	if rect_car == null or rect_checker == null:
		return false
	
	rectangle.size = rect_car.size + rect_checker.size
	collision.shape = rectangle
	
	check_spawn.add_child(collision)
	
	check_spawn.collision_layer = 0
	check_spawn.collision_mask = hitbox_car.collision_mask
	check_spawn.monitoring = true

	get_tree().current_scene.add_child(check_spawn)
	check_spawn.global_transform = hitbox_car.global_transform

	await get_tree().physics_frame
	await get_tree().physics_frame


	var can_spawn := true

	for area in check_spawn.get_overlapping_areas():
		print(area)
		if area is HitboxCar:
			can_spawn = false
			break

	check_spawn.queue_free()

	return can_spawn
