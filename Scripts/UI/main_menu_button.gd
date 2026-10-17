extends Button

@export var glow_color := Color("3CC85A")
@export var run_default_action := true

const BG := Color("141418")
const BORDER_IDLE := Color("34363E")

func _ready() -> void:
	var idle := _make_style(BORDER_IDLE, false)
	var active := _make_style(glow_color, true)
	add_theme_stylebox_override("normal", idle)
	add_theme_stylebox_override("hover", active)
	add_theme_stylebox_override("pressed", active)
	add_theme_stylebox_override("focus", active)

	mouse_entered.connect(grab_focus)  # ratón y teclado comparten estado
	mouse_exited.connect(release_focus)

func _make_style(border: Color, glow: bool) -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = BG
	s.set_border_width_all(2)
	s.border_color = border
	if glow:
		s.shadow_color = Color(border, 0.5)
		s.shadow_size = 10
	return s


func _on_pressed():
	if not run_default_action:
		return
	get_tree().paused = false
	visible = false
