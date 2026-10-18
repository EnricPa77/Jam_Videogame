extends CanvasLayer

const MAIN_MENU := "res://Scenes/UI/main_menu.tscn" 
const OPTIONS := preload("res://Scenes/UI/options_menu.tscn")

@onready var continue_button = $PanelContainer/Border/Background/MarginContainer/MarginContainer/VBoxContainer/Continue
@onready var options_button = $PanelContainer/Border/Background/MarginContainer/MarginContainer/VBoxContainer/Options
@onready var exit_to_menu_button = $PanelContainer/Border/Background/MarginContainer/MarginContainer/VBoxContainer/ExitToMenu
@onready var exit_button = $PanelContainer/Border/Background/MarginContainer/MarginContainer/VBoxContainer/Exit


var _was_paused := false

func _ready() -> void:
	visible = false
	continue_button.pressed.connect(resume)
	options_button.pressed.connect(_on_options_pressed)
	exit_to_menu_button.pressed.connect(_on_exit_to_menu_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("Pause"):
		return
	if visible:
		resume()
	else:
		pause()
	get_viewport().set_input_as_handled()

func pause() -> void:
	_was_paused = get_tree().paused
	get_tree().paused = true
	visible = true

func resume() -> void:
	get_tree().paused = _was_paused
	visible = false

func _on_options_pressed() -> void:
	var options := OPTIONS.instantiate()
	$PanelContainer.hide()
	options.closed.connect($PanelContainer.show)
	add_child(options)

func _on_exit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU)

func _on_exit_pressed() -> void:
	get_tree().quit()
