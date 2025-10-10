extends Node2D

var player: Player

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	player = Utils.get_player(self)
	if player == null:
		return
	global_position = player.global_position + (Vector2.UP * 5) 
	global_position.x += + (player.facing_direction.x * 15)
	animation_player.play("attack")
	
