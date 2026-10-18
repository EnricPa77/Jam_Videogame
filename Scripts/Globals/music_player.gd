extends Node

const FADE_TIME := 1.0
const SILENT_DB := -80.0

var _players: Array[AudioStreamPlayer] = []
var _current := 0
var _stream: AudioStream = null
var _tween: Tween

func _ready() -> void:
	# Que siga sonando con el juego en pausa
	process_mode = Node.PROCESS_MODE_ALWAYS
	for i in 2:
		var p := AudioStreamPlayer.new()
		p.bus = "Music"
		p.volume_db = SILENT_DB
		add_child(p)
		_players.append(p)

func play(stream: AudioStream, fade := FADE_TIME) -> void:
	if stream == _stream:
		return # ya está sonando esta pista: no la reinicies
	_stream = stream

	var old := _players[_current]
	_current = 1 - _current
	var new := _players[_current]

	if _tween:
		_tween.kill()
	_tween = create_tween().set_parallel(true)

	if stream:
		_enable_loop(stream)
		new.stream = stream
		new.volume_db = SILENT_DB
		new.play()
		_tween.tween_property(new, "volume_db", 0.0, fade)
	_tween.tween_property(old, "volume_db", SILENT_DB, fade)
	_tween.chain().tween_callback(old.stop)

func _enable_loop(stream: AudioStream) -> void:
	if stream is AudioStreamOggVorbis or stream is AudioStreamMP3:
		stream.loop = true
