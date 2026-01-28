extends Button
class_name RemapButton

@export var action: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.set_process_unhandled_input(false)
	self._update_key_text()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	self.set_process_unhandled_input(toggled_on)
	if self.button_pressed:
		self.text = "Awaiting input..."
		self.release_focus()
	else:
		self._update_key_text()
		self.grab_focus()
		
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		InputMap.action_erase_events(self.action)
		InputMap.action_add_event(self.action, event)
		self.button_pressed = false


func _update_key_text():
	self.text = "%s" % InputMap.action_get_events(self.action)[0].as_text()
