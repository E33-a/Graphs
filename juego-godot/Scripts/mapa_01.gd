extends Node

@onready var audio = $AudioStreamPlayer

var min_x = 0
var max_x = 1422
var min_y = 0
var max_y = 648

func _ready() -> void:
	audio.play()

func _process(delta: float) -> void:
	if get_tree().paused:
		audio.stop()
	if not audio.playing:
		audio.play()
