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
	var right_pressed = Input.is_action_pressed("right")
	var left_pressed = Input.is_action_pressed("left")
	
	if ! has_jumped:
		player.velocity.y -= player.MAX_JUMP
		Utils.await_physics_frames(5, player)
		has_jumped = true
	
	if ! player.is_on_floor():
	#	Apply gravity
		player.velocity.y += player.JUMP_GRAVITY * delta
		
	if ! player.is_on_floor() && has_jumped:
		if player.velocity.y >= 0:
			state_machine.change_state(state_machine.states.fall)
			return
	
#		If the player is in the air	
#		Insert unique in-air movement here		
		if right_pressed && left_pressed:
			player.decelerate_x(delta)
		elif right_pressed || left_pressed:
			player.accelerate_x(delta)
