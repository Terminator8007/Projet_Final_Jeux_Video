class_name MainMenu
extends Control

@onready var start_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Play_Button
@onready var exit_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Quitter_Button
@onready var option_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Options_Button
@onready var options_menu: OptionsMenu = $Options_Menu
@onready var instructions_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/Instructions_Button
@onready var instructions_menu: InstructionsMenu = $InstructionsMenu
@onready var margin_container: MarginContainer = $MarginContainer

func _ready():
	handle_connecting_signals()
	start_button.grab_focus()

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(Global.start_level)

func on_option_pressed() -> void:
	margin_container.visible = false
	options_menu.set_process(true)
	options_menu.visible = true

func on_instruction_pressed() -> void:
	print('instruction_pressed')
	margin_container.visible = false
	instructions_menu.set_process(true)
	instructions_menu.visible = true

func on_exit_instruction_menu() -> void:
	print('instruction exit')
	margin_container.visible = true
	instructions_menu.visible = false
	instructions_menu.set_process(false)
	start_button.grab_focus()

func on_exit_pressed() -> void:
	get_tree().quit()

func on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	options_menu.set_process(false)
	start_button.grab_focus()

func handle_connecting_signals() -> void:
	start_button.button_down.connect(on_start_pressed)
	option_button.button_down.connect(on_option_pressed)
	exit_button.button_down.connect(on_exit_pressed)
	instructions_button.button_down.connect(on_instruction_pressed)
	options_menu.exit_options_menu.connect(on_exit_options_menu)
	instructions_menu.exit_instructions_menu.connect(on_exit_instruction_menu)
