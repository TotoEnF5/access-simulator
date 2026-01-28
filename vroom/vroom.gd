extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.position = $Player.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera2D.position = $Camera2D.position.lerp($Player.position, delta * 4.0)
