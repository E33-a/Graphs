class_name map_base extends Node2D

@onready var audio:AudioStreamPlayer = $AudioStreamPlayer
@onready var failure = $Failure

var player:CharacterBody2D = null

var min_x = 0
var max_x = 1412
var min_y = 0
var max_y = 643

func _ready() -> void:
	player = get_node("/root/Map/map/player")
	get_tree().paused = false
	audio.play()

func _process(delta: float) -> void:
	if player == null:
		var camera:Camera2D = Camera2D.new()
		add_child(camera)
		camera.limit_left = 0
		camera.limit_right = 1412
		camera.limit_top = 0
		camera.limit_bottom = 648
		camera.position = Vector2(1412 / 2, 648 / 2)
		camera.zoom = Vector2(2.3, 2.3)
		camera.offset = Vector2.ZERO
		get_tree().paused = true
		$Failure.visible = true
