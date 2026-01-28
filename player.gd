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

@export_group("Sound")
@export var Bankmanager: AkBank
@export var Mode_aveugle: bool

var _lastShoot: int = 0

const _projectileScene: PackedScene = preload("res://projectile.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Mode_aveugle: ## Bool si la feature pour aveugle pour le vroom est on
		SoundbankManager.event_engine.post(self)


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
		self._vertical_movement()
	elif self.mode == Mode.PLATFORMER:
		self._platformer_movement()
		
		
func _vertical_movement():
	# [SOUND] C'est ici qu'on bouge le joueur !
	# Ce qui serait cool ça serait que tu fasses une fonction à part histoire de bien organiser le code
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if self.mode == Mode.PLATFORMER:
		direction.y = 0.0
	elif self.mode == Mode.VROOM or self.mode == Mode.SHMUP:
		direction.x = 0.0
		
	if self.mode == Mode.VROOM:
		self.rotation = deg_to_rad(direction.y * 20.0 + 90.0)
	
	self.velocity = direction * self.speed
	self.move_and_slide()
	
	## Partie son
	var hauteur = 648 ### Variable à changer qui défini la hauteur en pixel
	Wwise.set_rtpc_value("Hauteur", clamp(100*(hauteur-self.position[1])/hauteur, 0, 100), self)
	if self.velocity[1] < 0:
		SoundbankManager.event_up_start.post(self)
		SoundbankManager.event_down_stop.post(self)
	elif self.velocity[1] > 0:
		SoundbankManager.event_down_start.post(self)
		SoundbankManager.event_up_stop.post(self)
	else:
		SoundbankManager.event_up_stop.post(self)
		SoundbankManager.event_down_stop.post(self)
	
	
func _platformer_movement():
	# [SOUND] C'est ici qu'on bouge le joueur !
	# Ce qui serait cool ça serait que tu fasses une fonction à part histoire de bien organiser le code
	self.velocity.y += self.gravity
	
	if Input.is_action_just_pressed("jump") and self.is_on_floor():
		# [SOUND] C'est ici que le joueur saute
		self.velocity.y = self.jump_speed
	
	var direction = Input.get_axis("move_left", "move_right")
	self.velocity.x = direction * self.speed
	self.move_and_slide()
