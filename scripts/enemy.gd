extends CharacterBody2D

@onready var animE = $AnimatedSprite2D
@onready var detction = $DetectionArea

var SPEED = Global.speed_enemy
var GRAVITY = Global.GRAVITY

var direction = -1

var player = null
var state = "patrol"
var can_attack = true

var hp = 20
var xp_value = 2

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	velocity.x = direction * SPEED
	
	if is_on_wall():
		direction *= -1
	
	
	match state:
		"patrol":
			patrol()
		"chase":
			chase()
	
	move_and_slide()
	updated_animation()

func play_anim(name):
	if animE.animation != name:
		animE.play(name)

func updated_animation():	
	if not is_on_floor():
		return
	else:
		if abs(velocity.x) > 10:
			play_anim("run")
		else:
			play_anim("default")
	if velocity.x != 0:
		animE.flip_h = velocity.x > 0

func take_damage(amount):
	hp -= amount
	hp = max(hp, 0)
	print("pv enemy : ", hp)
	
	if hp == 0:
		die()

func die():
	print("enemy dead")
	give_xp()
	queue_free()

func give_xp():
	var player = get_tree().get_first_node_in_group("player")
	
	if player != null:
		player.add_xp(xp_value)

func patrol():
	velocity.x = direction * SPEED
	
	if is_on_wall():
		direction *= -1


func chase():
	if player == null :
		state = "patrol"
		return
	
	var dir = sign(player.global_position.x - global_position.x)
	velocity.x = dir * SPEED



func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		state = "chase"

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null
		state = "patrol"

func _on_attaque_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(2, global_position)
		can_attack = false
		await get_tree().create_timer(1.0).timeout
		can_attack = true
