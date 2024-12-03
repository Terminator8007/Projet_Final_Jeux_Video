class_name InstructionsMenu
extends Control

@onready var exit_button: Button = $VBoxContainer/Exit_Button 

signal exit_instructions_menu

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Bouton B") or Input.is_action_just_pressed("Start"):
		exit_instructions_menu.emit()

func _ready():
	exit_button.button_down.connect(on_exit_pressed)
	set_process(false)

func on_exit_pressed() -> void:
	exit_instructions_menu.emit()
	set_process(false)
