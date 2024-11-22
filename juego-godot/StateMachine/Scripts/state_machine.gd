class_name StateMachine extends Node

#Nodo controlado
@onready var controlled_node = self.owner

#base state
@export var default_state:StateBase
#state in moment
var current_state:StateBase = null
#region methods
func _ready() -> void:
	#Se ejecuta solo cuando todos los nodos estan ready
	call_deferred("_state_default_start ")
	
func _state_default_start():
	current_state = default_state
	_state_start()
#preparar new state y preparar su start
func _state_start() -> void:
	prints("StateMachine", controlled_node.name, "start state", current_state.name)
	#configure the state
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()
	
func change_to(new_state:String) -> void:
	if current_state and current_state.has_method("end"): current_state.end()
	current_state = get_node(new_state)
	_state_start()
#endregion
#region metodos que se ejecutan solos
func _process(delta: float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)
func _physics_process(delta: float) -> void:
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)
func _input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_input"):
		current_state.on_input(event)
func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)
func _unhandled_key_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_key_input"):
		current_state.on_unhandled_key_input(event)
#endregion
