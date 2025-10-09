extends State

		
## Called when the state is first entered
func enter(): 
	if state_machine.previous_state == state_machine.states.fall:
		player.velocity.x = 0

## Called upon leaving the state to another
func exit(): pass

## Update the physics based on the current state
func update(delta: float): 
	if ! player.is_on_floor():
		state_machine.change_state(state_machine.states.fall)
		return
		
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
	if abs(player.velocity.x) > 0:
		player.decelerate_x(delta)

	if right_pressed || left_pressed:
		if player.is_on_floor():
			state_machine.change_state(state_machine.states.walk)
			return
			
	elif Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			state_machine.change_state(state_machine.states.jump)
			return
