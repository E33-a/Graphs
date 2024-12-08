extends map_base

@onready var dialogue = $CanvasLayer/Dialogue
@onready var king:CharacterBody2D = $map/King
@onready var marker:Marker2D = $map/Marker2D

var dialog = [
	'Rey Aniriel: ¡EIRION! LA CIUDAD ESTÁ ASEDIADA, ¡DEBES DEFENDERLA! El ejercito de Ankor nos ha acorralado, la defensa de la ciudad esta en tus manos, se que tienes el poder suficiente para poder enfrentar al mal, al igual que tu padre, te deseo suerte',
	'Rey Aniriel: Para moverte utiliza W (arriba), S (abajo), A (izquierda), D (derecha), para atacar L (ataque basico) o K (ataque especial) minetras no te muevas.',
	'Rey Aniriel: Ten cuidado con los enemigos, tienen diferente daño y velocidad, no dejes que acaben contigo, Toria y el mundo te necesita.',
	'Eirion: Lo entiendo mi rey, no se que fuerza este en mi pero luchare hasta que el ultimo suspiro parta de mi pecho, como la oscuridad que parte con la luz.',
	'Eirion: La ciudad no caera mientras tenga fuerzas para defenderla, se lo jure a mi padre que antes de que diera su vida por nuestra libertad, refugiese mi rey, aun no puede pelear, yo me encargo!'
]

var end_dialog:bool = false

func _physics_process(delta: float) -> void:
	if king != null:
		if king.global_position.distance_to(Vector2(680,270)) < 5:
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
				
func _process(delta: float) -> void:
	if player == null:
		get_tree().paused = true
		$Failure.visible = true
		
		
