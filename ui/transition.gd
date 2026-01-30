extends Node2D

signal curtains_closed
signal curtains_opened

var _act: int = 0

const _background_init_pos: Vector2 = Vector2(575.5, -371.0)
const _stars_init_pos: Vector2 = Vector2(576.25, -404.0)
const _clouds_init_pos: Vector2 = Vector2(576.0, 777.0)
const _sign_init_pos: Vector2 = Vector2(565.0, -491.0)
const _left_curtain_init_pos: Vector2 = Vector2(-155.0, 298.822)
const _right_curtain_init_pos: Vector2 = Vector2(1314.0, 298.25)
const _stage_init_pos: Vector2 = Vector2(577.0, 704.0)
const _up_curtain_init_pos: Vector2 = Vector2(576.0, -71.0)

const _background_goal_pos: Vector2 = Vector2(575.5, 323.5)
const _stars_goal_pos: Vector2 = Vector2(576.25, 361.64)
const _clouds_goal_pos: Vector2 = Vector2(576.0, 482.0)
const _sign_goal_pos: Vector2 = Vector2(565.0, 204.0)
const _left_curtain_goal_pos: Vector2 = Vector2(129.0, 298.822)
const _right_curtain_goal_pos: Vector2 = Vector2(1022.0, 298.25)
const _stage_goal_pos: Vector2 = Vector2(577.0, 601.0)
const _up_curtain_goal_pos: Vector2 = Vector2(576.0, 58.099)

@export_group("Sound")
@export var event_curtain_in: WwiseEvent
@export var event_curtain_out: WwiseEvent

func start_animation(act: int) -> void:
	self._act = act
	self._close_curtains()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var canvas_pos = self.get_canvas_transform().origin
	#self.global_position = -canvas_pos
	#self.global_scale.x = 1.0 / self.get_canvas_transform().get_scale().x
	#self.global_scale.y = 1.0 / self.get_canvas_transform().get_scale().y
	pass
	

func _on_timer_timeout() -> void:
	self._open_curtains()


func _set_init_pos() -> void:
	$Layer1BgSky.position = self._background_init_pos
	$Layer2Stars.position = self._stars_init_pos
	$Layer3Clouds.position = self._clouds_init_pos
	$Layer5CurtainLeft.position = self._left_curtain_init_pos
	$Layer5CurtainRight.position = self._right_curtain_init_pos
	$Layer6Stage.position = self._stage_init_pos
	$Layer7CurtainUp.position = self._up_curtain_init_pos


func _close_curtains() -> void:
	event_curtain_in.post(self)
	self._set_init_pos()
	
	var background_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	background_tween.tween_property($Layer1BgSky, "position", self._background_goal_pos, 0.8)
	background_tween.tween_callback(func ():
		var sign_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		if self._act == 1:
			sign_tween.tween_property($Layer4Act1, "position", self._sign_goal_pos, 0.8)
		elif self._act == 2:
			sign_tween.tween_property($Layer4Act2, "position", self._sign_goal_pos, 0.8)
		elif self._act == 3:
			sign_tween.tween_property($Layer4Act3, "position", self._sign_goal_pos, 0.8)
	
		var stars_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		stars_tween.tween_property($Layer2Stars, "position", self._stars_goal_pos, 0.8)
		
		var stage_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		stage_tween.tween_property($Layer6Stage, "position", self._stage_goal_pos, 0.8)
		stage_tween.tween_property($Layer3Clouds, "position", self._clouds_goal_pos, 0.8)
		
		var left_curtain_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		left_curtain_tween.tween_property($Layer5CurtainLeft, "position", self._left_curtain_goal_pos, 0.8)
		left_curtain_tween.tween_callback(self.curtains_closed.emit)
		
		var right_curtain_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		right_curtain_tween.tween_property($Layer5CurtainRight, "position", self._right_curtain_goal_pos, 0.8)
		right_curtain_tween.tween_property($Layer7CurtainUp, "position", self._up_curtain_goal_pos, 0.8)
		right_curtain_tween.tween_callback($Timer.start)
	)
	
	
func _open_curtains() -> void:
	event_curtain_out.post(self)
	var background_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	background_tween.tween_property($Layer1BgSky, "position", self._background_init_pos, 0.8)
	
	var sign_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	if self._act == 1:
		sign_tween.tween_property($Layer4Act1, "position", self._sign_init_pos, 0.8)
	elif self._act == 2:
		sign_tween.tween_property($Layer4Act2, "position", self._sign_init_pos, 0.8)
	elif self._act == 3:
		sign_tween.tween_property($Layer4Act3, "position", self._sign_init_pos, 0.8)

	var stars_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	stars_tween.tween_property($Layer2Stars, "position", self._stars_init_pos, 0.8)
	
	var stage_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	stage_tween.tween_property($Layer6Stage, "position", self._stage_init_pos, 0.8)
	
	var clouds_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	clouds_tween.tween_property($Layer3Clouds, "position", self._clouds_init_pos, 0.8)
	
	var left_curtain_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	left_curtain_tween.tween_property($Layer5CurtainLeft, "position", self._left_curtain_init_pos, 0.8)
	
	var right_curtain_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	right_curtain_tween.tween_property($Layer5CurtainRight, "position", self._right_curtain_init_pos, 0.8)
	
	var up_curtain_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	up_curtain_tween.tween_property($Layer7CurtainUp, "position", self._up_curtain_init_pos, 0.8)
	up_curtain_tween.tween_callback(self.curtains_opened.emit)
