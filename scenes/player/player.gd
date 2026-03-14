extends CharacterBody2D

class_name Player

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: StateMachine = $PlayerStateMachine
@onready var debug_logger: Control = $DebugLogger

const FALL_GRAVITY = 0 # pixels per second
const MAX_FALL_SPEED = 0
const JUMP_GRAVITY = 1000
const MAX_JUMP = 300
const MAX_SPEED = 50
const ACCELERATION = 300
const DECELERATION = 600
# Number of physics frames allowed to pass before player can no longer jump after walking off the floor
const JUMP_FRAME_TOLERANCE = 10

var states = {}


var facing_direction = Vector2.ONE


func _ready() -> void:
	pass

	

func _process(delta: float) -> void:
	debug_logger.log("State: " + str(state_machine.current_state.state_name), self)
#	Flip the sprite to face the movement direction
	var move_sign = sign(velocity.x)
	if move_sign == 0:
		collision_shape.scale = facing_direction
		sprite.scale = facing_direction
	else:
		facing_direction = Vector2(move_sign, 1)
		collision_shape.scale = facing_direction
		sprite.scale = facing_direction

# Physics process is independent of the frame rate
func _physics_process(delta: float) -> void:	
	move_and_slide()

func accelerate_x(delta: float):
	var direction = Input.get_action_strength("right") - Input.get_action_strength("left")

#	If trying to move in opposite direction of current movement
	if direction != sign(velocity.x) && abs(velocity.x) > 0:
		decelerate_x(delta)
		
	else:
		#velocity.x += direction * ACCELERATION  * delta
		velocity.x += direction  * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

func decelerate_x(delta: float):
#		Slow the player back to 0 x velocity if no input it pressed and they aren't already at 0 velocity
		if velocity.x != 0:
			if abs(velocity.x) < DECELERATION * delta:
				velocity.x = 0
			else:
				if sign(velocity.x) == -1:
					velocity.x += DECELERATION * delta
				else:
					velocity.x -= DECELERATION * delta
