extends CharacterBody2D

# Movement settings
@export var speed : float = 300.0
@export var gravity : float = 30.0
@export var jump_force : float = -800.0

# Animation nodes
@onready var animated_sprite = $AnimatedSprite2D  # Make sure this matches your node name

func _ready():
	# Start with idle/running animation
	animated_sprite.play("run")

func _physics_process(delta):
	# Apply gravity when airborne
	if not is_on_floor():
		velocity.y += gravity
	
	# Continuous right movement
	velocity.x = speed
	
	# Jump input (kept but no animation)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		# Add jump particles here if desired
	
	move_and_slide()
