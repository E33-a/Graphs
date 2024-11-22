extends StateBase

func on_physics_process(delta: float) -> void:
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	if controlled_node == null:
		if directionX:
			controlled_node.velocity.x = directionX * controlled_node.SPEED
			if directionX > 0:
				controlled_node.animations.flip_h = false
			elif directionX < 0:
				controlled_node.animations.flip_h = true
		else:
			controlled_node.velocity.x = move_toward(controlled_node.velocity.x, 0, controlled_node.SPEED)
		if directionY:
				controlled_node.velocity.y = directionY * controlled_node.SPEED
		else:
			controlled_node.velocity.y = move_toward(controlled_node.velocity.y, 0, controlled_node.SPEED)
		
		controlled_node.animations.play("run")
		
	controlled_node.move_and_slide()
	
func on_input(event):
	if not is_moving():
		state_machine.change_to("StateIdle")
	#elif Input.is_action_pressed("ui_accept") and player.canAttack and not is_moving()         :
		#current_state = STATE.ATTACK
	#elif player.enemyCol:
		#current_state = STATE.HURT
	#elif player.vida <= 0:
		#current_state = STATE.DEATH
