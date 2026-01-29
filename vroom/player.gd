extends CharacterBody2D

@export var speed: float = 500.0
@export var rotation_speed = 5.0

@export_group("Sound")
@export var event_moove: WwiseEvent
@export var event_rotate: WwiseEvent


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		event_rotate.post(self)
		self.rotation -= self.rotation_speed * delta
	elif Input.is_action_pressed("move_right"):
		event_rotate.post(self)
		self.rotation += self.rotation_speed * delta
	else:
		event_rotate.stop(self)
	
	if Input.is_action_pressed("move_up"):
		var direction = Vector2(cos(self.rotation), sin(self.rotation))
		self.velocity = direction * self.speed
		self.move_and_slide()
		event_moove.post(self)
	else:
		event_moove.stop(self)
	
