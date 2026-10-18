extends Node

const CLICK := preload("res://Assets/Audio/SFX/light_sfx.wav")

var _player: AudioStreamPlayer

func _ready() -> void:
	# Que suene también con el juego en pausa (menú de pausa, opciones)
	process_mode = Node.PROCESS_MODE_ALWAYS
	_player = AudioStreamPlayer.new()
	_player.stream = CLICK
	_player.bus = "SFX"
	add_child(_player)
	# Cada nodo que entra en el árbol se revisa; si es un botón, se engancha
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node) -> void:
	if node is BaseButton and not node.is_in_group("no_click_sound"):
		node.pressed.connect(play_click)

func play_click() -> void:
	_player.play()
