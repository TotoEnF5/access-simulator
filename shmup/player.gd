extends CharacterBody2D

@export var speed: float = 500.0
@export var shoot_colldown_ms: int = 100

var _last_shoot: int = 0

const _projectile_scene: PackedScene = preload("res://shmup/projectile.tscn")

func _ready() ->void:
	access_settings.high_contrast_toggled.connect(self._on_high_contrast_toggled)
	if access_settings.high_contrast:
		self.modulate = Color(0.0, 0.0, 20.0)


func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		var now: int = Time.get_ticks_msec()
		if now > self._last_shoot + self.shoot_colldown_ms:
			var projectile = self._projectile_scene.instantiate()
			add_child(projectile)
			self._last_shoot = now
			$AkEvent2D_Shoot.post_event()


func _physics_process(delta: float):
	# [SOUND] C'est ici qu'on bouge le joueur !
	# Ce qui serait cool ça serait que tu fasses une fonction à part histoire de bien organiser le code
	var direction = Input.get_axis("move_up", "move_down")
	self.velocity.y = direction * self.speed
	self.move_and_slide()
		
		
func _on_high_contrast_toggled(toggled: bool) -> void:
	if toggled:
		self.modulate = Color(0.0, 0.0, 20.0)
	else:
		self.modulate = Color(1.0, 1.0, 1.0)
