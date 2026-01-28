extends Control

@export var action_items: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#self._create_remap_buttons()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _create_remap_buttons() -> void:
	for i in range(self.action_items.size()):
		var action = self.action_items[i]
		var label = Label.new()
		label.text = action
		var button = RemapButton.new()
		button.action = action
		var container = HBoxContainer.new()
		container.add_child(label)
		container.add_child(button)
		$VBoxContainer.add_child(container)
