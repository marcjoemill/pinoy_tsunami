extends Area2D

@export var speed: float = 0.0

func _process(delta):
	position.x -= speed * delta
	if position.x < -0:
		queue_free()
