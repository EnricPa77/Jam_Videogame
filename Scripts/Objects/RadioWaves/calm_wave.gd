extends Area2D

@onready var collisionShape: CollisionShape2D = $CollisionShape2D
@onready var radio_wave: RadioWave = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collisionShape.shape.radius = radio_wave.max_radius
