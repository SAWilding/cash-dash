extends State
	
var velocity = Vector2()
## Called when the state is first entered
func enter(): pass
	
## Called upon leaving the state to another
func exit(): pass

## Update the physics based on the current state
func update(delta: float):
#   Change state to jump if jump key is pressed
	#if Input.is_action_pressed("jump"):
		#state_machine.change_state(state_machine.states.jump)
		#return
		
	velocity = Vector2()  # Reset velocity each frame

	# Get input from arrow keys or WASD
	if Input.is_action_pressed("right"):  # Right arrow or 'D'
		velocity.x += 1
	if Input.is_action_pressed("left"):   # Left arrow or 'A'
		velocity.x -= 1
	if Input.is_action_pressed("down"):   # Down arrow or 'S'
		velocity.y += 1
	if Input.is_action_pressed("up"):     # Up arrow or 'W'
		velocity.y -= 1

	# Normalize to prevent faster diagonal movement
	parent.velocity = velocity.normalized() * parent.MAX_SPEED

	# Move the KinematicBody2D
	parent.move_and_slide()
	
	if parent.velocity == Vector2.ZERO:
		state_machine.change_state(state_machine.states.idle)
	
	
#func apply_floor_movement(delta: float):
	#var right_pressed = Input.is_action_pressed("right")
	#var left_pressed = Input.is_action_pressed("left")
	#
	#if right_pressed && left_pressed:
		#parent.decelerate_x(delta)
	#elif right_pressed || left_pressed:
		#parent.accelerate_x(delta)
	#else:
		#state_machine.change_state(state_machine.states.idle)
		#return
