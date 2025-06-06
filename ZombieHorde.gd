extends Node2D

@export var zombie_scene: PackedScene
@export var move_speed: float = 200

var zombies: Array = []

func _ready():
	spawn_initial_zombies(3)  # spawn 3 zombies (1 leader + 2 followers)

func _process(delta):
	# Move ZombieHorde node leftwards to simulate running forward
	#position.x -= move_speed * delta

	# Leader zombie visually stays at fixed screen x position (e.g., 150)
	var leader_x = 150
	if zombies.size() > 0:
		zombies[0].position.x = leader_x

	# Space followers behind leader by 30 pixels
	for i in range(1, zombies.size()):
		zombies[i].position.x = leader_x + i * 30

func spawn_initial_zombies(count):
	for i in range(count):
		var zombie = zombie_scene.instantiate()
		add_child(zombie)
		zombies.append(zombie)
		# Position zombies initially in a line
		zombie.position = Vector2(150 + i * 30, 0)
