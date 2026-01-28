extends Node2D

enum Level {
	VROOM,
	SHMUP,
	PLATFORMER,
}

@export var start_level_minus_one: Level = Level.PLATFORMER

var current_level: Level = self.start_level_minus_one

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Vroom.process_mode = Node.PROCESS_MODE_DISABLED
	$Vroom.visible = false
	
	$Shmup.process_mode = Node.PROCESS_MODE_DISABLED
	$Shmup.visible = false
	
	$Platformer.process_mode = Node.PROCESS_MODE_DISABLED
	$Platformer.visible = false
	$Platformer/Camera2D.enabled = false
	
	$Transition.start_animation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_scene"):
		$Transition.start_animation()


func _on_transition_curtains_closed() -> void:
	self._change_level()
	self._show_level()


func _on_transition_curtains_opened() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.process_mode = Node.PROCESS_MODE_INHERIT
	elif self.current_level == Level.SHMUP:
		$Shmup.process_mode = Node.PROCESS_MODE_INHERIT
	elif self.current_level == Level.PLATFORMER:
		$Platformer.process_mode = Node.PROCESS_MODE_INHERIT
		
		
func _change_level() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.process_mode = Node.PROCESS_MODE_DISABLED
		$Vroom.visible = false
		self.current_level = Level.SHMUP
	elif self.current_level == Level.SHMUP:
		$Shmup.process_mode = Node.PROCESS_MODE_DISABLED
		$Shmup.visible = false
		self.current_level = Level.PLATFORMER
	elif self.current_level == Level.PLATFORMER:
		$Platformer.process_mode = Node.PROCESS_MODE_DISABLED
		$Platformer.visible = false
		$Platformer/Camera2D.enabled = false
		self.current_level = Level.VROOM
		
		
func _show_level() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.visible = true
	elif self.current_level == Level.SHMUP:
		$Shmup.visible = true
	elif self.current_level == Level.PLATFORMER:
		$Platformer.visible = true
		$Platformer/Camera2D.enabled = true
