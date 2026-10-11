extends Node2D

@onready var world: Node2D = get_parent()
@onready var signals_config: Array[SingalsConfig]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		pass
		
