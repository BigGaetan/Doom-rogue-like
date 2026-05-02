extends CharacterBody2D

@onready var animE = $AnimatedSprite2D

const SPEED = 25.0
const GRAVITY = 900

var direction = -1

var hp = 20

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	
	velocity.x = direction * SPEED
	
	if is_on_wall():
		direction *= -1
	
	if velocity.x != 0:
		animE.flip_h = velocity.x < 0
	
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

func take_damage(amount):
	hp -= amount
	hp = max(hp, 0)
	print("pv enemy : ", hp)
	
	if hp == 0:
		die()

func die():
	print("enemy dead")
	queue_free()
