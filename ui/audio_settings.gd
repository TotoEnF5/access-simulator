extends Control

@export var mono_rtpc: WwiseRTPC


func _on_mono_sound_toggled(toggled_on: bool) -> void:
	var float_bool = float(toggled_on)
	SoundbankManager.event_UI.post(self)
	mono_rtpc.set_global_value(float_bool)
