extends CharacterBody2D 
@onready var label:Label = $Label1
@onready var animations = $AnimatedSprite2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var vida:int = 20
var damage:int = 4
var canAttack:bool = true
var enemyCol:bool = false
var enemy = null

func _ready() -> void:

	print(vida)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	if directionX:
		velocity.x = directionX * SPEED
		animations.play("run")
		if directionX > 0:
			animations.flip_h = false
		else:
			animations.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if directionY:
			velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	velocity.normalized()
	move_and_slide()

	label.text = str(vida)
	GameOver()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if enemy != null:
			Attack(enemy, damage)
			if enemy.vida <= 0:
				vida += 10      
				   
  
func GameOver() -> void:
	if vida <= 0:
		queue_free()
		label.text = "Te moriste rey"

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("spike"):
		vida -= 2
	if body.is_in_group("enemies"):
		enemy = body #cuerpo que esta entrando
		enemyCol = true
	else: 
		enemyCol = false 
	print(enemyCol)
		
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemyCol = false
		print(enemyCol)

func Attack(enemy, damage) -> void:
	if canAttack:
		enemy.vida -= damage
		$Timer.start()
		canAttack = false

func _on_timer_timeout() -> void:
	canAttack = true
