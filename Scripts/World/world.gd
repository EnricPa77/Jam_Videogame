class_name World extends Node2D

@onready var clock: Clock = get_node_or_null("Clock")
@onready var win_screen = $WinScreen


var lose_screen: LoseScreen


var cars: int
var towers_selected := 0:
	set(value):
		towers_selected = value
		towers_selected_changed.emit(towers_selected)
@onready var win_screen = $WinScreen
var lose_screen: LoseScreen
var win_handled: bool

const WIN_SCREEN = preload("res://Scenes/UI/win_screen.tscn")
const LOSE_SCREEN = preload("res://Scenes/UI/lose_screen.tscn")

signal towers_selected_changed(count: int)

func _ready():
	get_tree().paused = true

func _process(delta: float) -> void:
	if (clock.current_time >= clock.time_ends) and (cars == 0) and not win_handled:
		win_screen.visible = true
		win_screen.audio_win.play()
		win_handled = true

func lost():
	await get_tree().create_timer(2.0, true).timeout
	lose_screen = LOSE_SCREEN.instantiate() as LoseScreen
	add_child(lose_screen)
	
func update_towers():
	var radio_waves = find_children("*", "RadioWave", true, false)
	for wave in radio_waves:
		wave.game_started = true
