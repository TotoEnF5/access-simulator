extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	access_settings.high_contrast_toggled.connect(self._on_high_contrast_toggled)
	if access_settings.high_contrast:
		self.modulate = Color(0.0, 0.0, 0.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _on_high_contrast_toggled(toggled: bool) -> void:
	if toggled:
		self.modulate = Color(0.0, 0.0, 0.0)
	else:
		self.modulate = Color(1.0, 1.0, 1.0)
