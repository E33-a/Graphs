extends RichTextLabel

func _ready():
	var dynamic_font = load("res://Fonts/MedievalSharp-Book.ttf") as FontFile
	add_theme_font_override("normal_font", dynamic_font) #asignar font
	text = "[color=black][align=center]¡Hola, mundo![/align][/color]"
	#Ajusta la fuente para que se vea mejor en tamaños pequeños
	dynamic_font.hinting = TextServer.HINTING_NONE
	#Suaviza los bordes para evitar que se vean pixelados o escalonados.
	dynamic_font.antialiasing = TextServer.FONT_ANTIALIASING_GRAY
