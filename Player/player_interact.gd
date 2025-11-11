extends RayCast3D


var last_hit_object: MeshInstance3D = null
@onready var player_ui = get_tree().current_scene.get_node("Player/player_ui") 


func _physics_process(_delta: float) -> void:
	
	if is_colliding():
		var collider = get_collider()
		if collider.get_parent() and collider.get_parent().name == "Queijo":
			var cheese_node = collider.get_parent()
			
			if player_ui:
				player_ui.collect_cheese()
			
			cheese_node.queue_free()
			
		elif collider.name == "Queijo":
			if player_ui:
				player_ui.collect_cheese()
			
			collider.queue_free()
