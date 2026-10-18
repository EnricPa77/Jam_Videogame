class_name Calm_Wave extends Area2D

@onready var collisionShape: CollisionShape2D = $CollisionShape2D
@onready var radio_wave: RadioWave = get_parent()

func _ready() -> void:
	collisionShape.shape.radius = radio_wave.max_radius
