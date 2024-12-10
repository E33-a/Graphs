class_name speaker extends CharacterBody2D

@onready var animations:AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_attack:AudioStreamPlayer = $AudioStreamPlayer

var SPEED:float = 60.0
var target_position = Vector2(0, 15)
var canMove:bool = false
var speak:bool = false
var is_attacking:bool = false

# Inicia el movimiento hacia un destino
func start_moving(destination: Vector2) -> void:
	target_position = destination
	canMove = true
	speak = false
	is_attacking = false

func _physics_process(delta: float) -> void:
	if canMove:
		# Calcular la dirección hacia la posición objetivo
		var direction = (target_position - global_position).normalized()
		velocity = direction * SPEED

		# Si se alcanza el destino, detener el movimiento
		if global_position.distance_to(target_position) < 6:
			canMove = false
			speak = true
			is_attacking = true
			velocity = Vector2.ZERO
	move_and_slide()

func _process(delta: float) -> void:
	## Control de animaciones y ataque
	if speak and is_attacking and velocity == Vector2.ZERO:
		animations.play("base")
		if not audio_attack.playing:
			audio_attack.play()
		return  # Salimos para no ejecutar el resto del código

	# Control de otras animaciones
	if velocity != Vector2.ZERO:
		if velocity.x > 0:
			animations.flip_h = false
		elif velocity.x < 0:
			animations.flip_h = true
		if animations.animation != "run": 
			animations.play("run")
	elif velocity == Vector2.ZERO and not speak:
		if animations.animation != "idle":  # Cambia a "idle" si no está ya
			animations.play("idle")
#Funcion para salir cuando termina el dialogo inicial
func go_out(target_position:Vector2) -> void:
	var direction = (target_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	if animations.animation == "base":
		is_attacking = false  # Permite volver a mostrar la animacion
		speak = false  # Reinicia el estado de hablar
