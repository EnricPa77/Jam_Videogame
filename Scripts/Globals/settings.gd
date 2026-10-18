extends Node

const PATH := "user://settings.cfg"
const RESOLUTIONS: Array[Vector2i] = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
]

var music := 0.5
var sfx := 0.5
var fullscreen := false
var resolution_index := 0

func _ready() -> void:
	_load()
	set_bus_volume("Music", music)
	set_bus_volume("SFX", sfx)
	apply_window()

func set_bus_volume(bus_name: String, value: float) -> void:
	var idx := AudioServer.get_bus_index(bus_name)
	if idx == -1:
		return
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
	AudioServer.set_bus_mute(idx, value <= 0.001)

func apply_window() -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	var size := RESOLUTIONS[resolution_index]
	DisplayServer.window_set_size(size)
	# Centrar la ventana en la pantalla actual
	var screen := DisplayServer.window_get_current_screen()
	var area := DisplayServer.screen_get_usable_rect(screen)
	DisplayServer.window_set_position(area.position + (area.size - size) / 2)

func save() -> void:
	var cfg := ConfigFile.new()
	cfg.load(PATH) # conserva la sección del tutorial
	cfg.set_value("audio", "music", music)
	cfg.set_value("audio", "sfx", sfx)
	cfg.set_value("video", "fullscreen", fullscreen)
	cfg.set_value("video", "resolution_index", resolution_index)
	cfg.save(PATH)

func _load() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(PATH) != OK:
		return
	music = cfg.get_value("audio", "music", music)
	sfx = cfg.get_value("audio", "sfx", sfx)
	fullscreen = cfg.get_value("video", "fullscreen", fullscreen)
	resolution_index = clampi(cfg.get_value("video", "resolution_index", 0), 0, RESOLUTIONS.size() - 1)
