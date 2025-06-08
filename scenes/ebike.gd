extends CharacterBody2D

@export var speed: float = 200.0  # Base speed
var speed_multiplier: float = 1.0  # Multiplier from main scene

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	add_to_group("Ebike")
	animated_sprite.play()

func _process(delta):
	position.x -= speed * speed_multiplier * delta

# Called by the main script to adjust difficulty
func set_speed_multiplier(multiplier: float):
	speed_multiplier = multiplier
 
