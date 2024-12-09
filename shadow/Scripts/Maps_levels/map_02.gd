extends map_base

var dialog = [
	'luego lo pongo'
]

func _physics_process(delta: float) -> void:
	$map/spawn_enemy_2.spawn()
	$map/spawn_enemy_3.spawn()
	$map/spawn_enemy_4.spawn()
	$map/spawn_enemy_5.spawn()
