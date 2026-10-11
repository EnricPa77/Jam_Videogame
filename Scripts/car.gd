class_name Car extends Node2D

@export var speed: float 
@export var anger_speed: float
@export var anger_speed_car: float
@export var anger_max_speed: float

@onready var polygon: Polygon2D = $Polygon2D
@onready var original_speed: float = speed

const MAX_ANGER: float = 100

var anger: float = 0
var previous_speed: float
var stopped: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(speed)
	if not stopped:
		position.x += speed * delta
	update_angryness(delta)
	
func update_angryness(delta: float) -> void:
	if stopped:
		if anger <= MAX_ANGER:
			anger += delta * anger_speed
		if previous_speed < anger_max_speed:
			previous_speed += anger / anger_speed_car
	print(anger)
	var target_color: Color = Color(1.0, 1.0 - anger/100, 1.0 - anger/100)
	polygon.color = target_color

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Car:
		print("Me he estrellado chat")

func stop() -> void:
	speed = 0
	stopped = true
	
func go() -> void:
	stopped = false
	speed = original_speed + previous_speed
