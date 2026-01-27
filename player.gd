extends CharacterBody2D

enum Mode {
	PLATFORMER,
	SHMUP,
	VROOM,
	DEBUG,
}

@export var mode: Mode = Mode.DEBUG
@export var speed: float = 500
@export var jump_speed: float = -500.0
@export var gravity: float = 9.81
@export var shootCooldownMs: int = 100

var _lastShoot: int = 0

const _projectileScene: PackedScene = preload("res://projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if self.mode == Mode.SHMUP and Input.is_action_pressed("shoot"):
		var now: int = Time.get_ticks_msec()
		if now > self._lastShoot + self.shootCooldownMs:
			var projectile = self._projectileScene.instantiate()
			add_child(projectile)
			self._lastShoot = now
			

func _physics_process(delta: float) -> void:
	if self.mode == Mode.SHMUP or self.mode == Mode.VROOM:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		if self.mode == Mode.PLATFORMER:
			direction.y = 0.0
		elif self.mode == Mode.VROOM or self.mode == Mode.SHMUP:
			direction.x = 0.0
			
		if self.mode == Mode.VROOM:
			self.rotation = deg_to_rad(direction.y * 20.0 + 90.0)
		
		self.velocity = direction * self.speed
		self.move_and_slide()
	elif self.mode == Mode.PLATFORMER:
		self.velocity.y += self.gravity
		
		if Input.is_action_just_pressed("jump") and self.is_on_floor():
			self.velocity.y = self.jump_speed
		
		var direction = Input.get_axis("move_left", "move_right")
		self.velocity.x = direction * self.speed
		self.move_and_slide()
