extends Control
@onready var label:Label = $Label 
func _ready() -> void:
	pass
	
func _input(event) -> void:
	label.text = str(event)
	pass
