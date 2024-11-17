extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -400.0

@onready var animations = $AnimatedSprite2D

var vida:int = 10
var player = null
var damage:int = 2
var playerCol:bool = false
var canMove:bool = true

func _ready() -> void:
	player = get_node("/root/Node2D/Player/player")
	

func _physics_process(delta: float) -> void:
	if player != null and canMove:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * SPEED
	move_and_slide()#checa esto
	dead()
	
func attack(player: CharacterBody2D, damage:int) -> void:
	if player.vida != null:
		player.vida -= damage
		$Timer.start()
	else:
		return
	
func dead() -> void:
	if vida <= 0:
		queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	canMove = true #se puede mover?
	var cont:int = 0
	if body.name == "player":
		animations.play("attack")
		playerCol = true
		attack(body, damage)
	else:
		return

func _on_timer_timeout() -> void:
	if playerCol and player != null:
		attack(player, damage)
	else:
		return

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "player":
		animations.play("run")
		canMove = true
		playerCol = false
