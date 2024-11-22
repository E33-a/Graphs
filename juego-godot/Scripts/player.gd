class_name Player
extends CharacterBody2D 

@onready var label:Label = $Label1
@onready var animations = $AnimatedSprite2D

const SPEED = 250.0

var vida:int = 20
var damage:int = 4
var canAttack:bool = true
var enemyCol:bool = false
var enemy = null

func _ready() -> void:
	print(vida)
func _process(delta: float) -> void:
	label.text = str(vida)
func _physics_process(delta: float) -> void:
	velocity.normalized()    
	GameOver()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		#animations.play("attack")
		if enemy != null:
			Attack(enemy, damage)
			if enemy.vida <= 0:
				vida += 10      
				   
  
func GameOver() -> void:
	if vida <= 0:
		label.text = "Te moriste rey"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemy = body #cuerpo que esta entrando
		enemyCol = true
	else: 
		enemyCol = false 
	print(enemyCol)
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemyCol = false
		print(enemyCol)

func Attack(enemy, damage) -> void:
	if canAttack:
		enemy.vida -= damage
		$Timer.start()
		canAttack = false

func _on_timer_timeout() -> void:
	canAttack = true
