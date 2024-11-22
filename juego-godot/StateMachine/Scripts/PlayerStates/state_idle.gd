extends StateBase

func on_physics_process(delta: float) -> void:
	controlled_node.animations.play("idle")
	if is_moving():
		state_machine.change_to("StateRun")
	controlled_node.move_and_slide()
