extends Control
@onready var audio = $AudioStreamPlayer
@onready var select_audio = $AudioStreamPlayer2

func _ready() -> void:
	get_tree().paused = false
	audio.play()
	var button0 = $VBoxContainer/btn_lvl1
	var button1 = $VBoxContainer/btn_lvl2l
	var button2 = $VBoxContainer/btn_lvl3
	var button3 = $VBoxContainer/btn_back
	
	var custom_font = preload("res://Fonts/MedievalSharp-Bold.ttf")  # Carga una fuente si tienes una
	button0.add_theme_font_override("font", custom_font)
	button1.add_theme_font_override("font", custom_font)
	button2.add_theme_font_override("font", custom_font)
	button3.add_theme_font_override("font", custom_font)

func _process(delta: float) -> void:
	if not audio.playing:
		audio.play()

func _on_btn_lvl_1_pressed() -> void:
	select_audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/map_01.tscn")

func _on_btn_lvl_2l_pressed() -> void:
	select_audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/map_02.tscn")

func _on_btn_lvl_3_pressed() -> void:
	select_audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Levels/map_03.tscn")

func _on_btn_back_pressed() -> void:
	select_audio.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Other_scenes/options.tscn")
