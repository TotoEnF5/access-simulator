extends Node2D

signal curtains_closed
signal curtains_opened

func start_animation() -> void:
	self._close_curtains()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var canvas_pos = self.get_canvas_transform().origin
	self.global_position = -canvas_pos
	

func _on_timer_timeout() -> void:
	self._open_curtains()


func _close_curtains() -> void:
	var rightGoal = $Right.position
	rightGoal.x -= 1100
	var rightTween = get_tree().create_tween()
	rightTween.tween_property($Right, "position", rightGoal, 1.0).set_trans(Tween.TRANS_BACK)
	
	var leftGoal = $Left.position
	leftGoal.x += 1100
	var leftTween = get_tree().create_tween()
	leftTween.tween_property($Left, "position", leftGoal, 1.0).set_trans(Tween.TRANS_BACK)
	leftTween.tween_callback(self.curtains_closed.emit)
	leftTween.tween_callback($Timer.start)
	
	
func _open_curtains() -> void:
	var rightGoal = $Right.position
	rightGoal.x += 1100
	var rightTween = get_tree().create_tween()
	rightTween.tween_property($Right, "position", rightGoal, 1.0).set_trans(Tween.TRANS_BACK)
	
	var leftGoal = $Left.position
	leftGoal.x -= 1100
	var leftTween = get_tree().create_tween()
	leftTween.tween_property($Left, "position", leftGoal, 1.0).set_trans(Tween.TRANS_BACK)
	leftTween.tween_callback(self.curtains_opened.emit)
