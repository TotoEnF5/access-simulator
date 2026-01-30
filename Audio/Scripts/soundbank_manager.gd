extends AkBank

@export_group("UI Event")
@export var event_UI: WwiseEvent
@export var event_win: WwiseEvent
@export var event_ennemi_death: WwiseEvent

func _on_platformer_player_won() -> void:
	event_win.post(self)

func _on_shmup_player_won() -> void:
	event_win.post(self)

func _on_vroom_player_won() -> void:
	event_win.post(self)
