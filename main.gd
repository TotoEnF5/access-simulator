extends Node2D

enum Level {
	VROOM = 1,
	SHMUP = 2,
	PLATFORMER = 3,
}

var current_level: Level = Level.PLATFORMER
var paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Vroom.process_mode = Node.PROCESS_MODE_DISABLED
	$Vroom.visible = false
	$Vroom/Camera2D.enabled = false
	
	$Shmup.process_mode = Node.PROCESS_MODE_DISABLED
	$Shmup.visible = false
	
	$Platformer.process_mode = Node.PROCESS_MODE_DISABLED
	$Platformer.visible = false
	$Platformer/Camera2D.enabled = false
	
	self._go_to_next_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_scene"):
		self._go_to_next_level()
		
	if Input.is_action_just_pressed("settings"):
		if not self.paused:
			self._pause_current_level()
			$InputSettings.visible = true
			self.paused = true
		else:
			self._play_current_level()
			$InputSettings.visible = false
			self.paused = false


func _on_shmup_player_won() -> void:
	self._go_to_next_level()


func _on_vroom_player_won() -> void:
	self._go_to_next_level()


func _on_platformer_player_won() -> void:
	self._go_to_next_level()
	

func _on_transition_curtains_closed() -> void:
	self._pause_current_level()
	self._hide_level()
	self._change_level()
	self._show_level()
		
		
func _go_to_next_level() -> void:
	$Transition.visible = true
	$Transition.start_animation(((self.current_level) % 3) + 1)


func _on_transition_curtains_opened() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.process_mode = Node.PROCESS_MODE_INHERIT
	elif self.current_level == Level.SHMUP:
		$Shmup.process_mode = Node.PROCESS_MODE_INHERIT
	elif self.current_level == Level.PLATFORMER:
		$Platformer.process_mode = Node.PROCESS_MODE_INHERIT
		
	$Transition.visible = false
		
		
func _pause_current_level() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.process_mode = Node.PROCESS_MODE_DISABLED
	elif self.current_level == Level.SHMUP:
		$Shmup.process_mode = Node.PROCESS_MODE_DISABLED
	elif self.current_level == Level.PLATFORMER:
		$Platformer.process_mode = Node.PROCESS_MODE_DISABLED
		
		
func _play_current_level() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.process_mode = Node.PROCESS_MODE_INHERIT
	elif self.current_level == Level.SHMUP:
		$Shmup.process_mode = Node.PROCESS_MODE_INHERIT
	elif self.current_level == Level.PLATFORMER:
		$Platformer.process_mode = Node.PROCESS_MODE_INHERIT

		
func _change_level() -> void:
	if self.current_level == Level.VROOM:
		self.current_level = Level.SHMUP
	elif self.current_level == Level.SHMUP:
		self.current_level = Level.PLATFORMER
	elif self.current_level == Level.PLATFORMER:
		self.current_level = Level.VROOM
		
		
func _hide_level() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.visible = false
		$Vroom/Camera2D.enabled = false
	elif self.current_level == Level.SHMUP:
		$Shmup.visible = false
	elif self.current_level == Level.PLATFORMER:
		$Platformer.visible = false
		$Platformer/Camera2D.enabled = false
		
		
func _show_level() -> void:
	if self.current_level == Level.VROOM:
		$Vroom.visible = true
		$Vroom/Camera2D.enabled = true
	elif self.current_level == Level.SHMUP:
		$Shmup.visible = true
	elif self.current_level == Level.PLATFORMER:
		$Platformer.visible = true
		$Platformer/Camera2D.enabled = true
