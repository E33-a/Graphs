extends Node
@onready var player:Player = self.owner

enum STATE {
	IDLE,
	RUN,
	ATTACK,
	ATTACK_SPECIAL,
	HURT,
	DEATH
} #DEFINIENDO LOS ESTADOS DEL PLAYER

#estado actual del player
var current_state:STATE = STATE.IDLE

#region Important functions
func is_moving() -> bool:
	return Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_up") or Input.is_action_pressed("move_down")
func is_attack_basic() -> bool:
	return Input.is_action_just_pressed("attack_basic") and not Input.is_action_pressed("attack_special") and not is_moving() and player.canAttack
func is_attack_special() -> bool:
	return Input.is_action_pressed("attack_special") and not Input.is_action_just_pressed("attack_basic") and not is_moving() and player.attack_s
func moving(directionX, directionY) -> void:
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
#endregion

func _physics_process(delta: float) -> void:
	var directionX = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
			
	match current_state:
		STATE.IDLE:
			print("Estado: IDLE")
			player.animations.play("idle")
			#Cambios de estado
			if is_moving():
				current_state = STATE.RUN
			elif is_attack_basic():
				current_state = STATE.ATTACK
			elif is_attack_special():
				current_state = STATE.ATTACK_SPECIAL
			elif player.vida <= 0:
				current_state = STATE.DEATH
			elif player.enemyCol and not Input.is_action_pressed("attack_basic") and not Input.is_action_pressed("attack_special"):
				current_state = STATE.HURT
		STATE.RUN:
			print("Estado: RUN")
			moving(directionX, directionY)
			player.animations.play("run")
			
			#Cambios de estado
			if not is_moving():
				current_state = STATE.IDLE
			elif is_attack_basic():
				current_state = STATE.ATTACK
			elif is_attack_special():
				current_state = STATE.ATTACK_SPECIAL
			#elif player.enemyCol:
				#current_state = STATE.HURT
			elif player.vida <= 0:
				current_state = STATE.DEATH
		STATE.ATTACK:
			print("Estado: ATTACK")
			player.animations.play("attack")                            
			if player.enemyCol:  
				player.Attack(player.enemy, player.damage) 
			#cambios de estado
			if is_moving():
				current_state = STATE.RUN
			elif player.vida <= 0:
				current_state = STATE.DEATH
		STATE.ATTACK_SPECIAL:
			print("Estado: ATTACK_SPECIAL")
			player.animations.play("attack1")                            
			if player.enemyCol:  
				player.Attack_special(player.enemy, player.damage+10) 
			#cambios de estado
			if is_moving():
				current_state = STATE.RUN
			elif player.vida <= 0:
				current_state = STATE.DEATH
		STATE.HURT:
			print("Estado: HURT")
			player.animations.play("hurt")
			
			if not is_moving() and not player.enemyCol:
				current_state = STATE.IDLE
			elif is_moving():
				current_state = STATE.RUN
			elif player.vida <= 0:
				current_state = STATE.DEATH
			elif is_attack_basic():
				current_state = STATE.ATTACK
			elif is_attack_special():
				current_state = STATE.ATTACK_SPECIAL
		STATE.DEATH:
			print("Estado: DEATH")
			player.animations.play("death")
			await get_tree().create_timer(2.0).timeout #el timer recibe la cantidad de segundos que va a esperar
			print("Player is dead")
			player.queue_free()
	player.velocity.normalized()
	player.move_and_slide()
