extends RigidBody2D

@export var speed: float = 10.0
@export var direction: Vector2 = Vector2(-1.0, 0.0)
@export var shoot: bool = false
@export var shootCooldownMs: int = 300

var _lastShoot: int = 0

const _projectileScene: PackedScene = preload("res://projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.shoot:
		var now: int = Time.get_ticks_msec()
		if now > self._lastShoot + self.shootCooldownMs:
			# [SOUND] C'est ici que l'ennemi shoote
			self._shoot()
			self._lastShoot = now
	
func _physics_process(delta: float) -> void:
	var collision = self.move_and_collide(self.direction * self.speed)
	if collision:
		# [SOUND] C'est ici que l'ennmi décède
		self.queue_free()


func _shoot():
	var projectile = self._projectileScene.instantiate()
	projectile.direction = Vector2(-1.0, 0.0)
	projectile.set_collision_layer_value(2, false)
	projectile.set_collision_mask_value(2, false)
	projectile.set_collision_layer_value(1, true)
	projectile.set_collision_mask_value(1, true)
	add_child(projectile)
