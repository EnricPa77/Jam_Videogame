class_name OptionsMenu
extends CanvasLayer

signal closed

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var resolution_option: OptionButton = %ResolutionOption
@onready var fullscreen_check: CheckButton = %FullscreenCheck
@onready var back_button: Button = %Back
# Alternativa si no pones Back como Unique Name:
# @onready var back_button: Button = $PanelContainer/Border/Background/MarginContainer/VBoxContainer/Back

func _ready() -> void:
	# Valores actuales (antes de conectar señales, para no disparar cambios)
	music_slider.value = Settings.music
	sfx_slider.value = Settings.sfx
	for r in Settings.RESOLUTIONS:
		resolution_option.add_item("%d x %d" % [r.x, r.y])
	resolution_option.select(Settings.resolution_index)
	fullscreen_check.button_pressed = Settings.fullscreen
	resolution_option.disabled = Settings.fullscreen

	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	resolution_option.item_selected.connect(_on_resolution_selected)
	fullscreen_check.toggled.connect(_on_fullscreen_toggled)
	back_button.pressed.connect(_close)

func _on_music_changed(value: float) -> void:
	Settings.music = value
	Settings.set_bus_volume("Music", value)

func _on_sfx_changed(value: float) -> void:
	Settings.sfx = value
	Settings.set_bus_volume("SFX", value)

func _on_resolution_selected(index: int) -> void:
	Settings.resolution_index = index
	Settings.apply_window()

func _on_fullscreen_toggled(on: bool) -> void:
	Settings.fullscreen = on
	resolution_option.disabled = on # la resolución solo cuenta en ventana
	Settings.apply_window()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause") or event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		_close()

func _close() -> void:
	Settings.save()
	closed.emit()
	queue_free()
