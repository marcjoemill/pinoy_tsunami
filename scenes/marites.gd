extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Marites")
	animated_sprite.play()
