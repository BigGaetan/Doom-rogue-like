extends CharacterBody2D


const SPEED = 100.0
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
	
	move_and_slide()


func take_domage(amount):
	hp -= amount
	
	if hp <= 0:
		die()

func die():
	queue_free()
