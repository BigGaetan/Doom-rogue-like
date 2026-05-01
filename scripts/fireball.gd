extends CharacterBody2D


var speed = 50.0
var direction = 1


func _physics_process(delta: float):
	velocity.x = speed * direction
	move_and_slide()
