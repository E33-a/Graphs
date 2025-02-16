extends Area2D

@onready var e_basic = preload("res://Scenes/Characters/enemy_basic.tscn")
@onready var e_wizard = preload("res://Scenes/Characters/enemy_wizard.tscn")
@onready var e_death = preload("res://Scenes/Characters/enemy_death.tscn")
@onready var e_demon = preload("res://Scenes/Characters/enemy_demon.tscn")
@onready var e_necromance = preload("res://Scenes/Characters/enemy_necromance.tscn")

@export var no_enemies:int = 1

var active:bool = true
var cont:int = 0

func spawn() -> void:
	if active:
		$Timer.start()
		active = false
		var enemy_instance_basic = e_basic.instantiate()
		var enemy_instance_wizard = e_wizard.instantiate()
		var enemy_instance_death = e_death.instantiate()
		var enemy_instance_demon = e_demon.instantiate()
		var enemy_instance_necromance = e_necromance.instantiate()
		enemy_instance_basic.position = Vector2($".".position)
		enemy_instance_wizard.position = Vector2($".".position)
		enemy_instance_death.position = Vector2($".".position)
		enemy_instance_demon.position = Vector2($".".position)
		enemy_instance_necromance.position = Vector2($".".position)
		add_child(enemy_instance_basic)
		add_child(enemy_instance_wizard)
		add_child(enemy_instance_death)
		add_child(enemy_instance_demon)
		add_child(enemy_instance_necromance)

func _on_timer_timeout() -> void:
	cont += 1
	if cont < no_enemies:
		active = true
	else:
		$Timer.queue_free()
