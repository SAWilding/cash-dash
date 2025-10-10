extends State

		
## Called when the state is first entered
func enter(): 
	if state_machine.previous_state == state_machine.states.fall:
		parent.velocity.x = 0

## Called upon leaving the state to another
func exit(): pass

## Update the physics based on the current state
func update(delta: float): 
	if ! parent.is_on_floor():
		state_machine.change_state(state_machine.states.fall)
		return
		
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
	if abs(parent.velocity.x) > 0:
		parent.decelerate_x(delta)

	if right_pressed || left_pressed:
		if parent.is_on_floor():
			state_machine.change_state(state_machine.states.walk)
			return
			
	elif Input.is_action_just_pressed("jump"):
		if parent.is_on_floor():
			state_machine.change_state(state_machine.states.jump)
			return
