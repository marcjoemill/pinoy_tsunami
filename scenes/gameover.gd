extends Control

@onready var animated_sprite = $AnimatedSprite2D
@onready var score_label = $VBoxContainer/ScoreLabel
@onready var back_button = $VBoxContainer/BackButton
@onready var game_over_music = $GameOverMusic

var input_blocked := true

func _ready():
	show_score(Global.last_score)
	animated_sprite.play()
	game_over_music.stream.loop = true
	game_over_music.play()
	
	block_input_for_seconds(12)

func show_score(final_score):
	score_label.text = "%d" % final_score

func _input(event):
	if input_blocked:
		return

	if event is InputEventMouseButton or event is InputEventKey:
		game_over_music.stop()
		get_tree().change_scene_to_file("res://scenes/menuscreen.tscn")

func block_input_for_seconds(seconds: float) -> void:
	var timer := Timer.new()
	timer.one_shot = true
	timer.wait_time = seconds
	add_child(timer)
	timer.start()
	timer.timeout.connect(_on_input_unblocked)

func _on_input_unblocked():
	input_blocked = false
