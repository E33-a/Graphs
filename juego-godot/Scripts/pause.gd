extends CanvasLayer

func _ready() -> void:
	$ColorRect.visible = not $ColorRect.visible
	$Label.visible = not $Label.visible
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("paused"):
		$ColorRect.visible = not $ColorRect.visible
		$Label.visible = not $Label.visible
		get_tree().paused = not get_tree().paused
