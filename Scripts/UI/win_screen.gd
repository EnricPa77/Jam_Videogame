class_name WinScreen extends CanvasLayer

const MAIN_MENU := "res://Scenes/UI/main_menu.tscn" # ajusta la ruta

@onready var exit_to_menu_button: Button = %ExitToMenu
@onready var exit_button: Button = %Exit

func _ready() -> void:
	exit_to_menu_button.pressed.connect(_on_exit_to_menu_pressed)
	exit_button.pressed.connect(_on_exit_pressed)

	# Solo para probar la escena sola con F6
	if get_tree().current_scene == self:
		visible = true

func _on_exit_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU) 

func _on_exit_pressed() -> void:
	get_tree().quit()
