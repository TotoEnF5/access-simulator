extends CanvasLayer

const _subtitle_scene: PackedScene = preload("res://ui/subtitle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func add_subtitle(text: String):
	var subtitle = _subtitle_scene.instantiate()
	subtitle.set_text(text)
	subtitle.custom_minimum_size = Vector2(0.0, 27.0)
	subtitle.over.connect(self._on_subtitle_over)
	$Control/VBoxContainer.add_child(subtitle)
	
	
func has_subtitle(text: String) -> bool:
	for subtitle in $Control/VBoxContainer.get_children():
		if subtitle.get_text() == text:
			return true
	return false
	
	
func _on_subtitle_over(subtitle: Control):
	subtitle.queue_free()
