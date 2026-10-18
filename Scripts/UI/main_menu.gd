extends Control

const GAME_SCENE := "res://Scenes/world.tscn"  
const OPTIONS := preload("res://Scenes/UI/options_menu.tscn")
const MENU_MUSIC := preload("res://Assets/Audio/Music/menu_music.ogg")
const GAME_MUSIC := preload("res://Assets/Audio/Music/gameplay_music.ogg")

@onready var play_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/PlayButton
@onready var exit_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/ExitButton
@onready var options_button = $Menu/VBoxContainer/MarginContainer/VBoxContainer/OptionsButton

func _ready() -> void:
	MusicPlayer.play(MENU_MUSIC)
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)
	exit_button.pressed.connect(_on_quit_pressed)

func _on_play_pressed() -> void:
	UISounds.play_click()
	MusicPlayer.play(GAME_MUSIC)
	get_tree().change_scene_to_file(GAME_SCENE)

func _on_options_pressed() -> void:
	UISounds.play_click()
	var options := OPTIONS.instantiate()
	$Menu.hide()
	options.closed.connect($Menu.show)
	add_child(options)

func _on_quit_pressed() -> void:
	UISounds.play_click()
	get_tree().quit()
