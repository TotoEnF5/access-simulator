extends Node2D

const _background_goal_pos: Vector2 = Vector2(575.982, 324.25)
const _heart_goal_pos: Vector2 = Vector2(589.649, 202.5)
const _man_goal_pos: Vector2 = Vector2(836.649, 375.5)
const _woman_goal_pos: Vector2 = Vector2(359.649, 382.5)
const _crowd_goal_pos: Vector2 = Vector2(574.324, 593.055)

const _background_init_pos: Vector2 = Vector2(575.982, -357)
const _heart_init_pos: Vector2 = Vector2(589.649, -241.5)
const _man_init_pos: Vector2 = Vector2(1351, 375.5)
const _woman_init_pos: Vector2 = Vector2(-198, 382.5)
const _crowd_init_pos: Vector2 = Vector2(574.324, 546.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func start_animaiton():
	var background_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	background_tween.tween_property($Layer1EndScene, "position", self._background_goal_pos, 0.8)
	background_tween.tween_callback(func ():
		var heart_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		heart_tween.tween_property($Layer2EndScene, "position", self._heart_goal_pos, 0.8)
	
		var crowd_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		crowd_tween.tween_property($Layer5EndScene, "position", self._crowd_goal_pos, 0.8)
		
		var man_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		man_tween.tween_property($Layer3EndScene, "position", self._man_goal_pos, 0.8)
		
		var woman_tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
		woman_tween.tween_property($Layer4EndScene, "position", self._woman_goal_pos, 0.8)
	)
