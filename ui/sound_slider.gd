extends HSlider
@export var rtpc:WwiseRTPC
@export var rtpc_name:String = "None"

@export var event_feedback: WwiseEvent

func _enter_tree() -> void:
	self.value = rtpc.get_global_value()
	$RichTextLabel.text = rtpc_name + " " + str(round(value))
	

func _on_drag_ended(_value_changed: bool) -> void:
	event_feedback.stop(self)


func _on_drag_started() -> void:
	event_feedback.post(self)


func _on_value_changed(new_value: float) -> void:
	rtpc.set_global_value(new_value)
	$RichTextLabel.text = rtpc_name + " " + str(roundf(new_value))
