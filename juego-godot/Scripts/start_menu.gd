extends Control
@onready var audio = $AudioStreamPlayer
@onready var select_audio = $AudioStreamPlayer2

func _ready() -> void:
	get_tree().paused = false
	var button0 = $VBoxContainer/btn_play
	var button1 = $VBoxContainer/btn_options
	var button2 = $VBoxContainer/btn_exit
	var custom_font = preload("res://Fonts/MedievalSharp-Bold.ttf")  # Carga una fuente si tienes una
	button0.add_theme_font_override("font", custom_font)
	button1.add_theme_font_override("font", custom_font)
	button2.add_theme_font_override("font", custom_font)
	audio.play()
	
func _process(delta: float) -> void:
	if not audio.playing:
		audio.play()
	
func _on_btn_play_pressed() -> void:
	select_audio.play()	
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Other_scenes/LEVEL_ONE.tscn")


func _on_btn_options_pressed() -> void:
	select_audio.play()	
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/Other_scenes/options.tscn")


func _on_btn_exit_pressed() -> void:
	select_audio.play()	
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
