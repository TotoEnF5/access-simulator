extends CharacterBody2D

@export var speed: float = 500.0
@export var gravity: float = 9.81
@export var jump_speed: float = -500.0

@export_group("Sound")
@export var event_walk: WwiseEvent
@export var event_jump: WwiseEvent
@export var event_floor_impact: WwiseEvent
var stored_velocity_y: float

func _ready() -> void:
	access_settings.high_contrast_toggled.connect(self._on_high_contrast_toggled)
	access_settings.platformer_player_speed_changed.connect(self._on_speed_changed)
	access_settings.platformer_player_gravity_changed.connect(self._on_gravity_changed)
	access_settings.platformer_player_jump_changed.connect(self._on_jump_changed)
	
	self.speed = access_settings.platformer_player_speed
	self.jump_speed = -access_settings.platformer_player_jump
	self.gravity = access_settings.platformer_player_gravity
	if access_settings.high_contrast:
		self.modulate = Color(0.0, 0.0, 20.0)


func _physics_process(delta: float) -> void:
	# [SOUND] C'est ici qu'on bouge le joueur !
	# Ce qui serait cool ça serait que tu fasses une fonction à part histoire de bien organiser le code
	stored_velocity_y = self.velocity.y
	self.velocity.y += self.gravity
	
	if Input.is_action_just_pressed("jump") and self.is_on_floor():
		# [SOUND] C'est ici que le joueur saute
		SubtitleManager.add_subtitle("Jumping sound")
		event_jump.post(self)
		self.velocity.y = self.jump_speed	
	
	var direction = Input.get_axis("move_left", "move_right")
	self.velocity.x = direction * self.speed
	self.move_and_slide()
	
	if direction != 0:
		$Sprite2D.scale.x = direction
	
	# [SOUND] Son de walk si joueur bouge et touche le sol
	if abs(direction) != 0.0 and self.is_on_floor():
		if not SubtitleManager.has_subtitle("Footstep sound"):
			SubtitleManager.add_subtitle("Footstep sound")
		event_walk.post(self)
	# [SOUND] Son d'impact si le joueur touche le sol avec une vitesse supérieure à un seuil
	if stored_velocity_y - self.velocity.y >= 100.0 :
		SubtitleManager.add_subtitle("Landing sound")
		event_floor_impact.post(self)
		
		
func _on_high_contrast_toggled(toggled: bool) -> void:
	if toggled:
		self.modulate = Color(0.0, 0.0, 20.0)
	else:
		self.modulate = Color(1.0, 1.0, 1.0)
		
		
func _on_speed_changed(value: float):
	self.speed = value
		
		
func _on_gravity_changed(value: float):
	self.gravity = value
		
		
func _on_jump_changed(value: float):
	self.jump_speed = -value
