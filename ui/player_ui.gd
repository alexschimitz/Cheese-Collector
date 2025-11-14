extends Control

@onready var over_tela = $GameOver_Screen
@onready var gameover_txt = $GameOver_Screen/VBoxContainer/GameOver_Text
@onready var restart_btn = $GameOver_Screen/VBoxContainer/Restart_Button
@onready var highscorelb = $GameOver_Screen/VBoxContainer/HighScore_Label
@onready var game_manager = get_tree().current_scene.get_node(".")


func _ready() -> void:
	update_task_ui(0, 5)	
	over_tela.visible = false
	
func set_task(task_text: String):
	$task_ui/task_text.text = task_text

func update_task_ui(current: int, total: int):
	var task_text = "Collect %d/%d Cheese" % [current, total]
	
	set_task(task_text)
	
	
func update_timer(time_remaining: float):
	var time_str = "Time: %0.2f" % time_remaining
	$task_ui/PanelContainer/VBoxContainer/Timer_Text.text = time_str
	
	
func show_over_tela(message: String):
	gameover_txt.text = message
	over_tela.visible = true
	get_tree().paused = true

	update_score_display()


func update_score_display():
	var scores: Array = Score.get_top_scores() 
	var score_display = "HIGHSCORE:\n"
	print("Scores recebidos pela UI:", scores)
	
	if scores.is_empty():
		score_display += "Nothing."
	else:
		for i in range(scores.size()):
			var rank = i + 1
			var time_str = "%0.2f" % scores[i]
			score_display += "%d. %s seconds\n" % [rank, time_str]
			
	
	highscorelb.text = score_display
	
func _on_restart_button_pressed():
	get_tree().paused = false # Despausa o jogo
	get_tree().reload_current_scene() # Reinicia a cena atual
	
func _on_main_menu_pressed():
	get_tree().paused = false # Despausa o jogo
	get_tree().change_scene_to_file("res://start_menu.tscn")
