extends CanvasLayer

@export var level_clock: Clock
@export var max_towers := 2
@export var tower_icon_off: Texture2D
@export var tower_icon_on: Texture2D

@onready var towers_icon: TextureRect = %TowersIcon
@onready var red_button: TextureButton = %Red
@onready var green_button: TextureButton = %Green
@onready var clock_value: Label = %ClockValue
@onready var towers_group: Control = %TowersGroup
@onready var towers_count: Label = %TowersCount
@onready var start_button: Control = %Start

func _ready() -> void:
	var group := ButtonGroup.new()
	for b in [red_button, green_button]:
		b.toggle_mode = true
		b.button_group = group

	red_button.button_pressed = true
	red_button.pressed.connect(_on_red_pressed)
	green_button.pressed.connect(_on_green_pressed)
	
	if level_clock:
		level_clock.time_changed.connect(_on_time_changed)
		_on_time_changed(level_clock.hour, level_clock.minutes)
	_on_red_pressed.call_deferred()
	var world := get_parent() as World
	if world:
		world.towers_selected_changed.connect(_on_towers_changed)
		_on_towers_changed(world.towers_selected)

	# La sección solo se ve antes de START
	start_button.visibility_changed.connect(_on_start_visibility_changed)

func _on_time_changed(hour: int, minutes: int) -> void:
	clock_value.text = "%02d:%02d" % [hour, minutes]

func _on_red_pressed() -> void:
	get_tree().call_group("traffic_lights", "set_stop", true)

func _on_green_pressed() -> void:
	get_tree().call_group("traffic_lights", "set_stop", false)

func _on_towers_changed(count: int) -> void:
	towers_count.text = "%d/%d" % [count, max_towers]
	towers_icon.texture = tower_icon_on if count >= max_towers else tower_icon_off

func _on_start_visibility_changed() -> void:
	towers_group.visible = start_button.visible
