class_name Tutorial
extends CanvasLayer

static var seen := false # persiste mientras el juego esté abierto, aunque se recargue el nivel

const PAGES := [
	{"title": "RADIO TOWERS", "text": "Select two radio towers before pressing START. They calm down cars stopped at traffic lights."},
	{"title": "TRAFFIC LIGHTS", "text": "Click a light to stop or release the traffic. Use the red and green buttons to change all of them."},
	{"title": "THE CLOCK", "text": "Survive until 22:00 and clear the roads to win. You’ve also got a progress bar!"},
	{"title": "CRASHES", "text": "Two cars crash and you are out. Good luck!"},
]

var _page := 0

@onready var title: Label = %Title
@onready var body: Label = %Body
@onready var page_label: Label = %Page
@onready var next_button: Button = %Next
@onready var back_button: Button = %Back
@onready var skip_button: Button = %Skip

func _ready() -> void:
	if seen:
		queue_free()
		return
	show()
	get_tree().call_group("pause_menu", "set_process_unhandled_input", false)
	next_button.pressed.connect(_on_next)
	back_button.pressed.connect(_on_back)
	skip_button.pressed.connect(_close)
	await get_tree().process_frame
	_show_page()

func _show_page() -> void:
	var p: Dictionary = PAGES[_page]
	title.text = p["title"]
	body.text = p["text"]
	page_label.text = "%d/%d" % [_page + 1, PAGES.size()]
	next_button.text = "GOT IT" if _page == PAGES.size() - 1 else "NEXT"
	back_button.visible = _page > 0

func _on_next() -> void:
	if _page >= PAGES.size() - 1:
		_close()
		return
	_page += 1
	_show_page()

func _on_back() -> void:
	if _page <= 0:
		return
	_page -= 1
	_show_page()

func _close() -> void:
	seen = true
	get_tree().call_group("pause_menu", "set_process_unhandled_input", true)
	queue_free()
