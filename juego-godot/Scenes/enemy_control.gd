extends Node
@onready var enemy:Enemy_base = self.owner
@export var follow_distance:float = 50.0

var distance = null
var direction = null

enum STATE {
	IDLE,
	RUN,
	ATTACK,
	HURT,
	DEATH
} #DEFINIENDO LOS ESTADOS DEL PLAYER

#estado actual del player
var current_state:STATE = STATE.IDLE

func _physics_process(delta: float) -> void:
	enemy.delta_life = enemy.vida
		
	match current_state:
		STATE.IDLE:
			enemy.velocity = Vector2.ZERO
			enemy.animations.play("idle")
			
			#Cambios de estado
			if not enemy.playerCol:
				current_state = STATE.RUN
			elif enemy.playerCol and enemy.canAttack:
				current_state = STATE.ATTACK
			elif enemy.vida <= 0:
				current_state = STATE.DEATH
			elif enemy.playerCol and enemy.delta_life < enemy.vida:
				current_state = STATE.HURT
		STATE.RUN:
			if enemy.player != null:
				direction = enemy.global_position.direction_to(enemy.player.global_position)
				distance = enemy.global_position.distance_to(enemy.player.global_position)

			# Si está dentro del rango, moverse hacia el jugador
				if distance > follow_distance:
					enemy.velocity = direction * enemy.SPEED
				else:
					enemy.velocity = Vector2.ZERO  # Detenerse si está dentro de la distancia mínima
				if enemy.velocity.x > 0:
					enemy.animations.flip_h = false
				elif enemy.velocity.x < 0:
					enemy.animations.flip_h = true
				enemy.move_and_slide()
			
			#Cambios de estado
			if enemy.velocity == Vector2.ZERO and not enemy.playerCol:
				current_state = STATE.IDLE
			elif enemy.playerCol and enemy.canAttack:
				current_state = STATE.ATTACK
			elif enemy.playerCol and enemy.delta_life < enemy.vida:
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
	prints(current_state)  
	# Aplicar movimiento
	
