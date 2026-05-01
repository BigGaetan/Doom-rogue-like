extends CanvasLayer

@onready var hp_bar = $"HP Bar"
@onready var hp_label = $HPLabel
@onready var xp_bar = $XPBar
@onready var level_label = $LevelLabel
@onready var mana_bar = $ManaBar
@onready var mana_label = $ManaLabel

var player

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	if player == null:
		return

	# HP
	hp_bar.max_value = player.max_hp
	hp_bar.value = player.hp
	hp_label.text = str(player.hp)+"/"+str(player.max_hp)

	# XP
	xp_bar.max_value = player.xp_to_next_level
	xp_bar.value = player.xp
	level_label.text = "Level " + str(player.level)
	
	# mana
	mana_bar.max_value = player.max_mana
	mana_bar.value = player.mana
	mana_label.text = str(player.mana)+"/"+str(player.max_mana)
