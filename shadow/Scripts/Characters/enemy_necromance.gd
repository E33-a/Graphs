class_name enemy_necromance extends enemy_abstract

@onready var progress_bar:Bar_health = $ProgressBarEnemy
var regenerate_life:bool = true

func _on_regenerate_timeout() -> void:
	regenerate_life = true
	
func regenerate() -> void:
	if regenerate_life and vida < 100:
		vida += 20
		$Regenerate.start()
		regenerate_life = false
		if vida > 100:
			vida = 100
			
func _process(delta: float) -> void:
		regenerate()
