class_name Enemy_base
extends CharacterBody2D

const SPEED = 80.0

@onready var animations = $AnimatedSprite2D

var vida:int = 10
var delta_life:int = 0
var player = null
var damage:int = 2
var playerCol:bool = false
var canMove:bool = true
var canAttack:bool = true

func _ready() -> void:
	player = get_node("/root/Map01/Node2D/Player/player")

func attack(player: CharacterBody2D, damage:int) -> void:
	if player.vida > 0:
		player.vida -= damage
		$Timer.start()
		canAttack = false
	else:
		return


func _on_timer_timeout() -> void:
	canAttack = true
	#if playerCol and canAttack:
		#attack(player, damage)
	#else:
		#return


func _on_area_2d_body_entered(body: Node2D) -> void:
	canMove = false #se puede mover?
	if body.name == "player":
		playerCol = true
		#attack(body, damage)
	else:
		playerCol = false
		return


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		canMove = true
		playerCol = false
