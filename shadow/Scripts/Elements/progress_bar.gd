class_name Bar_health extends ProgressBar

var value_target := 0.0
var aux := 0.0        

# Actualiza el valor y cambia el estilo según el valor de la vida
func update_life(current_life: float) -> void:
	value_target = current_life  # Establece el valor objetivo

# Interpolación suave para el valor de la barra
func _process(delta: float) -> void:
	if aux != value_target:
		aux = lerp(aux, value_target, delta * 2.0)  # Ajusta la velocidad de la interpolación
		self.value = aux
