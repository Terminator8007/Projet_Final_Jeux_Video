extends Control
class_name Debug

var properties : Array

@onready var container = $PanelContainer/VBoxContainer
@onready var fps_label = $PanelContainer/VBoxContainer/FPS
@onready var ram_label = $PanelContainer/VBoxContainer/RAM

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.debug = self
	self.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fps_label.text = str("FPS: ", Engine.get_frames_per_second())
	ram_label.text = str("RAM: ", OS.get_static_memory_usage() / 1024 / 1024, "MB")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Debug"):
		visible = not visible
		get_viewport().set_input_as_handled()
