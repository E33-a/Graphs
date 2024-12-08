extends CharacterBody2D

@onready var area = $Area2D  # Asegúrate de que tienes un Area2D en el aliado.
@onready var animations = $AnimatedSprite2D  # Referencia a la animación del aliado
@onready var timer = $Timer  # Asegúrate de tener un temporizador si es necesario

@export var attack_range: float = 20.0
@export var SPEED = 80.0
@export var vida: int = 10
@export var damage: int = 2

var player = null
var canAttack: bool = true
var enemy_in_range: Node2D = null  # Almacena el enemigo dentro del rango de ataque

# Definir el nodo de la zona de ataque y conectarlo a las señales
func _ready() -> void:
	# Obtener referencia del jugador (si es necesario)
	player = get_node("/root/Map01/Mapa01/player")
	
	# Conectar el temporizador para el control de ataques
	#timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	
	# Iniciar la detección de enemigos en el spawn
	

# Lógica para atacar al enemigo
func attack(enemy: Node2D) -> void:
	if canAttack and enemy is CharacterBody2D:
		# Realizamos el ataque solo si podemos
		enemy.vida -= damage  # Restar vida al enemigo
		animations.play("attack")  # Reproducir animación de ataque
		print("Enemigo atacado!")
		
		# Iniciamos un temporizador para evitar ataques continuos sin pausa
		canAttack = false
		timer.start(1.0)  # Esperamos 1 segundo antes de poder atacar nuevamente

# Detectar enemigos dentro del rango de ataque
func _enemy_detection() -> void:
	# Aquí se detectan enemigos recién creados o enemigos cercanos al aliado
	var enemies_in_range = get_tree().get_nodes_in_group("enemies")  # Obtén todos los enemigos del grupo "enemies"
	
	for enemy in enemies_in_range:
		# Verificar si el enemigo está dentro del rango de ataque
		if position.distance_to(enemy.position) <= attack_range:
			enemy_in_range = enemy  # Guardamos el primer enemigo dentro del rango
			print("Enemigo detectado en el rango.")
			attack(enemy_in_range)  # Atacamos inmediatamente si está dentro del rango

# Movimiento hacia el enemigo si está fuera de rango
func _process(delta: float) -> void:
	
	# Si hay un enemigo en rango, mover al aliado hacia él
	if enemy_in_range:
		# Calcular la dirección hacia el enemigo
		var direction = (enemy_in_range.position - position).normalized()

		# Mover al aliado hacia el enemigo
		var velocity = direction * SPEED
		move_and_slide()

		# Reproducir animación de correr si se está moviendo
		if position.distance_to(enemy_in_range.position) > attack_range:
			animations.play("run")  # Reproducir animación de correr
			print("Moviéndome hacia el enemigo...")

		# Si el aliado está lo suficientemente cerca para atacar
		if position.distance_to(enemy_in_range.position) <= attack_range:
			attack(enemy_in_range)  # El aliado ataca al enemigo
			print("Atacando al enemigo...")
			animations.play("attack")  # Reproducir la animación de ataque

	elif not enemy_in_range:  # Si no hay enemigos en rango
		animations.play("idle")  # Reproducir animación de estar quieto
		print("No hay enemigos en rango. Animación idle.")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):  # Verificar si es un enemigo
		enemy_in_range = body  # Guardamos el enemigo dentro del rango
		print("Enemigo dentro del rango!")
		attack(enemy_in_range)  # Llamamos al ataque inmediatamente si está dentro del rango

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemy_in_range = null  # Limpiamos la referencia si el enemigo sale del área
		print("Enemigo fuera del rango.")

func _on_timer_timeout() -> void:
	canAttack = true  # Ahora el aliado puede volver a atacar
	print("Puede volver a atacar.")
