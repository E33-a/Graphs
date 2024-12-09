extends Area2D

@onready var enemy_basic = preload("res://Scenes/Characters/enemy_basic.tscn")
@onready var enemy_wizard = preload("res://Scenes/Characters/enemy_wizard.tscn")
@onready var enemy_death = preload("res://Scenes/Characters/enemy_death.tscn")
@export var no_enemies:int = 1

var active:bool = true
var cont:int = 0

func spawn() -> void:
	if active:
		$Timer.start()
		active = false
		var enemy_instance_basic = enemy_basic.instantiate()
		var enemy_instance_wizard = enemy_wizard.instantiate()
		var enemy_instance_death = enemy_death.instantiate()
		enemy_instance_basic.position = Vector2($".".position)
		enemy_instance_wizard.position = Vector2($".".position)
		enemy_instance_death.position = Vector2($".".position)
		add_child(enemy_instance_basic)
		add_child(enemy_instance_wizard)
		add_child(enemy_instance_death)

func _on_timer_timeout() -> void:
	cont += 1
	if cont < no_enemies:
		active = true
	else:
		$Timer.queue_free()
