extends map_base
#mapa1
@onready var dialogue = $CanvasLayer/Dialogue
@onready var king:CharacterBody2D = $map/King
@onready var marker:Marker2D = $map/Marker2D

var dialog = [
	'Rey Aniriel: ¡EIRION! ¡LA CIUDAD ESTÁ ASEDIADA! ¡DEBES DEFENDERLA! El ejército de Ankor nos ha acorralado. La defensa de nuestra tierra está ahora en tus manos. Sé que, en lo más profundo de tu ser, posees el poder que nos une a todos, como lo tuvo tu padre. La luz que arde en ti es la misma que derrotó la oscuridad en su tiempo. Te deseo suerte, pero más aún, te deseo la fortaleza para reconocer tu destino.',
	'Rey Aniriel: Para moverte, usa W (arriba), S (abajo), A (izquierda), D (derecha). Y para atacar, usa L (ataque básico) o K (ataque especial). Pero recuerda, no solo el cuerpo se mueve. Tu alma debe estar en armonía con cada movimiento. Cada golpe que des no es solo un acto de fuerza, sino una manifestación de tu voluntad interior.',
	'Rey Aniriel: Ten cuidado, Eirion. Los enemigos que se alzan contra nosotros no son solo sombras físicas, son la representación del caos y la destrucción. Cada uno tiene su propia esencia: un daño, una velocidad, una intención. No subestimes sus motivaciones, ni te dejes consumir por la ira. La serenidad será tu mayor aliada, pues el mundo que conocemos depende de la calma que se encuentra dentro de ti.',
	'Eirion: Lo entiendo, mi rey. Hay algo que arde en mí, algo más grande que yo, algo ancestral que me empuja a luchar. No sé si esa fuerza es un legado o una prueba del destino, pero lucharé hasta el último de mis suspiros, hasta que mi cuerpo se convierta en la tierra que protejo. La oscuridad puede rodearme, pero siempre se disipa ante la luz que hay en mí.',
	'Eirion: La ciudad no caerá mientras mi corazón siga latiendo. Se lo prometí a mi padre, a aquel que dio su vida por nuestra libertad. Y lo juré a las estrellas, que miran desde el principio de los tiempos. ¡Refúgiate, mi rey! El momento de la lucha ha llegado para mí. Tú aún no puedes pelear, pero yo, con la fuerza del sacrificio y la esperanza, me encargaré. Mi vida es ahora una llama que se extiende en esta oscuridad, y hasta el último resplandor será por Toria.'
]

#var end_dialog:bool = false
#var active_spawn:bool = false	
#var create_portal:bool = true
var path:String = "res://Scenes/Levels/map_02.tscn"

func _physics_process(delta: float) -> void:
	check_enemies()
	if king != null:
		if king.global_position.distance_to(Vector2(680,270)) < 6:
			print("ya llego")
			if dialogue != null:
				dialogue.visible = true
			else:
				end_dialog = true
				print("acabo el dialogo")
		if dialogue == null and end_dialog:
			king.go_out(marker.position)
			if king.global_position.distance_to(marker.position) < 5:
				king.queue_free()
				active_spawn = true
	if active_spawn:
		$map/spawn_enemy1.spawn()
		$map/spawn_enemy2.spawn()
		$map/spawn_enemy3.spawn()

#func check_enemies() -> void:
	## Obtén todos los nodos en el grupo "enemies"
	#var enemies = get_tree().get_nodes_in_group("enemies")
	#await get_tree().create_timer(4.0).timeout
	## Comprueba si no quedan nodos
	#if enemies.is_empty():
		#print("¡Todos los enemigos han sido eliminados!")
		##$map/Portal.visible = true
		#if create_portal:
			#$map/portal.position = Vector2($map/MarkerPortal.position)
			#create_portal = false
	#else:
		#print("Aún quedan enemigos: %d" % enemies.size())
