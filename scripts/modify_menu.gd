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
	player.GRAVITY = value

func _on_HP_value_changed(value):
	player.max_hp = value
	player.hp = value

func _on_EnemyButton_pressed():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for e in enemies:
		e.SPEED *= 1.5

#func _on_Level_pressed():
	#get_tree().change_scene_to_file("res://Level2.tscn")

func _on_KnockbackSlider_value_changed(value):
	player.knockback_force = value
