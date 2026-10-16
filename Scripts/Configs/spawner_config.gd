class_name SpawnerConfig extends Resource

@export var start_hour: int
@export var finish_hour: int
@export var spawn_position: SpawnPosition
@export var spawn_cooldown: float
@export var car_packed_scene: PackedScene
@export var car_config: CarConfig


enum SpawnPosition {
	UP,
	DOWN,
	LEFT,
	RIGHT
}
