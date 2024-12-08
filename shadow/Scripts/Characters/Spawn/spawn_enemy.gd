extends Area2D

@onready var Enemy = preload("res://Scenes/Characters/enemy_basic.tscn")
@export var no_enemies:int = 10

var active:bool = true
var cont:int = 0

func _process(delta: float) -> void:
	spawn()
	
func spawn() -> void:
	if active:
		$Timer.start()
		active = false
		var enemy_instance = Enemy.instantiate()
		enemy_instance.position = Vector2($".".position)
		add_child(enemy_instance)


func _on_timer_timeout() -> void:
	cont += 1
	if cont < no_enemies:
		active = true
	else:
		$Timer.queue_free()
