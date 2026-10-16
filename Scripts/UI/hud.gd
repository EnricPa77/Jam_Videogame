extends CanvasLayer

@export var level_clock: Clock

@onready var red_button: TextureButton = %Red
@onready var green_button: TextureButton = %Green
@onready var clock_value: Label = %ClockValue

func _ready() -> void:
	# Los dos botones forman un par: solo uno activo a la vez
	var group := ButtonGroup.new()
	for b in [red_button, green_button]:
		b.toggle_mode = true
		b.button_group = group

	# Estado base visual: rojo
	red_button.button_pressed = true
	red_button.pressed.connect(_on_red_pressed)
	green_button.pressed.connect(_on_green_pressed)

	# Reloj del nivel
	if level_clock:
		level_clock.time_changed.connect(_on_time_changed)
		_on_time_changed(level_clock.hour, level_clock.minutes)

func _on_time_changed(hour: int, minutes: int) -> void:
	clock_value.text = "%02d:%02d" % [hour, minutes]

func _on_red_pressed() -> void:
	get_tree().call_group("traffic_lights", "set_stop", true)

func _on_green_pressed() -> void:
	get_tree().call_group("traffic_lights", "set_stop", false)
