extends State

		
## Called when the state is first entered
func enter(): 
	parent.animation_player.play("idle")

## Called upon leaving the state to another
func exit(): pass
	
## Update the physics based on the current state
func update(delta: float): 
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
	var up_pressed = Input.is_action_pressed("up")
	var down_pressed = Input.is_action_pressed("down")

	if right_pressed || left_pressed || up_pressed || down_pressed:
		state_machine.change_state(state_machine.states.walk)
		return
			
	#elif Input.is_action_just_pressed("jump"):
		#if parent.is_on_floor():
			#state_machine.change_state(state_machine.states.jump)
			#return
