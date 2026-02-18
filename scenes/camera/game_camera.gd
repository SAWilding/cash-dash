extends Camera2D

var target_position = Vector2.ZERO

const CAMERA_SMOOTHING = 5 # the smaller the smoother

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_current() # Set to the current camera

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	acquire_target()
#	lerp means linear interpolate - get a point that is a percentage between global_position and target_position
#   1.0 - exp(-delta * 10) allows the camera movement to be independent of the framerate
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * CAMERA_SMOOTHING))


func acquire_target() -> void:
	var player_nodes = get_tree().get_nodes_in_group("player") # this is how to access a global group
	if player_nodes.size() > 0:
		var player = player_nodes[0] as Player # the Node2D is all we need, so grab the 1st index
		target_position = player.global_position
	
