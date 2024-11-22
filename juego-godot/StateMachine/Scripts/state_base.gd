class_name StateBase extends Node
@onready var controlled_node:Node = self.owner 

func is_moving() -> bool:
	return Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")

var state_machine:StateMachine

#region common methods
#Al entrar al estado
func start():
	pass
#Al salir del estado
func end():
	pass
#endregion
