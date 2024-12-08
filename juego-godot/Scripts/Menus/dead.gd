extends CanvasLayer

@onready var button = $ColorRect/VBoxContainer/Button
@onready var button2 = $ColorRect/VBoxContainer/Button2
@onready var label = $ColorRect/TextureRect/Label
@onready var label2 = $ColorRect/TextureRect/Label2
@onready var audio = $AudioStreamPlayer

func _ready() -> void:
	var custom_font = preload("res://Fonts/MedievalSharp-BoldOblique.ttf")  # Carga una fuente
	var another_custom_font = preload("res://Fonts/MedievalSharp-Bold.ttf")
	# Aplicar fuente
	button.add_theme_font_override("font", custom_font)
	button2.add_theme_font_override("font", custom_font)
	label.add_theme_font_override("font", another_custom_font)
	label2.add_theme_font_override("font", another_custom_font)
	# Cambia el color de fuente
	button.add_theme_color_override("font_color", Color(0, 0, 0)) #negro
	button2.add_theme_color_override("font_color", Color(0, 0, 0))
	
func _physics_process(delta: float) -> void:
	if not audio.playing:
		audio.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Other_scenes/start_menu.tscn")

func _on_button_2_pressed() -> void:
	get_tree().reload_current_scene()
