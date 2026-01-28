extends Node2D

@export var enemyCooldownMs: int = 1000

var _lastEnemyTime: int = 0

const _enemyScene: PackedScene = preload("res://enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var now: int = Time.get_ticks_msec()
	if now > self.enemyCooldownMs + self._lastEnemyTime:
		# [SOUND] C'est ici qu'on spawne un ennemi
		self._spawn_enemy()
		self._lastEnemyTime = now
		

func _spawn_enemy() -> void:
	var viewportSize = get_viewport().get_visible_rect().size
	var y = randf() * viewportSize.y
	var enemyPos = Vector2(viewportSize.x + 200, y)
	var enemy = self._enemyScene.instantiate()
	enemy.position = enemyPos
	enemy.shoot = true
	add_child(enemy)
	
