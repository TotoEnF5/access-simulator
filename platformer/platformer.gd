extends Node2D

signal player_won

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Goal.visible = false
	$Platforms.visible = false
	$Camera2D.position = $Player.position
	
	if access_settings.high_contrast:
		$Goal.visible = true
		$Goal.modulate = Color(0.0, 20.0, 0.0)
		$Platforms.visible = true
		$Platforms.modulate = Color(0.0, 0.0, 0.0)
		$Node2D.modulate = Color(0.5, 0.5, 0.5)
		
	access_settings.high_contrast_toggled.connect(self._on_high_contrast_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera2D.position = $Camera2D.position.lerp($Player.position, delta * 4.0)


func _on_goal_body_entered(body: Node2D) -> void:
	self.player_won.emit()
	
	
func _on_high_contrast_changed(toggled: bool):
	if toggled:
		$Goal.visible = true
		$Goal.modulate = Color(0.0, 20.0, 0.0)
		$Platforms.visible = true
		$Platforms.modulate = Color(0.0, 0.0, 0.0)
		$Node2D.modulate = Color(0.5, 0.5, 0.5)
	else:
		$Goal.visible = false
		$Platforms.visible = false
		$Node2D.modulate = Color(1.0, 1.0, 1.0)
