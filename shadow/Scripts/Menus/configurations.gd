extends Control

@onready var audio = $AudioStreamPlayer
@onready var select_audio = $AudioStreamPlayer2
@onready var button1 = $VBoxContainer/btn_main_menu
@onready var button2 = $VBoxContainer/btn_back
@onready var indicator = $HSlider/Indicator_numeric
@onready var titile = $VBoxContainer2/Volumen_game
func _ready() -> void:
	get_tree().paused = false
	# Configura el slider con el volumen actual del bus "Master"
	$HSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	audio.play()
	
	var custom_font = preload("res://Fonts/MedievalSharp-Bold.ttf")  # Carga una fuente si tienes una
	button1.add_theme_font_override("font", custom_font)
	button2.add_theme_font_override("font", custom_font)
	indicator.add_theme_font_override("font", custom_font)
	titile.add_theme_font_override("font", custom_font)

func _process(delta: float) -> void:
	if not audio.playing:
		audio.play()
		
func _on_btn_back_pressed() -> void:
	select_audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Other_scenes/options.tscn")

func _on_btn_main_menu_pressed() -> void:
		select_audio.play()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/Other_scenes/start_menu.tscn")

func _on_h_slider_value_changed(value: float) -> void:
	 # Cambia el volumen del bus "Master"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
	update_label(value)
	
func update_label(value):
	value += 100
	indicator.text = "Volumen: %.1f" % value
