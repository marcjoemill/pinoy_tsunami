extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Inuman")
	animated_sprite.play()
	
