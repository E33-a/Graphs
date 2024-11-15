extends Node
@onready var enemy = preload("res://Scenes/enemy.tscn")
@onready var spawn1 = $spawn1
func _on_timer_timeout() -> void:
	var enemyI = enemy.instantiate()
	spawn1.add_child(enemyI)
	
