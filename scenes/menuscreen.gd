extends Control

@onready var start_button = $StartButton
@onready var help_button = $HelpButton
@onready var help_panel = $HelpPanel
@onready var normal_texture = preload("res://assets/graphics/button/playbutton1.png")
@onready var pressed_texture = preload("res://assets/graphics/button/playbutton2.png")
@onready var click_audio = $ClickAudio
@onready var menu_music = $MenuMusic

var help_panel_visible := false

func _ready():
	start_button.texture_normal = normal_texture
	start_button.texture_pressed = pressed_texture
	start_button.toggle_mode = true
	
	menu_music.stream.loop = true
	menu_music.play()
	help_panel.visible = false

func _input(event):
	if help_panel_visible:
		if event is InputEventMouseButton or event is InputEventKey:
			help_panel.visible = false
			help_panel_visible = false
			get_viewport().set_input_as_handled()
		return

	if event is InputEventKey:
		if event.pressed:
			if start_button.texture_pressed != null:
				start_button.texture_normal = start_button.texture_pressed
			_on_start_pressed()


func _on_start_pressed():
	menu_music.stop()
	click_audio.play()
	var delay_time = .5
	await get_tree().create_timer(delay_time).timeout
	get_tree().change_scene_to_file("res://scenes/gamescreen.tscn")


func _on_help_pressed() -> void:
	click_audio.play()
	var delay_time = .5
	help_panel.visible = true
	help_panel_visible = true
