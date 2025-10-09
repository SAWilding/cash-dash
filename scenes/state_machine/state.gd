extends Node

class_name State


var player: Node2D
var state_name: String
var state_machine: StateMachine

## Initialize the state with the parent node 
func _init(a_parent: Node2D, a_state_machine: StateMachine, a_state_name: String) -> void:
	player = a_parent
	state_machine = a_state_machine
	state_name = a_state_name
## Called when the state is first entered
func enter(): pass
	
## Called upon leaving the state to another
func exit(): pass

## Update the physics based on the current state
func update(delta: float): pass
