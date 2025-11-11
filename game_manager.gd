extends Node3D
@onready var game_timer = $GameTimer
@onready var player_ui = get_tree().current_scene.get_node("Player/player_ui")

@export var cheese_scene: PackedScene
const NUMBER_OF_CHEESES: int = 5

var spawn_positions: Array[Vector3] = [
	Vector3(-16.045, 1.141, -14.421),  # Posição 1
	Vector3(-21.677, 1.089, -0.224),
	Vector3(-32.9, 1.089, -0.865),
	Vector3(-27.43, 1.089, -7.874),
	Vector3(-21.712, 1.089, -12.98),
	Vector3(-21.712, 1.089, -21.255),
	Vector3(-32.348, 1.089, -19.147),
	Vector3(-28.947, 1.089, -12.708),
	Vector3(-29.461, 1.089, -4.332)
]
# Variáveis de Controle de Jogo
var collected_cheeses: int = 0
var total_cheeses: int = 0

func _ready() -> void:
	randomize() 
	
	spawn_cheeses_randomly()
	game_timer.start()
	print("Timer de 20 segundos iniciado!")
	
func _process(_delta: float) -> void:
	# Verifica se o timer está ativo para evitar erros
	if game_timer.is_stopped():
		return

	var time_remaining = game_timer.time_left

	# Envia o tempo restante para o script da UI
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

func collect_cheese():
	collected_cheeses += 1
	print("Cheese collected! Total: ", collected_cheeses, " / ", total_cheeses)
	
	if collected_cheeses >= total_cheeses:
		game_timer.stop() # Para o timer para evitar o Game Over
		end_game("You Win!.")


# Lógica de fim de jogo
func end_game(result_text: String):
	
	print("--- END GAME ---")
	print(result_text)
	
	if player_ui:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player_ui.show_game_over_screen(result_text)

func pause_game_state():
	game_timer.stop() # <-- ESTE É O COMANDO PARA PARAR O TIMER
	get_tree().paused = true
	end_game("YOU WIN!")
