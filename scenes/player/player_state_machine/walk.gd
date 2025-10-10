extends State
	
## Called when the state is first entered
func enter(): pass
	
## Called upon leaving the state to another
func exit(): pass

## Update the physics based on the current state
func update(delta: float):
#	If the parent is not on the floor change state to fall
	if ! parent.is_on_floor():
		state_machine.change_state(state_machine.states.fall)
		return

#   Change state to jump if jump key is pressed
	if Input.is_action_pressed("jump"):
		state_machine.change_state(state_machine.states.jump)
		return
		

	apply_floor_movement(delta)
	
	
func apply_floor_movement(delta: float):
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
	
	if right_pressed && left_pressed:
		parent.decelerate_x(delta)
	elif right_pressed || left_pressed:
		parent.accelerate_x(delta)
	else:
		state_machine.change_state(state_machine.states.idle)
		return
