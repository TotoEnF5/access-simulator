extends CharacterBody2D

@export var speed: float = 500.0
@export var rotation_speed = 5.0

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		self.rotation -= self.rotation_speed * delta
	elif Input.is_action_pressed("move_right"):
		self.rotation += self.rotation_speed * delta
	
	if Input.is_action_pressed("move_up"):
		var direction = Vector2(cos(self.rotation), sin(self.rotation))
		self.velocity = direction * self.speed
		self.move_and_slide()
