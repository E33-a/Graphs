extends map_base

@onready var ankor_speaker:CharacterBody2D = $map/Ankor_speaker
@onready var marker:Marker2D = $map/Marker2D
@onready var dialogue = $CanvasLayer/Dialogue

@onready var lackey_real = preload("res://Scenes/Characters/enemy_lackey.tscn")
@onready var ankor_real = preload("res://Scenes/Characters/ankor.tscn")

var dialog = [
	"Ankor: Veo que has llegado hasta mi dominio, Ashkaroth, la tierra que será tu tumba. Tal vez te sientes poderoso por haber derrotado a mi más fuerte lacayo, pero te equivocas. Él no ha muerto, porque mientras yo exista, su servidumbre será eterna.",
	"Eirion: Si estas son tus últimas palabras, que así sea. No importa el precio que deba pagar, incluso si es mi vida. Detendré tu maldad y restauraré la esperanza en este mundo.",
	"Ankor: Eres un bastardo sin gloria, un eco vacío de grandeza. No tienes el poder para desafiar mi reinado de sombras. Te derrotaré, pero no destruiré tu existencia; dejaré que contemples cómo todo lo que amas perece bajo mi dominio.",
	"Eirion: Tal vez mi fin esté cerca, pero no será antes de que te derrote. Soy hijo de nobles, heredero de un legado de luz y justicia. Juro por mi sangre y mi historia que hoy marcaré tu final, Señor de las Sombras. Soy la luz que disipa la noche, y te devolveré al abismo del que nunca debiste salir.",
	"Ankor: Te engañas. El abismo no me llama a mí, sino a ti. Este mundo ya estaba corrupto antes de mi llegada. Solo estoy acelerando su inevitable decadencia. Luchas por una causa sin bandera, por un mundo que no reconocerá tu sacrificio ni llorará tu muerte.",
	"Eirion: Lo sé. Tal vez mi nombre se pierda en el olvido, o tal vez viva en las historias que se contarán en siglos venideros. No lucho por gloria ni reconocimiento. Lucho porque creo que la bondad puede prevalecer, incluso contra las mayores sombras.",
	"Ankor: Entonces tu destino está sellado. Te encadenaré a las sombras, como yo lo he estado, hasta que estas devoren tu alma y olvides lo que alguna vez fuiste.",
	"Eirion: Acepto mi destino. Si debo morir, lo haré en lo más alto, con victoria o sin ella. Mi espíritu no conocerá vergüenza ante mis ancestros. Honraré su legado y mi propia existencia. Prepárate, maldito, porque la luz te alcanzará.",
	"Ankor: ¡Lacayo, tropas! ¡Acaben con él!",
	"Eirion: Si este es mi fin, que así sea. Pero no me doblegaré."
]

var path:String = "res://Scenes/Other_scenes/select_level.tscn"

func _physics_process(delta: float) -> void:
	check_enemies()
	if ankor_speaker != null:
		if ankor_speaker.global_position.distance_to($map/Marker_target.position) < 6:
			print("ya llego")
			if dialogue != null:
				dialogue.visible = true
			else:
				end_dialog = true
				print("acabo el dialogo")
		if dialogue == null and end_dialog:
			ankor_speaker.go_out(marker.position)
			if ankor_speaker.global_position.distance_to(marker.position) < 5:
				ankor_speaker.queue_free()
				var enemy_lackey_real = lackey_real.instantiate() 
				var enemy_ankor_real = ankor_real.instantiate()
				enemy_lackey_real.position = Vector2($map/Marker2D2.position)
				enemy_ankor_real.position = Vector2($map/Marker2D2.position)
				$map.add_child(enemy_lackey_real)
				$map.add_child(enemy_ankor_real)
				active_spawn = true
	if active_spawn:
		$map/spawn_enemy_2.spawn()
		$map/spawn_enemy_3.spawn()
		$map/spawn_enemy.spawn()
		$map/spawn_enemy2.spawn()
