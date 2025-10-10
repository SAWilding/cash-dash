extends Node

var player: Player
const MELEE_ATTACK = preload("uid://ckn0ktfwp1vrw")
const MELEE_ATTACK_COOLDOWN = 0.4 # second
var is_cooldown_done: bool = true

func _process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		perform_melee_attack()

func perform_melee_attack():
	if is_cooldown_done == false:
		return
	if MELEE_ATTACK == null:
		return
	is_cooldown_done = false
	var melee_attack_instance = MELEE_ATTACK.instantiate()
	
	player = Utils.get_player(self)
	if player == null:
		return
	print("attacking")
	melee_attack_instance.scale = player.facing_direction
	melee_attack_instance.global_position = player.global_position
	get_parent().add_child(melee_attack_instance)
	is_cooldown_done = await Utils.await_cooldown(MELEE_ATTACK_COOLDOWN, self)

	
