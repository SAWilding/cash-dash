extends State

var jump_tolerance_entered: bool
## Called when the state is first entered
func enter():
	jump_tolerance_entered = false
## Called upon leaving the state to another
func exit(): pass

## Update the physics based on the current state
func update(delta: float):
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
	
	if ! parent.is_on_floor():
		apply_gravity(delta)
		if state_machine.previous_state == state_machine.states.walk && not jump_tolerance_entered:
			apply_jump_tolerance()	
			
		apply_airlial_movement(right_pressed, left_pressed, delta)		

	else: 
		if (right_pressed && left_pressed) || (! right_pressed && ! left_pressed):
			state_machine.change_state(state_machine.states.idle)
			return
		if abs(parent.velocity.x) > 0:
			state_machine.change_state(state_machine.states.walk)
			return
		else: 
			state_machine.change_state(state_machine.states.idle)
			return
			
			
func apply_jump_tolerance():
		jump_tolerance_entered = true
		for frame in range(parent.JUMP_FRAME_TOLERANCE):
			await parent.get_tree().physics_frame
			if parent.is_on_floor():
				break
			if Input.is_action_pressed("jump"):
				parent.velocity.y = 0
				state_machine.change_state(state_machine.states.jump)
				return
		
		
func apply_airlial_movement(right_pressed: bool , left_pressed: bool, delta: float):
		#If the parent is in the air	
#		Insert unique in-air movement here		
		if right_pressed && left_pressed:
			parent.decelerate_x(delta)
		elif right_pressed || left_pressed:
			parent.accelerate_x(delta)
			
func apply_gravity(delta: float):
	#	Apply gravity
	parent.velocity.y += parent.FALL_GRAVITY * delta
	parent.velocity.y = clamp(parent.velocity.y, -parent.MAX_JUMP, parent.MAX_FALL_SPEED)
