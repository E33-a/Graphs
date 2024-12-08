extends CharacterBody2D

@onready var animations = $AnimatedSprite2D

var attack_range:float = 20.0 #rango de ataque
var SPEED = 100.0
var vida:int = 20
var delta_life:int = 0
var player = null
var damage:int = 4
var playerCol:bool = false
var canMove:bool = true
var canAttack:bool = true

func _ready() -> void:
	player = get_node("/root/Map01/Characters/Player/player")
	

func attack(player: CharacterBody2D, damage:int) -> void:
	if player.vida > 0:
		player.vida -= damage
		$Timer.start()
		canAttack = false
	else:
		return

func _on_timer_timeout() -> void:
	canAttack = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "player":
		canMove = false #se puede mover?
		playerCol = true
	else:
		playerCol = false
		return

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		canMove = true
		playerCol = false
