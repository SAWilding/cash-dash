extends CanvasLayer

@onready var label: Label = $Control/Label

var timer : float = 0.0

func _ready() -> void:
	label.text = "FPS: 0"
	
func _process(delta: float) -> void:
	timer += delta
	if timer >= 1.0:
		label.text = "FPS: " + str(Engine.get_frames_per_second())

	if Input.is_action_just_pressed("increase_fps"):
		Engine.max_fps += 10 
		print(Engine.max_fps)
	elif Input.is_action_just_pressed("decrease_fps"):
		Engine.max_fps -= 10 
		print(Engine.max_fps)
