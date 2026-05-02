extends Area2D


var speed = 125.0
var direction = 1


func _physics_process(delta):
	position.x += speed * direction * delta


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(25)
		
	explode()

func explode():
	speed = 0
	$CollisionShape2D.disabled = true
	$AnimatedSprite2D.play("default")

func _on_AnimationSprite2D_animation_finished():
	if $AnimatedSprite2D.animation == "default":
		queue_free()
