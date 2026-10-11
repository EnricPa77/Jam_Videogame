class_name Car extends Node2D

@export var speed: float 
@export var anger_speed: float
@onready var polygon: Polygon2D = $Polygon2D

var anger: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	update_angryness(delta)
	
func update_angryness(delta: float) -> void:
	anger += delta * anger_speed
	speed += anger/100
	var target_color: Color = Color(1.0, 1.0 - anger/100, 1.0 - anger/100)
	polygon.color = target_color

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().get_class() == self.get_class():
		print("Nigga")
