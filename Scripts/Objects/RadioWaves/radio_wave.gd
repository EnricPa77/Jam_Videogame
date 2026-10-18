class_name RadioWave extends Node2D

@onready var world: World = get_tree().root.find_child("World", true, false) as World

@export var max_radius: float = 200.0
@export var wave_speed: float = 100.0
@export var wave_color: Color = Color(0.0, 1.0, 1.0, 0.05)
@export var tower_cooldown: float

var radius: float = 0.0
var calm_wave: Calm_Wave
var game_started: bool
var selected: bool

func _process(delta: float) -> void:
	if selected:
		radius += wave_speed * delta
		queue_redraw()

		if radius >= max_radius:
			radius = 0.0
	
	if game_started and not selected:
		visible = false

func _draw() -> void:
	if selected:
		draw_arc(Vector2.ZERO, radius, 0.0, TAU, 24, wave_color, 2.0,true)


func _on_calm_wave_area_entered(area: Area2D) -> void:
	if selected:
		if area.get_parent() is Car:
			var car: Car = area.get_parent()
			car.calmness = true

func _on_calm_wave_area_exited(area: Area2D) -> void:
	if selected:
		if area.get_parent() is Car:
			var car: Car = area.get_parent()
			car.calmness = false

func _on_radio_hitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click") and not game_started:
		if selected:
			selected = false
			world.towers_selecteds -= 1 
			radius = 0.0
			queue_redraw()
			print(world.towers_selecteds)
		elif world.towers_selecteds < 2:
			selected = true
			world.towers_selecteds += 1 
			print(world.towers_selecteds)
