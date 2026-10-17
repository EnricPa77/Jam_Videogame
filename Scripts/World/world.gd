class_name World extends Node2D

@onready var clock: Clock = get_node_or_null("Clock")

var cars: int
var win_screen: WinScreen
var lose_screen: LoseScreen

const WIN_SCREEN = preload("res://Scenes/UI/win_screen.tscn")
const LOSE_SCREEN = preload("res://Scenes/UI/lose_screen.tscn")

func _ready():
	get_tree().paused = true

func _process(delta: float) -> void:
	if (clock.current_time >= clock.time_ends) and (cars == 0):
		win_screen = WIN_SCREEN.instantiate() as WinScreen
		add_child(win_screen)

func lost():
	await get_tree().create_timer(2.0, true).timeout
	lose_screen = LOSE_SCREEN.instantiate() as LoseScreen
	add_child(lose_screen)
