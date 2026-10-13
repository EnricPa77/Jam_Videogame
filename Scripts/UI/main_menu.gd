extends Control

const GAME_SCENE := "res://Scenes/world.tscn"  

@onready var play_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/PlayButton
@onready var exit_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/ExitButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	exit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_quit_pressed() -> void:
	get_tree().quit()
