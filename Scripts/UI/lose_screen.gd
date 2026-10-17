extends CanvasLayer


@onready var retry_button: Button = %Retry

func _ready() -> void:
	visible = false
	retry_button.pressed.connect(_on_retry_pressed)

	# Solo para probar la escena sola con F6
	if get_tree().current_scene == self:
		visible = true

func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
