class_name Player extends CharacterBody2D

@onready var progress_bar:Bar_health = $ProgressBar
@onready var animations:AnimatedSprite2D = $AnimatedSprite2D
@onready var camera:Camera2D = $Camera2D
@onready var audio_attack_basic:AudioStreamPlayer = $AudioAttackBasic
@onready var audio_attack_special:AudioStreamPlayer = $AudioAttackSpecial
@onready var AttackTimer = $AttackTimer
#maximos y minimos del mapa
@onready var mn_X:int = self.owner.min_x
@onready var mn_Y:int = self.owner.min_y
@onready var mx_X:int = self.owner.max_x
@onready var mx_Y:int = self.owner.max_y
var diference:int = 48 #altura que difiere del mapa

#region important values
@export var SPEED = 250.0
@export var vida:float = 100.0
@export var damage:float = 20.0
var canAttack:bool = true
var attack_s:bool = true
var enemyCol:bool = false
var enemy = null
var cont:int = 0
var regenerate_life:bool = true
#endregion

func _ready() -> void:
	#camera limits
	camera.limit_left = mn_X
	camera.limit_top = mn_Y
	camera.limit_right = mx_X
	camera.limit_bottom = mx_Y
	print(vida)
	progress_bar.update_life(vida)  # Sincronizar barra al inicio
	
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
		#audio_attack_basic.play()
		enemy.vida -= damage
		$Timer.start()
		canAttack = false
		
func Attack_special(enemy, damage) -> void:
	if attack_s:
		#audio_attack_special.play()
		enemy.vida -= damage
		$Timer2.start()
		attack_s = false
		
func regenerate() -> void:
	if regenerate_life and vida < 100:
		vida += 10
		$Regenerate.start()
		regenerate_life = false
		if vida > 100:
			vida = 100
	
func _on_timer_timeout() -> void:
	canAttack = true

func _on_timer_2_timeout() -> void:
	attack_s = true
	
func _on_regenerate_timeout() -> void:
	regenerate_life = true
