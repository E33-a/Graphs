extends CharacterBody2D

var Velocity:int = 400
var directionX = null 
var directionY = null
var vida:int = 10

func _physics_process(delta: float) -> void:
	directionX = Input.get_axis("ui_left", "ui_right")
	directionY = Input.get_axis("ui_up", "ui_down")
	velocity.x = directionX * Velocity
	velocity.y = directionY * Velocity
	
	velocity.normalized()
	move_and_slide()
