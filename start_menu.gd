extends Control

@export var main_scene_path: String

@onready var start_button = $ColorRect/StartGame


func _ready() -> void:
	start_button.pressed.connect(_on_start_game_button_pressed)
	
	get_tree().paused = false


func _on_start_game_button_pressed():	
	if main_scene_path:
		get_tree().change_scene_to_file(main_scene_path)
	else:
		push_error("ERRO: CENA NAO DEFINIDA(INSPETOR).")
