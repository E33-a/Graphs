extends CanvasLayer

@onready var button = $ColorRect/VBoxContainer/Button
@onready var button2 = $ColorRect/VBoxContainer/Button2
@onready var label = $ColorRect/TextureRect/Label
@onready var label2 = $ColorRect/TextureRect/Label2
@onready var audio = $AudioStreamPlayer

var is_paused = false

func _ready() -> void:
	# Cargar fuentes
	var custom_font = preload("res://Fonts/MedievalSharp-BoldOblique.ttf")
	var another_custom_font = preload("res://Fonts/MedievalSharp-Bold.ttf")
	
	# Aplicar fuentes a los botones y etiquetas
	button.add_theme_font_override("font", custom_font)
	button2.add_theme_font_override("font", custom_font)
	label.add_theme_font_override("font", another_custom_font)
	label2.add_theme_font_override("font", another_custom_font)
	
	# Cambiar el color de la fuente
	button.add_theme_color_override("font_color", Color(0, 0, 0)) # negro
	button2.add_theme_color_override("font_color", Color(0, 0, 0))

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("paused"):
		if not audio.playing:
			audio.play()
		is_paused = not is_paused
		$".".visible = is_paused  # Cambiar visibilidad del menú de pausa
		audio.playing = is_paused
		get_tree().paused = is_paused  # Pausar o despausar el juego

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Other_scenes/start_menu.tscn")

func _on_button_2_pressed() -> void:
	get_tree().reload_current_scene()
