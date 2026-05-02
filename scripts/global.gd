extends Node

@onready var modify_menu = get_tree().get_first_node_in_group("modify_menu")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemies = get_tree().get_nodes_in_group("enemy")

var modifys = ["scene","knockbackH","knockbackV","HP","speed","speedEnemy"]


var GRAVITY = 900
var speed_enemy = 10.0
var speed_player = 15.0
var speed_fireball = 125.0
var knockback_force = 150.0
var knockback_timer = 2.0


func _input(event):
	if Input.is_action_just_pressed("modify_menu"):
		modify_menu.visible = !modify_menu.visible
		#get_tree().paused = modify_menu.visible

func shifting_reality():
	var nbShifting = randf_range(1,len(modifys))
	var shifting = get_random_names(nbShifting)
	print("liste des modificateurs : ", shifting)
	
	for i in shifting:
		modify_fun(i)
		

func modify_fun(name): # ilfaut que je créer une éthode pour chaque name
	if name == "scene":
		print("changemEEEEEENNNNNNNNNNNNNT")
		#get_tree().change_scene_to_file("res://Level2.tscn")
	elif name == "knockbackH":
		player.knockback_force = 100
	elif name == "knockbackV":
		player.knockback_vertical = 100
	elif name == "HP":
		player.max_hp = 100
		player.hp = 100
	elif name == "speed":
		player.SPEED = 100
	elif name == "speedEnemy":
		for e in enemies:
			e.SPEED *= 1.5



func get_random_names(count:int) -> Array:
	var copy = modifys.duplicate()
	copy.shuffle()
	count = min(count, copy.size())
	
	return copy.slice(0, count)
