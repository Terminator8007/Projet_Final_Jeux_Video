extends Control
@onready var background: TextureRect = $TextureRect
@onready var label: Label = $Label
var image: CompressedTexture2D
var texte: String
@onready var menu_button: Button = $HBoxContainer/VBoxContainer/Menu_Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_button.grab_focus()
	if (Global.player_alive):
		image = preload("res://Assets/images/image victoire.png")
		texte = "Vous avez toasté les toasts!!!"
	else:
		image = preload("res://Assets/images/image game over.png")
		texte = "Vous vous êtes fait toaster..."
	
	label.text = texte
	background.texture = image
	Global.player_alive = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_packed(Global.main_menu_scene)

func _on_recommencer_button_pressed() -> void:
	get_tree().change_scene_to_packed(Global.start_level)

func _on_quitter_button_pressed() -> void:
	get_tree().quit()
