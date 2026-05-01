extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -125.0

# HP 
var max_hp = 10
var hp = 10

# xp 
var xp = 0
var level = 1
var xp_to_next_level = 10


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
	
	if Input.is_action_just_pressed("ui_cancel"):
		add_xp(3)
	
	if Input.is_action_just_pressed("ui_up"):
		take_damage(1)



func add_xp(amount):
	xp += amount
	print("XP : ", xp, "/", xp_to_next_level)
	
	if xp >= xp_to_next_level:
		level_up()



func level_up():
	level += 1
	xp -= xp_to_next_level
	xp_to_next_level = int(xp_to_next_level*1.25)
	
	print("Level Up \n level : ", level)


func take_damage(amount):
	hp -= amount
	hp = max(hp, 0)
	print("hp : ", hp)
	
	if hp == 0:
		die()



func die():
	print("Player dead")
	hp = max_hp
	global_position = Vector2(0, 0)
