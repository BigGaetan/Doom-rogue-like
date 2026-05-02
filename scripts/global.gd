extends Node

@onready var modify_menu = get_tree().get_first_node_in_group("modify_menu")

var GRAVITY = 900
var speed_enemy = 15.0
var speed_player = 20.0
var speed_fireball = 125.0
var knockback_force = 150.0

func _input(event):
	if Input.is_action_just_pressed("modify_menu"):
		modify_menu.visible = !modify_menu.visible
		#get_tree().paused = modify_menu.visible
