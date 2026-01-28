extends CharacterBody2D

@export var speed: float = 500.0
@export var shoot_colldown_ms: int = 100

var _last_shoot: int = 0

const _projectile_scene: PackedScene = preload("res://shmup/projectile.tscn")

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		var now: int = Time.get_ticks_msec()
		if now > self._last_shoot + self.shoot_colldown_ms:
			var projectile = self._projectile_scene.instantiate()
			add_child(projectile)
			self._last_shoot = now


func _physics_process(delta: float):
	# [SOUND] C'est ici qu'on bouge le joueur !
	# Ce qui serait cool ça serait que tu fasses une fonction à part histoire de bien organiser le code
	var direction = Input.get_axis("move_up", "move_down")
	self.velocity.y = direction * self.speed
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
