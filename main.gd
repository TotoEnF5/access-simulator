extends Node2D

enum Level {
	VROOM = 1,
	SHMUP = 2,
	PLATFORMER = 3,
}

@export var current_level: Level = Level.VROOM
var current_level_node: Node2D
var first_animation: bool = true
var paused: bool = false

const _vroom_scene: PackedScene = preload("res://vroom/vroom.tscn")
const _shmup_scene: PackedScene = preload("res://shmup/shmup.tscn")
const _platformer_scene: PackedScene = preload("res://platformer/platformer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/Transition.start_animation(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_scene"):
		$CanvasLayer/Transition.start_animation(self.current_level % 3 + 1)
		
	if Input.is_action_just_pressed("settings"):
		if not self.paused:
			$CanvasLayer/Settings.visible = true
			self.paused = true
		else:
			$CanvasLayer/Settings.visible = false
			self.paused = false


func _on_transition_curtains_closed() -> void:
	if not self.first_animation:
		self._go_to_next_level()
	else:
		self._load_current_level()
		self.first_animation = false
		
	# self.current_level_node.process_mode = Node.PROCESS_MODE_DISABLED


func _on_transition_curtains_opened() -> void:
	# self.current_level_node.process_mode = Node.PROCESS_MODE_INHERIT
	pass
	
	
func _on_player_won() -> void:
	$CanvasLayer/Transition.start_animation(self.current_level % 3 + 1)
	

func _go_to_next_level():
	self.current_level_node.queue_free()
	self._change_current_level()
	self._load_current_level()
	
	
func _change_current_level():
	if self.current_level == Level.VROOM:
		self.current_level = Level.SHMUP
		return
	if self.current_level == Level.SHMUP:
		self.current_level = Level.PLATFORMER
		return
	if self.current_level == Level.PLATFORMER:
		self.current_level = Level.VROOM
		return
	

func _load_current_level():
	if self.current_level == Level.VROOM:
		self.current_level_node = self._vroom_scene.instantiate()
	if self.current_level == Level.SHMUP:
		self.current_level_node = self._shmup_scene.instantiate()
	if self.current_level == Level.PLATFORMER:
		self.current_level_node = self._platformer_scene.instantiate()
		
	self.current_level_node.connect("player_won", self._on_player_won)
	self.add_child(self.current_level_node)
