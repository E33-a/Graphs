class_name portal extends Area2D

@onready var animation:AnimatedSprite2D = $AnimatedSprite2D
@onready var path:String = self.owner.path

var player_is_in_area:bool = false

func change_scene(path:String) -> void:
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file(path)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		player_is_in_area = true


func _process(delta: float) -> void:
	animation.play("idle")
	if player_is_in_area:
		change_scene(path)
