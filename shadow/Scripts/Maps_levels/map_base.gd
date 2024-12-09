class_name map_base extends Node2D

@onready var audio:AudioStreamPlayer = $AudioStreamPlayer
@onready var failure = $CanvasLayer/Failure

var player:CharacterBody2D = null

var min_x = 0
var max_x = 1412
var min_y = 0
var max_y = 643

var end_dialog:bool = false
var active_spawn:bool = false	
var create_portal:bool = true

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

func check_enemies() -> void:
	# Obtén todos los nodos en el grupo "enemies"
	var enemies = get_tree().get_nodes_in_group("enemies")
	await get_tree().create_timer(4.0).timeout
	# Comprueba si no quedan nodos
	if enemies.is_empty():
		print("¡Todos los enemigos han sido eliminados!")
		#$map/Portal.visible = true
		if create_portal:
			$map/portal.position = Vector2($map/MarkerPortal.position)
			create_portal = false
	else:
		print("Aún quedan enemigos: %d" % enemies.size())
