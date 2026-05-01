extends Area2D


var speed = 50.0
var direction = 1


func _physics_process(delta):
	position.x += speed * direction * delta


func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(25)
		
	explode()

func explode():
	queue_free()
