extends Node

signal high_contrast_toggled
signal vroom_player_speed_changed
signal vroom_player_rotation_speed_changed
signal shmup_player_speed_changed
signal shmup_player_projectile_speed_changed
signal shmup_player_projectile_cooldown_changed
signal shmup_enemy_speed_changed
signal shmup_enemy_projectile_speed_changed
signal shmup_enemy_projectile_cooldown_changed
signal shmup_enemy_cooldown_changed
signal platformer_player_speed_changed
signal platformer_player_jump_changed
signal platformer_player_gravity_changed

var high_contrast: bool = false
var vroom_player_speed: float = 500.0
var vroom_player_rotation_speed: float = 5.0
var shmup_player_speed: float = 500.0
var shmup_player_projectile_speed: float = 100.0
var shmup_player_projectile_cooldown: int = 100
var shmup_enemy_speed: float = 10.0
var shmup_enemy_projectile_speed: float = 30.0
var shmup_enemy_projectile_cooldown: int = 600
var shmup_enemy_cooldown: int = 1000
var platformer_player_speed: float = 500.0
var platformer_player_jump: float = 500.0
var platformer_player_gravity: float = 9.81

func set_high_contrast(toggled: bool) -> void:
	self.high_contrast = toggled
	self.high_contrast_toggled.emit(self.high_contrast)
	
	
func set_vroom_player_speed(value: float) -> void:
	self.vroom_player_speed = value
	self.vroom_player_speed_changed.emit(self.vroom_player_speed)
	
	
func set_vroom_player_rotation_speed(value: float) -> void:
	self.vroom_player_rotation_speed = value
	self.vroom_player_rotation_speed_changed.emit(self.vroom_player_rotation_speed)
	
	
func set_shmup_player_speed(value: float) -> void:
	self.shmup_player_speed = value
	self.shmup_player_speed_changed.emit(self.shmup_player_speed)
	
	
func set_shmup_player_projectile_speed(value: float) -> void:
	self.shmup_player_projectile_speed = value
	self.shmup_player_projectile_speed_changed.emit(self.shmup_player_projectile_speed)
	
	

func set_shmup_player_projectile_cooldown(value: int) -> void:
	self.shmup_player_projectile_cooldown = value
	self.shmup_player_projectile_cooldown_changed.emit(self.shmup_player_projectile_cooldown)
	
	
func set_shmup_enemy_speed(value: float) -> void:
	self.shmup_enemy_speed = value
	self.shmup_enemy_speed_changed.emit(self.shmup_enemy_speed)
	
	
func set_shmup_enemy_projectile_speed(value: float) -> void:
	self.shmup_enemy_projectile_speed = value
	self.shmup_enemy_projectile_speed_changed.emit(self.shmup_enemy_projectile_speed)
	
	
func set_shmup_enemy_projectile_cooldown(value: int) -> void:
	self.shmup_enemy_projectile_cooldown = value
	self.shmup_enemy_projectile_cooldown_changed.emit(self.shmup_enemy_projectile_cooldown)
	
	
func set_shmup_enemy_cooldown(value: int) -> void:
	self.shmup_enemy_cooldown = value
	self.shmup_enemy_cooldown_changed.emit(self.shmup_enemy_cooldown)
	
	
func set_platformer_player_speed(value: float):
	self.platformer_player_speed = value
	self.platformer_player_speed_changed.emit(self.platformer_player_speed)
	
	
func set_platformer_player_gravity(value: float):
	self.platformer_player_gravity = value
	self.platformer_player_gravity_changed.emit(self.platformer_player_gravity)
	
	
func set_platformer_player_jump(value: float):
	self.platformer_player_jump = value
	self.platformer_player_jump_changed.emit(self.platformer_player_jump)
