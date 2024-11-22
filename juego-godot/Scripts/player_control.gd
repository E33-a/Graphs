extends Node
@onready var player:Player = self.owner

enum STATE {
	IDLE,
	RUN,
	ATTACK,
	HURT,
	DEATH
} #DEFINIENDO LOS ESTADOS DEL PLAYER

#estado actual del player
var current_state:STATE = STATE.IDLE

func is_moving() -> bool:
	return Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")

func _physics_process(delta: float) -> void:
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
			
	match current_state:
		STATE.IDLE:
			print("Estado: IDLE")
			player.animations.play("idle")
			
			#Cambios de estado
			if is_moving():
				current_state = STATE.RUN
			elif Input.is_action_just_pressed("ui_accept") and not is_moving():
				current_state = STATE.ATTACK
			elif player.vida <= 0:
				current_state = STATE.DEATH
			elif player.enemyCol and not Input.is_action_pressed("ui_accept"):
				current_state = STATE.HURT
		STATE.RUN:
			print("Estado: RUN")
			if directionX:
				player.velocity.x = directionX * player.SPEED
				if directionX > 0:
					player.animations.flip_h = false
				elif directionX < 0:
					player.animations.flip_h = true
			else:
				player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
			if directionY:
					player.velocity.y = directionY * player.SPEED
			else:
				player.velocity.y = move_toward(player.velocity.y, 0, player.SPEED)
			
			player.animations.play("run")
			
			#Cambios de estado
			if not is_moving():
				current_state = STATE.IDLE
			elif Input.is_action_pressed("ui_accept") and player.canAttack and not is_moving()         :
				current_state = STATE.ATTACK
			elif player.enemyCol:
				current_state = STATE.HURT
			elif player.vida <= 0:
				current_state = STATE.DEATH
		STATE.ATTACK:
			print("Estado: ATTACK")
			player.animations.play("attack1")                            
			if player.enemyCol:  
				
				player.Attack(player.enemy, player.damage) 

			#cambios de estado
			if is_moving():
				current_state = STATE.RUN
			elif player.vida <= 0:
				current_state = STATE.DEATH
			#elif player.enemyCol:
				#current_state = STATE.HURT
		STATE.HURT:
			print("Estado: HURT")
			player.animations.play("hurt")
			
			if not is_moving() and not player.enemyCol:
				current_state = STATE.IDLE
			elif is_moving():
				current_state = STATE.RUN
			elif player.vida <= 0:
				current_state = STATE.DEATH
			elif Input.is_action_pressed("ui_accept") and player.canAttack:
				current_state = STATE.ATTACK
		STATE.DEATH:
			print("Estado: DEATH")
			player.animations.play("death")
			# Esperar la duración de la animación en seg
			await get_tree().create_timer(2.0).timeout #el timer recibe la cantidad de segundos
			print("Player is dead")
			player.queue_free()
	player.velocity.normalized()
	player.move_and_slide()
