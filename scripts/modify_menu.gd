extends CanvasLayer

@onready var speed_slider = $Panel/VBoxContainer/speed
@onready var gravity_slider = $Panel/VBoxContainer/gravity

var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_speed_value_changed(value):
	print("speeeeeeeeed")
	player.SPEED = value

func _on_gravity_value_changed(value):
	print("gravityyyyyyyyyy")
	Global.GRAVITY = value

func _on_hp_value_changed(value: float):
	player.max_hp = max(1, value)
	player.hp = max(1, value)


func _on_knockbackH_value_changed(value: float) -> void:
	player.knockback_force = value
	print("kncockback : ", player.knockback_force)


#func _on_change_scene_pressed() -> void:
	#get_tree().change_scene_to_file("res://Level2.tscn")


func _on_change_enemy_pressed() -> void:
	var enemies = get_tree().get_nodes_in_group("enemy")
	for e in enemies:
		e.SPEED *= 1.5
		print("speed enemy : ", e.SPEED)


func _on_knockback_v_value_changed(value: float) -> void:
	player.knockback_vertical = value *-1
	print("kncockback : ", player.knockback_force)
