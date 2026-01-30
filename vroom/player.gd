extends CharacterBody2D

@export var speed: float = 500.0
@export var rotation_speed: float = 5.0

@export_group("Sound")
@export var event_moove: WwiseEvent
@export var event_rotate: WwiseEvent

func _ready() -> void:
	access_settings.high_contrast_toggled.connect(self._on_high_contrast_toggled)
	access_settings.vroom_player_speed_changed.connect(self._on_speed_changed)
	access_settings.vroom_player_rotation_speed_changed.connect(self._on_rotation_speed_changed)
	
	self.speed = access_settings.vroom_player_speed
	self.rotation_speed = access_settings.vroom_player_rotation_speed
	if access_settings.high_contrast:
		self.modulate = Color(0.0, 0.0, 20.0)


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		if not SubtitleManager.has_subtitle("Water flowing"):
			SubtitleManager.add_subtitle("Water flowing")
		
		event_rotate.post(self)
		self.rotation -= self.rotation_speed * delta
	elif Input.is_action_pressed("move_right"):
		if not SubtitleManager.has_subtitle("Water flowing"):
			SubtitleManager.add_subtitle("Water flowing")
			
		event_rotate.post(self)
		self.rotation += self.rotation_speed * delta
	else:
		event_rotate.stop(self)
	
	if Input.is_action_pressed("move_up"):
		if not SubtitleManager.has_subtitle("Water flowing"):
			SubtitleManager.add_subtitle("Water flowing")
			
		var direction = Vector2(cos(self.rotation), sin(self.rotation))
		self.velocity = direction * self.speed
		self.move_and_slide()
		event_moove.post(self)
	else:
		event_moove.stop(self)
		
		
func _on_high_contrast_toggled(toggled: bool) -> void:
	if toggled:
		self.modulate = Color(0.0, 0.0, 20.0)
	else:
		self.modulate = Color(1.0, 1.0, 1.0)
		
		
func _on_speed_changed(value: float) -> void:
	self.speed = value
	
	
func _on_rotation_speed_changed(value: float) -> void:
	self.rotation_speed = value
