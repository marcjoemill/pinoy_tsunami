extends CharacterBody2D

@export var speed: float = 200.0  # You can increase this to make it faster

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Ebike")
	animated_sprite.play()

func _process(delta):
	position.x -= speed * delta
