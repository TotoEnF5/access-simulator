extends HSlider
@export var rtpc:WwiseRTPC
@export var rtpc_name:String = "None"

func _ready() -> void:
	$RichTextLabel.text = rtpc_name

func _on_value_changed(value: float) -> void:
	rtpc.set_value(self, value)
