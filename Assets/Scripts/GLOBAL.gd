extends Node
var debug : Debug
var bus_idx: int
var muted: bool
var arcade_mapping = {
	"ui_accept": InputEventJoypadButton.new(),
	"ui_cancel": InputEventJoypadButton.new(),
	"ui_up": InputEventJoypadMotion.new(),
	"ui_down": InputEventJoypadMotion.new(),
	"ui_left": InputEventJoypadMotion.new(),
	"ui_right": InputEventJoypadMotion.new(),
	"Haut": InputEventJoypadMotion.new(),
	"Bas": InputEventJoypadMotion.new(),
	"Gauche": InputEventJoypadMotion.new(),
	"Droite": InputEventJoypadMotion.new(),
	"Bouton A": InputEventJoypadButton.new(),
	"Bouton B": InputEventJoypadButton.new(),
	"Bouton X": InputEventJoypadButton.new(),
	"Bouton Y": InputEventJoypadButton.new(),
	"Start": InputEventJoypadButton.new(),
	"Select": InputEventJoypadButton.new(),
	"Bouton L1": InputEventJoypadButton.new(),
	"Bouton L2": InputEventJoypadButton.new(),
	"Bouton R1": InputEventJoypadButton.new(),
	"Bouton R2": InputEventJoypadButton.new(),
}
var player_alive: bool = true
@export var start_level: PackedScene = preload("res://Scenes/world_map/world_map.tscn")
@export var end_scene: PackedScene = preload("res://Scenes/fin/scene_fin.tscn")
@export var main_menu_scene: PackedScene = preload("res://Scenes/main menu/main_menu.tscn")
var toast_cellecter: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_idx = AudioServer.get_bus_index("Master")
	muted = false
	if is_on_arcade():
		configure_arcade_mapping()
		remap_controls()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	manage_input()

func is_on_arcade() -> bool:
	return OS.get_executable_path().to_lower().contains("retropie")

func manage_end_game() -> void:
	if is_on_arcade() :
		if Input.is_action_pressed("Start") and Input.is_action_pressed("Select"):
			get_tree().quit()
	#else :
	#	if Input.is_action_just_pressed("Start"):
	#		get_tree().quit()

func manage_input() -> void:
	if Input.is_action_just_pressed("Mute"):
		muted = !muted
		AudioServer.set_bus_mute(bus_idx, muted)
	if Input.is_action_just_pressed("Scene Fin"):
		get_tree().change_scene_to_packed(end_scene)
	
	manage_end_game()

func configure_arcade_mapping():
	# Configure les boutons de l'arcade
	arcade_mapping["ui_accept"].button_index = 0  # Bouton A
	arcade_mapping["ui_cancel"].button_index = 1  # Bouton B
	arcade_mapping["Bouton A"].button_index = 0
	arcade_mapping["Bouton B"].button_index = 1
	arcade_mapping["Bouton X"].button_index = 2
	arcade_mapping["Bouton Y"].button_index = 3
	arcade_mapping["Bouton L1"].button_index = 4
	arcade_mapping["Bouton L2"].button_index = 7
	arcade_mapping["Bouton R1"].button_index = 5
	arcade_mapping["Bouton R2"].button_index = 6
	arcade_mapping["Select"].button_index = 8
	arcade_mapping["Start"].button_index = 9

	# Configure les axes pour les directions
	arcade_mapping["ui_up"].axis = 1  # Axe Y
	arcade_mapping["ui_up"].axis_value = -1.0
	arcade_mapping["ui_down"].axis = 1
	arcade_mapping["ui_down"].axis_value = 1.0
	arcade_mapping["ui_left"].axis = 0  # Axe X
	arcade_mapping["ui_left"].axis_value = -1.0
	arcade_mapping["ui_right"].axis = 0
	arcade_mapping["ui_right"].axis_value = 1.0
	arcade_mapping["Haut"].axis = 1  # Axe Y
	arcade_mapping["Haut"].axis_value = -1.0
	arcade_mapping["Bas"].axis = 1
	arcade_mapping["Bas"].axis_value = 1.0
	arcade_mapping["Gauche"].axis = 0  # Axe X
	arcade_mapping["Gauche"].axis_value = -1.0
	arcade_mapping["Droite"].axis = 0
	arcade_mapping["Droite"].axis_value = 1.0

func remap_controls():
	if is_on_arcade():
		# Supprime les anciennes configurations
		InputMap.action_erase_events("ui_accept")
		InputMap.action_erase_events("ui_cancel")
		InputMap.action_erase_events("ui_up")
		InputMap.action_erase_events("ui_down")
		InputMap.action_erase_events("ui_left")
		InputMap.action_erase_events("ui_right")
		InputMap.action_erase_events("Bas")
		InputMap.action_erase_events("Haut")
		InputMap.action_erase_events("Droite")
		InputMap.action_erase_events("Gauche")
		InputMap.action_erase_events("Bouton A")
		InputMap.action_erase_events("Bouton B")
		InputMap.action_erase_events("Bouton X")
		InputMap.action_erase_events("Bouton Y")
		InputMap.action_erase_events("Bouton L1")
		InputMap.action_erase_events("Bouton L2")
		InputMap.action_erase_events("Bouton R1")
		InputMap.action_erase_events("Bouton R2")
		InputMap.action_erase_events("Start")
		InputMap.action_erase_events("Select")
		
		# Ajoute les nouvelles configurations arcade
		InputMap.action_add_event("ui_accept", arcade_mapping["ui_accept"])
		InputMap.action_add_event("ui_cancel", arcade_mapping["ui_cancel"])
		InputMap.action_add_event("ui_up", arcade_mapping["ui_up"])
		InputMap.action_add_event("ui_down", arcade_mapping["ui_down"])
		InputMap.action_add_event("ui_left", arcade_mapping["ui_left"])
		InputMap.action_add_event("ui_right", arcade_mapping["ui_right"])
		InputMap.action_add_event("Gauche", arcade_mapping["Gauche"])
		InputMap.action_add_event("Droite", arcade_mapping["Droite"])
		InputMap.action_add_event("Haut", arcade_mapping["Haut"])
		InputMap.action_add_event("Bas", arcade_mapping["Bas"])
		InputMap.action_add_event("Select", arcade_mapping["Select"])
		InputMap.action_add_event("Start", arcade_mapping["Start"])
		InputMap.action_add_event("Bouton A", arcade_mapping["Bouton A"])
		InputMap.action_add_event("Bouton B", arcade_mapping["Bouton B"])
		InputMap.action_add_event("Bouton X", arcade_mapping["Bouton X"])
		InputMap.action_add_event("Bouton Y", arcade_mapping["Bouton Y"])
		InputMap.action_add_event("Bouton L1", arcade_mapping["Bouton L1"])
		InputMap.action_add_event("Bouton L2", arcade_mapping["Bouton L2"])
		InputMap.action_add_event("Bouton R1", arcade_mapping["Bouton R1"])
		InputMap.action_add_event("Bouton R2", arcade_mapping["Bouton R2"])
