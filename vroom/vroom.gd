extends Node2D

signal player_won

var _do_camera_lerp: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.process_mode = Node.PROCESS_MODE_DISABLED
	$Walls.visible = false
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self._do_camera_lerp:
		$Camera2D.position = $Camera2D.position.lerp($Player.position, delta * 4.0)


func _on_goal_body_entered(body: Node2D) -> void:
	player_won.emit()


func _on_timer_timeout() -> void:
	var zoom_tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	zoom_tween.tween_property($Camera2D, "zoom", Vector2(1, 1), 5.0)
	
	var position_tween = get_tree().create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	position_tween.tween_property($Camera2D, "position", $Player.position, 5.0)
	position_tween.tween_callback(func ():
		$Player.process_mode = Node.PROCESS_MODE_INHERIT
		self._do_camera_lerp = true
	)
