extends CharacterBody2D

@export var speed: float = 0.0
@onready var animated_sprite = $AnimatedSprite2D  # Optional if using animation

func _ready():
	add_to_group("Obstacle")

func _process(delta):
	position.x -= speed * delta
	if position.x < 0:
		queue_free()
