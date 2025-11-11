extends Control

@onready var game_over_screen = $GameOver_Screen
@onready var game_over_text = $GameOver_Screen/VBoxContainer/GameOver_Text
@onready var restart_button = $GameOver_Screen/VBoxContainer/Restart_Button
@onready var game_manager = get_tree().current_scene.get_node(".")

var cheese_count: int = 0
const MAX_CHEESE: int = 5

func _ready() -> void:
	update_task_ui()
	set_task("Collect 0/5 Cheese")
	
	game_over_screen.visible = false
	
	restart_button.pressed.connect(_on_restart_button_pressed)
	
func set_task(task_text: String):
	$task_ui/task_text.text = task_text

func update_task_ui():
	set_task("Collect %d/%d cheese" % [cheese_count, MAX_CHEESE])

func collect_cheese() -> void:
	cheese_count += 1
	update_task_ui()
	
	if cheese_count >= MAX_CHEESE:
		win_game()
	
func win_game() -> void:
	print("End Game! Winner")
	if game_manager and game_manager.has_method("pause_game_state"):
		game_manager.pause_game_state()
	
func update_timer(time_remaining: float):
	var time_str = "Time: %0.2f" % time_remaining
	$task_ui/PanelContainer/VBoxContainer/Timer_Text.text = time_str
	
	
func show_game_over_screen(message: String):
	game_over_text.text = message
	game_over_screen.visible = true
	get_tree().paused = true


func _on_restart_button_pressed():
	get_tree().paused = false # Despausa o jogo
	get_tree().reload_current_scene() # Reinicia a cena atual
	
func _on_main_menu_pressed():
	get_tree().paused = false # Despausa o jogo
	get_tree().change_scene_to_file("res://start_menu.tscn")
