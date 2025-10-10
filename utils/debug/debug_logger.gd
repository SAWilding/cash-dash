extends Control
@onready var label: Label = $Label


func log(string: String, parent_node: Node2D):
	self.global_position = parent_node.global_position + (Vector2.UP * 20)
	label.text = string

func append_log(string: String):
	label.text += "\n" + string
	
