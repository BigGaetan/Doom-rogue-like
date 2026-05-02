extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

@export var fireball_scene: PackedScene

var SPEED = Global.speed_player
const JUMP_VELOCITY = -135.0

var knockback_force = Global.knockback_force
var knockback_vertical = -20

var is_knockback = false
var knockback_timer = 2

# HP 
var max_hp = 10
var hp = 10

#mana
var max_mana = 10
var mana = 10

# xp 
var xp = 0
var level = 1
var xp_to_next_level = 10

# spell
var is_casting = false
var cast_time = 1
var cast_timer = 0.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	updated_animation()
	
	if velocity.x != 0:
		anim.flip_h = velocity.x < 0
	
	#if is_knockback :
		#move_and_slide()
		#return
	
	
	## test pour l'ajout et reduction des bars
	#if Input.is_action_just_pressed("ui_cancel"):
		#add_xp(3)
	#
	#if Input.is_action_just_pressed("ui_up"):
		#take_damage(1)
	
	if Input.is_action_just_pressed("cast_spell") and not is_casting:
		start_cast()
	
	if is_casting:
		cast_timer -= delta
		velocity.x = 0  # enlever cette ligne pour ne pas bloquer le déplacement pendant de cast
		
		if cast_timer <= 0:
			finish_cast()

func play_anim(name):
	if anim.animation != name:
		anim.play(name)

func updated_animation():
	if is_knockback:
		play_anim("hit")
		return
	if is_casting:
		play_anim("cast")
		return
	if not is_on_floor():
		if velocity.y < 0:
			play_anim("jump")
		else:
			play_anim("fall")
	else:
		if abs(velocity.x) > 10:
			play_anim("walk")
		else:
			play_anim("default")

func add_xp(amount):
	xp += amount
	print("XP : ", xp, "/", xp_to_next_level)
	
	if xp >= xp_to_next_level:
		level_up()

func level_up():
	level += 1
	xp -= xp_to_next_level
	xp_to_next_level = int(xp_to_next_level*1.25)
	
	hp = max_hp
	mana = max_mana
	
	print("Level Up \n level : ", level)

func take_damage(amount, source_position = null):
	hp -= amount
	hp = max(hp, 0)
	apply_knockback(source_position)
	
	if hp == 0:
		die()

func die():
	print("Player dead")
	hp = max_hp
	mana = max_mana
	global_position = Vector2(100, 100)

func apply_knockback(source_position):
	is_knockback = true
	
	var dir = 0
	
	if source_position != null:
		dir = sign(global_position.x - source_position.x)
	else :
		dir = -1 if anim.flip_h else 1
	
	velocity.x = dir * knockback_force
	velocity.y = knockback_vertical
	
	await get_tree().create_timer(knockback_timer).timeout
	is_knockback = false

func reduce_mana(amount):
	if amount > mana:
		take_damage(amount - mana)
		mana = 0
	else :
		mana -= amount
		mana = max(mana, 0)
		print("mana : ", mana)

func start_cast():
	is_casting = true
	reduce_mana(3)
	cast_timer = cast_time

func finish_cast():
	is_casting = false
	shoot_fireball()

func shoot_fireball():
	var fireball = fireball_scene.instantiate()
	
	fireball.global_position = global_position + Vector2(2 * (-1 if anim.flip_h else 1), 0)
	
	fireball.direction = -1 if anim.flip_h else 1
	
	get_tree().current_scene.add_child(fireball)
