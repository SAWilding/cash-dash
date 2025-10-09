extends StateMachine

class_name PlayerStateMachine

@export var player: Player

func _ready() -> void:
	#	Load all states and pass in the player
	states.idle = preload("uid://ctxunt7hiunkp").new(player, self, "IDLE")
	states.walk = preload("uid://glinnl8qkrne").new(player, self, "WALK")
	states.jump = preload("uid://c5cd47xkcyl3k").new(player, self, "JUMP")
	states.fall = preload("uid://mbxnha6xlw15").new(player, self, "FALL")
	
#	Set the initial state to IDLE
	current_state = states.idle
	

	

	
