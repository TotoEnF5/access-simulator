extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_high_contrast_toggled(toggled_on: bool) -> void:
	access_settings.set_high_contrast(toggled_on)


func _on_player_speed_slider_value_changed(value: float) -> void:
	access_settings.set_vroom_player_speed(value)


func _on_player_rotation_speed_slider_value_changed(value: float) -> void:
	access_settings.set_vroom_player_rotation_speed(value)


func _on_shmup_player_speed_slider_value_changed(value: float) -> void:
	access_settings.set_shmup_player_speed(value)


func _on_shmup_player_projectile_speed_slider_value_changed(value: float) -> void:
	access_settings.set_shmup_player_projectile_speed(value)


func _on_player_projectile_cooldown_slider_value_changed(value: float) -> void:
	access_settings.set_shmup_player_projectile_cooldown(value)


func _on_shmup_enemy_speed_slider_value_changed(value: float) -> void:
	access_settings.set_shmup_enemy_speed(value)


func _on_shmup_enemy_projectile_speed_slider_value_changed(value: float) -> void:
	access_settings.set_shmup_enemy_projectile_speed(value)


func _on_shmup_enemy_projectile_cooldown_slider_value_changed(value: float) -> void:
	access_settings.set_shmup_enemy_projectile_cooldown(value)


func _on_shmup_enemy_frequency_slider_value_changed(value: float) -> void:
	access_settings.set_shmup_enemy_cooldown(value)


func _on_platformer_player_speed_slider_value_changed(value: float) -> void:
	access_settings.set_platformer_player_speed(value)


func _on_platformer_player_jump_force_slider_value_changed(value: float) -> void:
	access_settings.set_platformer_player_jump(value)


func _on_platformer_player_gravity_slider_value_changed(value: float) -> void:
	access_settings.set_platformer_player_gravity(value)
