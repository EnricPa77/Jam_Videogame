class_name Car extends Node2D

##Mide qué tan rápido va el coche. Cuanto mayor sea, mayor es su velocidad.
@export var speed: float 
##Mide qué tan rápido se enfada el coche. Cuanto mayor sea más rapido se enfada.
@export var anger_speed_increase: float
##Mide qué tan rápido se desenfada el coche. Cuanto mayor sea más rapido se enfada.
@export var anger_speed_decrease: float
##Mide qué tan rápido el coche pilla aceleración y frena al enfadarse. Cuanto menor sea más rápido acelera y más rapido frena.
@export var anger_speed_car: float
##Mide la velocidad máxima del coche al enfadarse
@export var anger_max_speed: float
##Mide a que dirección tiene que ir el coche
@export var direction: Vector2

@onready var polygon: Polygon2D = $Polygon2D
@onready var original_speed: float = speed

const MAX_ANGER: float = 100

var anger: float = 0
var calmness: bool = false
var stopped: bool
var berserk: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not stopped:
		position += direction * speed * delta
	update_angryness(delta)

func update_angryness(delta: float) -> void:
	if stopped:
		anger = minf(
			anger + delta * anger_speed_increase,
			MAX_ANGER
		)

		speed = minf(
			speed + (anger_speed_car * delta),
			anger_max_speed
		)
		
		if anger == MAX_ANGER:
			berserk = true

	elif not berserk and calmness:
		anger = maxf(
			anger - delta * anger_speed_decrease,
			0.0
		)

		speed = maxf(
			speed - (anger_speed_car * delta),
			original_speed
		)

	var target_color: Color = Color(1.0, 1.0 - anger/100, 1.0 - anger/100)
	polygon.color = target_color


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is HitboxCar:
		print("Me he estrellado chat")


func stop() -> void:
	stopped = true


func go() -> void:
	stopped = false


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
