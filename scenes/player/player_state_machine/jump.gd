extends State

var has_jumped = false

## Called when the state is first entered
func enter(): 
	has_jumped = false
	
## Called upon leaving the state to another
func exit(): 
	has_jumped = false
	
## Update the physics based on the current state
func update(delta: float):

	if ! has_jumped:
		jump()
	
	if ! parent.is_on_floor():
		apply_gravity(delta)
		
	if ! parent.is_on_floor() && has_jumped:
		if parent.velocity.y >= 0:
			state_machine.change_state(state_machine.states.fall)
			return
	
	apply_airlial_movement(delta)
			
func apply_gravity(delta: float):
		#	Apply gravity
		parent.velocity.y += parent.JUMP_GRAVITY * delta
		
func apply_airlial_movement(delta: float):
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
#		If the parent is in the air	
#		Insert unique in-air movement here		
	if right_pressed && left_pressed:
		parent.decelerate_x(delta)
	elif right_pressed || left_pressed:
		parent.accelerate_x(delta)
		
func jump():
	parent.velocity.y -= parent.MAX_JUMP
	Utils.await_physics_frames(5, parent)
	has_jumped = true
