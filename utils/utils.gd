extends Node

class_name Utils

## Await the number of frames passed in [br]
## [param frames]: number of frames to await [br]
## [param physics_body]: Node2D in the tree
static func await_frames(frames: int, physics_body: Node2D):
	for frame in frames:
		await physics_body.get_tree().process_frame
		
## Await the number of physics frames passed in [br]
## [param frames]: number of frames to await [br]
## [param physics_body]: Node2D in the tree
static func await_physics_frames(frames: int, physics_body: Node2D):
	for frame in frames:
		await physics_body.get_tree().physics_frame
