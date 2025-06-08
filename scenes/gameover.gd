extends Control

@onready var score_label = $VBoxContainer/ScoreLabel
@onready var back_button = $VBoxContainer/BackButton

func _ready():
    back_button.pressed.connect(_on_back_to_menu)
    show_score(Global.last_score)

func show_score(final_score):
    score_label.text = "Your Score: %d" % final_score

func _on_back_to_menu():
    print("Back button pressed!")
    get_tree().change_scene_to_file("res://scenes/menuscreen.tscn")
