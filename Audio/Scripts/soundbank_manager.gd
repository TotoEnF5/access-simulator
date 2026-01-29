extends AkBank

@export_group("Moove Event")
@export var event_up_start : WwiseEvent
@export var event_up_stop : WwiseEvent
@export var event_down_start : WwiseEvent
@export var event_down_stop : WwiseEvent
@export var event_engine : WwiseEvent

@export_group("UI Event")
@export var event_UI: WwiseEvent
@export var event_win: WwiseEvent

func _on_platformer_player_won() -> void:
	event_win.post(self)

func _on_shmup_player_won() -> void:
	event_win.post(self)

func _on_vroom_player_won() -> void:
	event_win.post(self)
