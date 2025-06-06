extends CharacterBody2D

# Movement settings
@export var speed : float = 300.0
@export var gravity : float = 30.0
@export var jump_force : float = -800.0

# Nodes
@onready var animated_sprite = $AnimatedSprite2D
@onready var hitbox = $Hitbox  # Hitbox is an Area2D node under Player

# Player state
var player_count: int = 1  # Starts with 1 player

func _ready():
    hitbox.body_entered.connect(_on_hitbox_body_entered)
    update_animation()
    print("Starting player_count:", player_count)  
    
func _physics_process(delta):
    if not is_on_floor():
        velocity.y += gravity

    velocity.x = speed

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_force

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
    print("Game Over!")
    # Optional: transition to game over screen
    # get_tree().change_scene_to_file("res://GameOver.tscn")

func _on_hitbox_body_entered(body):
    print("Collided with:", body.name)
    print("Groups:", body.get_groups())

    if body.is_in_group("Marites") or body.is_in_group("Inuman") or body.is_in_group("Person"):
        player_count += 1
        body.queue_free()  # Make obstacle disappear

    elif body.is_in_group("Obstacle"):
        player_count -= 1
        body.queue_free()  # Make obstacle disappear

    elif body.is_in_group("Ebike"):
        player_count -= 2
        body.queue_free()  # Make obstacle disappear

    player_count = clamp(player_count, 0, 5)
    print("Updated player_count:", player_count)
    update_animation()
