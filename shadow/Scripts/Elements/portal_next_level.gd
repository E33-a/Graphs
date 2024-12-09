extends Area2D

@onready var audio:AudioStreamPlayer = $AudioStreamPlayer
var player_in_area:bool = false

func change_scene(path:String) -> void:
	await get_tree().create_timer(4.0).timeout
	get_tree().change_scene_to_file(path)


func _on_body_entered(body: Node2D) -> void:
	player_in_area = true

func _process(delta: float) -> void:
	if player_in_area:
		audio.play()
