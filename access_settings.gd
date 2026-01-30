extends Node

signal high_contrast_toggled
signal vroom_player_speed_changed
signal vroom_player_rotation_speed_changed

var high_contrast: bool = false
var vroom_player_speed: float = 500.0
var vroom_player_rotation_speed: float = 500.0

func set_high_contrast(toggled: bool) -> void:
	self.high_contrast = toggled
	self.high_contrast_toggled.emit(self.high_contrast)
	
	
func set_vroom_player_speed(value: float) -> void:
	self.vroom_player_speed = value
	self.vroom_player_speed_changed.emit(self.vroom_player_speed)
	
	
func set_vroom_player_rotation_speed(value: float) -> void:
	self.vroom_player_rotation_speed = value
	self.vroom_player_rotation_speed_changed.emit(self.vroom_player_rotation_speed)
