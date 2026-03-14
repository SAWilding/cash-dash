extends CharacterBody2D

class_name Player

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var state_machine: StateMachine = $PlayerStateMachine
@onready var debug_logger: Control = $DebugLogger
@onready var animation_player: AnimationPlayer = $AnimationPlayer


const JUMP_GRAVITY = 1000
const MAX_JUMP = 300
const MAX_SPEED = 50

# Number of physics frames allowed to pass before player can no longer jump after walking off the floor
const JUMP_FRAME_TOLERANCE = 10

var states = {}


var facing_direction = Vector2.ONE


func _ready() -> void:
	pass

	

func _process(delta: float) -> void:
	debug_logger.log("State: " + str(state_machine.current_state.state_name), self)

# Physics process is independent of the frame rate
func _physics_process(delta: float) -> void:	
	move_and_slide()
