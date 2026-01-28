extends Control

@export var action_items: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var canvas_pos = self.get_canvas_transform().origin
	self.global_position = -canvas_pos
