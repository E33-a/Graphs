extends Node2D
var original_position
func _ready():
	original_position = position
func _process(delta):
	position = original_position
