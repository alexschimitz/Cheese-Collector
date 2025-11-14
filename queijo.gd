extends Node3D

@onready var game_manager = get_parent() 

func _init():
	pass
	
func _ready() -> void:
	set_process(true)

func _process(delta: float) -> void:
	rotate_y(deg_to_rad(150) * delta)
	
func collect():
	if game_manager and game_manager.has_method("collect_cheese"):
		game_manager.collect_cheese()
		
	play_collection_effect()
	
	queue_free() #Del Object

func play_collection_effect():
	pass
