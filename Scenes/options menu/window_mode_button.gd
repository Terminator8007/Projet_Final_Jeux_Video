extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const WINDOW_MODE_ARRAY : Array[String] = [
	"Plein écran",
	"Fenêtré",
	"Fenêtré sans bordures",
	"Plein écran sans bordures"
]

func _ready():
	add_window_mode_item()
	option_button.item_selected.connect(on_window_mode_selected)

func add_window_mode_item() -> void:
	for i in WINDOW_MODE_ARRAY:
		option_button.add_item(i)

func on_window_mode_selected(index : int) -> void:
	match index:
		0: #Plein écran
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		1: #Fenêtré
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2: #Fenêtré sans bordures
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		3: #Plein écran sans bordures
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
