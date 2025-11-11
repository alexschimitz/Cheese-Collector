extends CharacterBody3D

var SPEED = 1.0
const SPRINT_MULTIPLIER = 5.0
		
func _physics_process(delta: float) -> void:

	var current_head_y = $head.position.y
	$head.position.y = lerp(current_head_y, 0.6, 0.1 * 2.0) 

		
	handle_gravity(delta)
	handle_movement()

# ----------------------------
func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta


		
func handle_movement() -> void:
	var is_sprinting = Input.is_action_pressed("sprint")
	var speed = SPEED * (SPRINT_MULTIPLIER if is_sprinting else 1.0)
	
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction.length() > 0:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
