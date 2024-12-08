extends Node
@onready var enemy:CharacterBody2D = self.owner

var distance = null
var direction = null

enum STATE {
	IDLE,
	RUN,
	ATTACK,
	HURT,
	DEATH
} #DEFINIENDO LOS ESTADOS
#estado actual
var current_state:STATE = STATE.IDLE

func player_attack() -> bool:
	return Input.is_action_just_pressed("attack_basic") or Input.is_action_just_pressed("attack_special")
func is_hurt() -> bool:
	return enemy.playerCol and enemy.player.canAttack and not enemy.canAttack
	
func _physics_process(delta: float) -> void:
	enemy.global_position.x = clamp(enemy.global_position.x, 0, 1412)
	enemy.global_position.y = clamp(enemy.global_position.y, 0, 643)
	
	match current_state:
		STATE.IDLE:
			enemy.velocity = Vector2.ZERO
			enemy.animations.play("idle")
			
			#Cambios de estado
			if not enemy.playerCol and enemy.canMove and enemy.player != null:
				current_state = STATE.RUN
			elif enemy.playerCol and enemy.canAttack:
				current_state = STATE.ATTACK
			elif enemy.vida <= 0:
				current_state = STATE.DEATH
			elif is_hurt() and player_attack():
				current_state = STATE.HURT
		STATE.RUN:
			enemy.animations.play("run")
			if enemy.player != null:
				direction = enemy.global_position.direction_to(enemy.player.global_position)
				distance = enemy.global_position.distance_to(enemy.player.global_position)
			if distance > enemy.attack_range:
					enemy.velocity = direction * enemy.SPEED
			else:
				enemy.canMove = false
			
			if enemy.velocity.x > 0:
				enemy.animations.flip_h = false
			elif enemy.velocity.x < 0:
				enemy.animations.flip_h = true
			
			#Cambios de estado
			if enemy.velocity == Vector2.ZERO and not enemy.playerCol:
				current_state = STATE.IDLE
			elif enemy.playerCol and enemy.canAttack:
				current_state = STATE.ATTACK
			elif is_hurt() and player_attack():
				current_state = STATE.HURT
			elif enemy.vida <= 0:
				current_state = STATE.DEATH
		STATE.ATTACK:                       			
			enemy.animations.play("attack")
			if enemy.player != null and enemy.canAttack:  
				enemy.attack(enemy.player, enemy.damage) 
			
			#cambios de estado
			if enemy.canMove and not enemy.playerCol:
				current_state = STATE.RUN
			elif enemy.vida <= 0:
				current_state = STATE.DEATH
			elif is_hurt() and player_attack():
				current_state = STATE.HURT
			elif enemy.player.vida <= 0:
				current_state = STATE.IDLE
		STATE.HURT:
			enemy.animations.play("hurt")
			
			if enemy.player.vida <= 0:
				current_state = STATE.IDLE
			elif enemy.canMove:
				current_state = STATE.RUN
			elif enemy.vida <= 0:
				current_state = STATE.DEATH
			elif enemy.playerCol:
				current_state = STATE.ATTACK
		STATE.DEATH:
			enemy.animations.play("death")
			# Esperar la duración de la animación en seg
			await get_tree().create_timer(2.0).timeout #el timer recibe la cantidad de segundos
			print("Enemy is dead")
			enemy.queue_free()
	#prints("Enemy: ", current_state)  
	enemy.move_and_slide()
