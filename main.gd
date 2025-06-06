extends Node2D
@onready var bgs = [$Background1, $Background2, $Background3]
@export var scroll_speed: float = 200

func _ready():
	bgs[0].position.x = 0
	bgs[1].position.x = 1280
	bgs[2].position.x = 2560

func _process(delta):
	for bg in bgs:
		bg.position.x -= scroll_speed * delta
		if bg.position.x <= -1280:
			var others = bgs.filter(func(e): return e != bg)
			var max_x = max(others[0].position.x, others[1].position.x)
			bg.position.x = max_x + 1280
		
		print("%s position x: %f" % [bg.name, bg.position.x])
