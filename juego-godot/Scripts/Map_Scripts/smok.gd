extends AnimatedSprite2D

func _ready():
	# Asegúrate de que la animación esté configurada y en loop.
	animation = "smock"  # Cambia "fire" al nombre de tu animación.
	play()
