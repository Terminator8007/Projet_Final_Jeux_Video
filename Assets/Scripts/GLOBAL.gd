extends Node
var debug : Debug

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	manage_end_game()

func is_on_arcade() -> bool:
	return OS.get_executable_path().to_lower().contains("retropie")

func manage_end_game() -> void:
	if is_on_arcade() :
		if Input.is_action_pressed("Start") and Input.is_action_pressed("Select"):
			get_tree().quit()
	else :
		if Input.is_action_just_pressed("Start"):
			get_tree().quit()
