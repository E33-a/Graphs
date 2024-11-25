extends CanvasLayer


func _ready() -> void:
	var button = $VBoxContainer/Button  
	var custom_font = preload("res://Fonts/MedievalSharp-Bold.ttf")  # Carga una fuente
	# Aplicar fuente 
	button.add_theme_font_override("font", custom_font)
	# Cambia el color de fuente
	button.add_theme_color_override("font_color", Color(0, 0, 0)) #negro
	visible_elements()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("paused"):
		visible_elements()
		get_tree().paused = not get_tree().paused

func visible_elements() -> void:
		$ColorRect.visible = not $ColorRect.visible
		$Label.visible = not $Label.visible
		$Label2.visible = not $Label2.visible
		$VBoxContainer/Button.visible = not $VBoxContainer/Button.visible

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Other_scenes/start_menu.tscn")
