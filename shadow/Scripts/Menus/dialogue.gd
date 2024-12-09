class_name dialogue extends Control

@onready var dialog = self.owner.dialog
@onready var rich_text:RichTextLabel = $Dialogue/MarginContainer/RichTextLabel
@onready var size_index:int = self.owner.dialog.size()

var finished_all:bool = false

var dialog_index: int = 0
var revealing_text: bool = false
var reveal_speed: float = 0.05  # Velocidad de revelado (segundos por carácter)
var timer: float = 0  # Temporizador para controlar la velocidad de revelado
var end_dialog:bool = false

func _ready() -> void:
	show_dialog(dialog_index)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept") and is_finished():
		self.queue_free()

func _process(delta: float) -> void:
	$Dialogue/next.visible = end_dialog
	$Dialogue/TextureRect/Label.visible = end_dialog
	if revealing_text:
		timer += delta  # Acumulamos tiempo
		if timer >= reveal_speed:
			timer = 0  # Reinicia el temporizador
			if rich_text.visible_characters < rich_text.text.length():
				rich_text.visible_characters += 2
			else:
				#revealing_text = false  # Revelación completada
				#end_dialog = true
				comprobations()

	if Input.is_action_just_pressed("ui_accept"):
		if revealing_text:
			# Si aún está revelando, mostrar todo el texto instantáneamente
			rich_text.visible_characters = rich_text.text.length()
			#revealing_text = false
			#end_dialog = true
			comprobations()
		else:
			end_dialog = false
			# Si el texto ya se mostró completamente, pasar al siguiente diálogo
			dialog_index += 1
			if dialog_index < dialog.size():
				show_dialog(dialog_index)
			else:
				print("Fin del diálogo")  # O cualquier acción que desees al finalizar

func show_dialog(index: int) -> void:
	rich_text.text = dialog[index]
	rich_text.visible_characters = 0  # Comienza oculto
	revealing_text = true  # Activa la revelación gradual
	
func comprobations() -> void:
	revealing_text = false
	end_dialog = true
	
func is_finished() -> bool:
	if dialog_index == size_index:
		return true
	else:
		return false
