extends CanvasLayer

@onready var hp_bar = $HPBar
@onready var xp_bar = $XPBar
@onready var level_label = $LevelLabel

var player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	if player == null:
		return

	# HP
	hp_bar.max_value = player.max_hp
	hp_bar.value = player.hp

	# XP
	xp_bar.max_value = player.xp_to_next_level
	xp_bar.value = player.xp

	# Level
	level_label.text = "Level " + str(player.level)
