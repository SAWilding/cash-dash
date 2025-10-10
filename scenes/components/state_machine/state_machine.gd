extends Node

class_name StateMachine

var states = {}
var previous_state: State
var current_state: State

func _physics_process(delta: float) -> void:
	current_state.update(delta)

func change_state(new_state: State):
#	Save off the previous state
	previous_state = current_state
#	If the new state and the current are the same, do nothing
	if new_state == current_state:
		return
	
	current_state.exit()
	current_state = new_state
	current_state.enter()
