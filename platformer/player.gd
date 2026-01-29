extends CharacterBody2D

@export var speed: float = 500.0
@export var gravity: float = 9.81
@export var jump_speed: float = -500.0

@export_group("Sound")
@export var event_walk: WwiseEvent
@export var event_jump: WwiseEvent

func _physics_process(delta: float) -> void:
	# [SOUND] C'est ici qu'on bouge le joueur !
	# Ce qui serait cool ça serait que tu fasses une fonction à part histoire de bien organiser le code
	self.velocity.y += self.gravity
	
	if Input.is_action_just_pressed("jump") and self.is_on_floor():
		# [SOUND] C'est ici que le joueur saute
		event_jump.post(self)
		self.velocity.y = self.jump_speed
		
	
	var direction = Input.get_axis("move_left", "move_right")
	self.velocity.x = direction * self.speed
	if abs(direction) != 0.0 and self.is_on_floor():
		event_walk.post(self)
	self.move_and_slide()
