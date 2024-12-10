extends map_base

@onready var lackey_speaker:CharacterBody2D = $map/Lackey_speaker
@onready var marker:Marker2D = $map/Marker2D
@onready var dialogue = $CanvasLayer/Dialogue

@onready var lackey_real = preload("res://Scenes/Characters/enemy_lackey.tscn")

var dialog = [
	"Lackey: Veo que has logrado defender a Toria, ¡AHAHAHA! Pero dime, ¿realmente crees que las fuerzas de mi amo Ankor terminan aquí? Tu mundo se hundirá en la penumbra de nuestra maldad, y no quedará rastro de tu luz.",
	"Eirion: Guarda tu hedionda boca, criatura de las sombras. Mientras una chispa de esperanza arda en los corazones de los hombres, no caeremos. Te juro que acabaré contigo y con tu amo, como el agua extingue al fuego. No habrá piedad para ninguno de ustedes.",
	"Lackey: Jajaja, eres tan ingenuo como tu padre. Morirás igual que él, insignificante. No hay grandeza en ti. Cuando acabe contigo, tu cuerpo será corrompido, un esclavo de las sombras. Verás a tu pueblo y al mundo perecer en las llamas de la guerra, y serás testigo de su agonía eterna.",
	"Eirion: Si mi destino es morir, que así sea. Pero no hoy. Hoy es tu fin. Por Toria y por mi gente, estoy listo. Prepárate, monstruo. Aquí estoy.",
	"Lackey: ¡Esta será tu perdición!",
	"Eirion: ¡Muerte! ¡Muerte! ¡Muerteeeeeee!"
]

var path:String = "res://Scenes/Levels/map_03.tscn"

func _physics_process(delta: float) -> void:
	check_enemies()
	if lackey_speaker != null:
		if lackey_speaker.global_position.distance_to(Vector2(700, 313)) < 6:
			print("ya llego")
			if dialogue != null:
				dialogue.visible = true
			else:
				end_dialog = true
				print("acabo el dialogo")
		if dialogue == null and end_dialog:
			lackey_speaker.go_out(marker.position)
			if lackey_speaker.global_position.distance_to(marker.position) < 5:
				lackey_speaker.queue_free()
				var enemy_lackey_real = lackey_real.instantiate() 
				enemy_lackey_real.position = Vector2(marker.position)
				$map.add_child(enemy_lackey_real)
				active_spawn = true
	if active_spawn:
		$map/spawn_enemy_2.spawn()
		$map/spawn_enemy_3.spawn()
		$map/spawn_enemy_4.spawn()
		$map/spawn_enemy_5.spawn()
		
		
