extends Control

const GAME_SCENE := "res://Scenes/world.tscn"  
const OPTIONS := preload("res://Scenes/UI/options_menu.tscn")

@onready var play_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/PlayButton
@onready var exit_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/ExitButton
@onready var options_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/OptionsButton

func _ready() -> void:
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	exit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_options_pressed() -> void:
	var options := OPTIONS.instantiate()
	$Menu.hide()
	options.closed.connect($Menu.show)
	add_child(options)

func _on_quit_pressed() -> void:
	get_tree().quit()
