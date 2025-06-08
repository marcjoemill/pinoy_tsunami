extends CharacterBody2D

# Movement settings
@export var speed : float = 300.0
@export var gravity : float = 30.0
@export var jump_force : float = -800.0

# Nodes
@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox  # Hitbox is an Area2D node under Player
@onready var jump_audio = $JumpAudio
@onready var add_collision_audio = $AddCollisionAudio
@onready var rock_collision_audio = $RockCollisionAudio
@onready var ebike_collision_audio = $EbikeCollisionAudio

# Player state
var player_count: int = 1  # Starts with 1 player

func _ready():
	hitbox.body_entered.connect(_on_hitbox_body_entered)
	hitbox.area_entered.connect(_on_hitbox_area_entered)
	update_animation()
	print("Starting player_count:", player_count)  
	
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity

	velocity.x = speed

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		jump_audio.play()

	move_and_slide()

func update_animation():
	if player_count <= 0:
		game_over()
	elif player_count >= 1 and player_count <= 5:
		var animation_name = "run_%d" % player_count
		print("Playing animation:", animation_name)
		animated_sprite.play(animation_name)

func game_over():
	animated_sprite.stop()
	get_node("/root/GameScreen").is_game_over = true

	var final_score = get_node("/root/GameScreen").score

	# Make sure the path matches your actual file structure and name
	var game_over_scene = preload("res://scenes/gameover.tscn").instantiate()
	get_tree().root.add_child(game_over_scene)
	game_over_scene.show_score(final_score)

	get_node("/root/GameScreen").queue_free()

func _on_hitbox_body_entered(body):
	print("Collided with:", body.name)
	print("Groups:", body.get_groups())

	if body.is_in_group("Obstacle"):
		player_count -= 1
		rock_collision_audio.play()
		body.queue_free()  # Make obstacle disappear

	elif body.is_in_group("Ebike"):
		player_count -= 2
		ebike_collision_audio.play()
		body.queue_free()  # Make obstacle disappear

	player_count = clamp(player_count, 0, 5)
	print("Updated player_count:", player_count)
	update_animation()

func _on_hitbox_area_entered(area):
	print("Area entered:", area.name)
	print("Groups:", area.get_groups())
	
	if area.is_in_group("Marites") or area.is_in_group("Inuman") or area.is_in_group("Person"):
		add_collision_audio.play()
		player_count += 1
		area.queue_free()
		get_node("/root/GameScreen").add_score(1) 
		
	player_count = clamp(player_count, 0, 5)
	print("Updated player_count:", player_count)
	update_animation()
