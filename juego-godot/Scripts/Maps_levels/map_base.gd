class_name map_base extends Node2D

@onready var audio:AudioStreamPlayer = $AudioStreamPlayer

var player:CharacterBody2D = null

var min_x = 0
var max_x = 1412
var min_y = 0
var max_y = 643

func _ready() -> void:
	player = get_node("/root/Map/map/player")
	get_tree().paused = false
	#audio.play()
