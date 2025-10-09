extends State

## Called when the state is first entered
func enter(): pass
	
## Called upon leaving the state to another
func exit(): pass

## Update the physics based on the current state
func update(delta: float):
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
	
	if ! player.is_on_floor():
		apply_gravity(delta)
		if state_machine.previous_state == state_machine.states.walk:
			apply_jump_tolerance()	
			
		apply_airlial_movement(right_pressed, left_pressed, delta)		

	else: 
		if (right_pressed && left_pressed) || (! right_pressed && ! left_pressed):
			state_machine.change_state(state_machine.states.idle)
			return
		if abs(player.velocity.x) > 0:
			state_machine.change_state(state_machine.states.walk)
			return
		else: 
			state_machine.change_state(state_machine.states.idle)
			return

func apply_jump_tolerance():
		for frame in player.JUMP_FRAME_TOLERANCE:	
			await player.get_tree().physics_frame
			if Input.is_action_pressed("jump"):
				state_machine.change_state(state_machine.states.jump)

func apply_airlial_movement(right_pressed: bool , left_pressed: bool, delta: float):
		#If the player is in the air	
#		Insert unique in-air movement here		
		if right_pressed && left_pressed:
			player.decelerate_x(delta)
		elif right_pressed || left_pressed:
			player.accelerate_x(delta)
			
func apply_gravity(delta: float):
	#	Apply gravity
	player.velocity.y += player.FALL_GRAVITY * delta
