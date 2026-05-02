extends Node2D

@export var next_scene: String = "res://scenes/level_test.tscn"

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_scene)
