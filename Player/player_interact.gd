extends RayCast3D


var last_hit_object: MeshInstance3D = null
@onready var player_ui = get_tree().current_scene.get_node("Player/player_ui") 
@onready var game_manager = get_tree().current_scene.get_node(".")

func _physics_process(_delta: float) -> void:
	
	if is_colliding():
		var collider = get_collider()
		var score_handler = game_manager
		
		if collider.get_parent() and collider.get_parent().name == "Cheese":
			var cheese_node = collider.get_parent()
			
			if score_handler:
				score_handler.collect_cheese_logic() 
			
			cheese_node.queue_free()
