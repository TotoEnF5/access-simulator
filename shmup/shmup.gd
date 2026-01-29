extends Node2D

signal player_won

@export var enemy_cooldown_ms: int = 1000
@export var enemy_speed: float = 10
@export var enemy_shoot_cooldown_ms: int = 600
@export var enemy_shoot: bool = true
@export var enemy_projectile_speed: float = 30.0
@export var max_score: int = 3

var _score: int = 0
var _lastEnemyTime: int = 0

const _enemyScene: PackedScene = preload("res://shmup/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var now: int = Time.get_ticks_msec()
	if now > self.enemy_cooldown_ms + self._lastEnemyTime:
		# [SOUND] C'est ici qu'on spawne un ennemi
		self._spawn_enemy()
		self._lastEnemyTime = now
		

func _spawn_enemy() -> void:
	var viewportSize = get_viewport().get_visible_rect().size
	var y = randf() * viewportSize.y
	var enemyPos = Vector2(viewportSize.x + 200, y)
	var enemy = self._enemyScene.instantiate()
	enemy.position = enemyPos
	enemy.speed = self.enemy_speed
	enemy.shootCooldownMs = self.enemy_shoot_cooldown_ms
	enemy.shoot = self.enemy_shoot
	enemy.projectileSpeed = self.enemy_projectile_speed
	enemy.connect("killed", self._increment_score)
	add_child(enemy)
	
	
func _increment_score() -> void:
	self._score += 1
	if self._score >= self.max_score:
		self.player_won.emit()
