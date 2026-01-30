extends Control

signal over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.wait_time = access_settings.subtitle_time
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func get_label_minimum_size() -> Vector2:
	return $Label.get_minimum_size()
	
func set_text(text: String):
	$Label.text = text
	$ColorRect.size.x = $Label.get_minimum_size().x + 8
	$ColorRect.size.y = $Label.get_minimum_size().y + 8
	$ColorRect.position.x -= 4
	$ColorRect.position.y -= 4

	
func get_text() -> String:
	return $Label.text


func _on_timer_timeout() -> void:
	self.over.emit(self)
