extends Control

@onready var option_button = $HBoxContainer/OptionButton as OptionButton

const RESOLUTION_DICTIONARY : Dictionary = {
	# 4:3
	"640 x 480" : Vector2i(640, 480),
	"800 x 600" : Vector2i(800, 600),
	"1024 x 768" : Vector2i(1024, 768),
	"1280 x 960" : Vector2i(1280, 960),
	"1600 x 1200" : Vector2i(1600, 1200),
	
	# 3:2
	"960 x 640" : Vector2i(960, 640),
	"1440 x 960" : Vector2i(1440, 960),
	"2160 x 1440" : Vector2i(2160, 1440),
	"2880 x 1920" : Vector2i(2880, 1920),

	# 16:9
	"1152 x 648" : Vector2i(1152, 648),
	"1280 x 720" : Vector2i(1280, 720),
	"1366 x 768" : Vector2i(1366, 768),
	"1600 x 900" : Vector2i(1600, 900),
	"1920 x 1080" : Vector2i(1920, 1080),
	"2560 x 1440" : Vector2i(2560, 1440),
	"3840 x 2160" : Vector2i(3840, 2160),
	
	# 16:10
	"1280 x 800" : Vector2i(1280, 800),
	"1440 x 900" : Vector2i(1440, 900),
	"1680 x 1050" : Vector2i(1680, 1050),
	"1920 x 1200" : Vector2i(1920, 1200),
	"2560 x 1600" : Vector2i(2560, 1600),
	"3840 x 2400" : Vector2i(3840, 2400),

	# 21:9
	"2560 x 1080" : Vector2i(2560, 1080),
	"3440 x 1440" : Vector2i(3440, 1440),
	"3840 x 1600" : Vector2i(3840, 1600),
	"5120 x 2160" : Vector2i(5120, 2160),

	# 32:9
	"3840 x 1080" : Vector2i(3840, 1080),
	"5120 x 1440" : Vector2i(5120, 1440),

	# 48:9 (ultrawide)
	"3840 x 720" : Vector2i(3840, 720),
	"5760 x 1080" : Vector2i(5760, 1080),
	"7680 x 1600" : Vector2i(7680, 1600)
}

func _ready() -> void:
	option_button.item_selected.connect(on_resolution_selected)
	add_resolution_items()

func add_resolution_items() -> void:
	for i in RESOLUTION_DICTIONARY:
		option_button.add_item(i)

func on_resolution_selected(index : int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
