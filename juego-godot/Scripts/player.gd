class_name Player extends CharacterBody2D

@onready var label:Label = $Label1
@onready var animations:AnimatedSprite2D = $AnimatedSprite2D
@onready var camera:Camera2D = $Camera2D

#maximos y minimos del mapa
@onready var mn_X:int = self.owner.owner.min_x
@onready var mn_Y:int = self.owner.owner.min_y
@onready var mx_X:int = self.owner.owner.max_x
@onready var mx_Y:int = self.owner.owner.max_y
var diference:int = 48 #altura que difiere del mapa

#region important values
var SPEED = 250.0
var vida:int = 200
var damage:int = 4
var canAttack:bool = true
var attack_s:bool = true
var enemyCol:bool = false
var enemy = null
var cont:int = 0
#endregion

func _ready() -> void:
	#camera limits
	camera.limit_left = mn_X
	camera.limit_top = mn_Y
	camera.limit_right = mx_X
	camera.limit_bottom = mx_Y
	
	print(vida)
	
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
