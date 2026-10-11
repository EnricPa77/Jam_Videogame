extends Node2D

@onready var world: World = get_parent()
@onready var signals_config: Array[SignalsConfig] = world.get_signals_config()

var signals_scenes: Array[SignalsConfig]

func _ready() -> void:
	for signals in signals_config:
		pass
		#print(signals.signals_scene)
		#signals_scenes.append(signals.signals_scene)



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if event.position.x >= 0 and event.position.x <= 300 and event.position.y >= 348 and event.position.y <= 648:
			print(event.position)



func spawn_signal() -> void:
	signals_config.get(0)
