class_name Player
extends CharacterBody2D 

@onready var label:Label = $Label1
@onready var animations = $AnimatedSprite2D

const SPEED = 250.0
#important values
var vida:int = 200
var damage:int = 4

var canAttack:bool = true
var attack_s:bool = true
var enemyCol:bool = false
var enemy = null
var cont:int = 0

func _ready() -> void:
	print(vida)
func _process(delta: float) -> void:
	label.text = str(vida)
func _physics_process(delta: float) -> void:
	velocity.normalized()    
	GameOver()
	
#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#if enemy != null:
			##Attack(enemy, damage)
			#if enemy.vida <= 0:
				##vida += 10 
				#cont += 1
				#print("Contador enemigos: ", cont)     
				   #
  
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
		
func Attack_special(enemy, damage) -> void:
	if attack_s:
		enemy.vida -= damage
		$Timer2.start()
		attack_s = false

func _on_timer_timeout() -> void:
	canAttack = true


func _on_timer_2_timeout() -> void:
	attack_s = true
