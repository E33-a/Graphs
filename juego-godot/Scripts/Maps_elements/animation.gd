extends Node2D

func _ready():
	# Reproduce todas las animaciones dentro del nodo "animation"
	_play_all_animations(self)

func _play_all_animations(node):
	for child in node.get_children():
		if child is AnimatedSprite2D:
			child.play()  # Inicia la animación del nodo AnimatedSprite2D
		elif child.get_child_count() > 0:
			# Si tiene hijos, llama recursivamente para revisar más niveles
			_play_all_animations(child)
