class_name enemy_abstract extends CharacterBody2D

@onready var animations = $AnimatedSprite2D
@export var attack_range:float = 15.0 #rango de ataque
@export var SPEED = 100.0
@export var vida:float = 100.0
@export var damage:float = 10.0


var player = null
var playerCol:bool = false
var canMove:bool = true
var canAttack:bool = true

func _ready() -> void:
	player = get_node("/root/Map/map/player")
	

func attack(player: CharacterBody2D, damage:int) -> void:
	if player.vida > 0:
		player.vida -= damage
		$Timer.start()
		canAttack = false
	else:
		return

func _on_timer_timeout() -> void:
	canAttack = true

func _on_area_2d_body_entered(body:Node2D) -> void:
	if is_attackable(body):
		canMove = false #se puede mover?
		playerCol = true
	else:
		playerCol = false
		return

func _on_area_2d_body_exited(body:Node2D) -> void:
	if is_attackable(body):
		canMove = true
		playerCol = false

func is_attackable(body:Node2D) -> bool:
	return body.name == "player" or body.is_in_group("allies")
