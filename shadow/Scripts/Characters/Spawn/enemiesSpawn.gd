extends Node
@onready var enemy = preload("res://Scenes/enemy.tscn")
#@onready var enemy_death = preload("res://Scenes/enemy_death.tscn")
@onready var spawn1 = $spawn1

var cont:int = 0

func _on_timer_timeout() -> void:
	var enemyI = enemy.instantiate()
	#var enemyII = enemy_death.instantiate()
	spawn1.add_child(enemyI)
	#spawn1.add_child(enemyII)
	
	cont += 1
	if cont == 7:
		$Timer.queue_free()
	
