extends RigidBody2D

@export var speed: float = 100.0
@export var direction: Vector2 = Vector2(-1.0, 0.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func _physics_process(delta: float) -> void:
	var collision = self.move_and_collide(self.direction * self.speed)
	if collision:
		# collision.get_collider().free()
		self.queue_free()
