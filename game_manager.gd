extends Node3D
@onready var game_timer = $GameTimer
@onready var player_ui = get_tree().current_scene.get_node("Player/player_ui")
@onready var coin_collect = $coin_collect
@onready var audio_winner = $winner 
@export var cheese_scene: PackedScene
const NUMBER_OF_CHEESES: int = 5

var start_time: float = 0.0 
var spawn_positions: Array[Vector3] = [
	Vector3(-16.045, 1.041, -14.421),
	Vector3(-21.677, 1.089, -0.224),
	Vector3(-32.9, 1.089, -0.865),
	Vector3(-27.43, 1.089, -7.874),
	Vector3(-21.712, 1.089, -12.98),
	Vector3(-21.712, 1.089, -21.255),
	Vector3(-32.348, 1.089, -19.147),
	Vector3(-28.947, 1.089, -12.708),
	Vector3(-16.278, 1.089, -6.689),
	Vector3(-16.278, 1.089, -4.023),
	Vector3(-19.731, 1.089, -4.023),
	Vector3(-19.731, 1.089, -11.379),
	Vector3(-22.391, 1.089, -16.575),
	Vector3(-33.183, 1.089, -16.575),
	Vector3(-31.264, 1.089, -7.902),
	Vector3(-21.454, 1.089, -7.902)
	
]
var collected_cheeses: int = 0
var total_cheeses: int = 5

func _ready() -> void:
	randomize() 
	
	spawn_cheeses_randomly()
	game_timer.start()
	start_time = Time.get_ticks_msec() / 1000.0 
	print("Timer de 20 segundos iniciado!")
	
func _process(_delta: float) -> void:
	if game_timer.is_stopped():
		return

	var time_remaining = game_timer.time_left

	if player_ui:
		player_ui.update_timer(time_remaining)
		
func _on_game_timer_timeout():
	print("TIME OVER!")
	end_game("Time Over!")

func spawn_cheeses_randomly() -> void:
	
	spawn_positions.shuffle()
	
	var cheeses_to_spawn = min(NUMBER_OF_CHEESES, spawn_positions.size())
	
	for i in range(cheeses_to_spawn):
		var spawn_point: Vector3 = spawn_positions[i]
		
		var new_cheese = cheese_scene.instantiate()
		
		add_child(new_cheese)
		
		new_cheese.global_position = spawn_point 
		
		print("Queijo spawnado em: ", new_cheese.global_position)

func collect_cheese_logic() -> void:
	collected_cheeses += 1
	if coin_collect.stream != null:
		coin_collect.play()
	if player_ui:
		player_ui.update_task_ui(collected_cheeses, total_cheeses) 

	print("Cheese collected! Total: ", collected_cheeses, " / ", total_cheeses)
	
	if collected_cheeses >= total_cheeses:
		game_timer.stop()
		var end_time: float = Time.get_ticks_msec() / 1000.0
		var raw_time_taken: float = end_time - start_time
		var time_taken: float = round(raw_time_taken * 100.0) / 100.0
		
		Score.add_new_score(time_taken)
		var result_text = "YOU WIN! Time: %0.2f s" % time_taken
		if audio_winner.stream != null:
			audio_winner.play()
		end_game(result_text)


func end_game(result_text: String):
	
	print("--- END GAME ---")
	print(result_text)
	
	if player_ui:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player_ui.show_over_tela(result_text)

	
	
	
