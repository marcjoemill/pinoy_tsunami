extends Camera2D

@export var fixed_y_position : float = -25  # Set your desired vertical position

func _process(_delta):
	# Keep original X position (following player)
	# Override Y position to stay fixed
	position.y = fixed_y_position - get_parent().position.y
