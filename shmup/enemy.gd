extends RigidBody2D

@export var speed: float = 10.0
@export var direction: Vector2 = Vector2(-1.0, 0.0)
@export var shoot: bool = false
@export var shootCooldownMs: int = 600
@export var shootMercy: int = 200
@export var projectileSpeed: float = 30.0

@export var Mode_aveugle: bool = 1

## Event a call pour le mode aveugle
@onready var event_vroom_audio = $AkEvent2D_Vroom_Audiomode

var _lastShoot: int = 0
var _shouldShoot: bool = false

const _projectileScene: PackedScene = preload("res://shmup/projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vroom_aveugle_mode(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self._shouldShoot:
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


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	self._shouldShoot = self.shoot
	self._lastShoot = Time.get_ticks_msec() + self.shootMercy


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self.queue_free()
	

func _shoot():
	var projectile = self._projectileScene.instantiate()
	projectile.direction = Vector2(-1.0, 0.0)
	projectile.speed = self.projectileSpeed
	projectile.set_collision_layer_value(2, false)
	projectile.set_collision_mask_value(2, false)
	projectile.set_collision_layer_value(1, true)
	projectile.set_collision_mask_value(1, true)
	add_child(projectile)
	

func vroom_aveugle_mode(player):
	event_vroom_audio.post_event()
