extends Control

@onready var score_label = $VBoxContainer/ScoreLabel
@onready var back_button = $VBoxContainer/BackButton
@onready var game_over_music = $GameOverMusic

func _ready():
	show_score(Global.last_score)
	game_over_music.play()

func show_score(final_score):
	score_label.text = "%d" % final_score

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		game_over_music.stop()
		get_tree().change_scene_to_file("res://scenes/menuscreen.tscn")
