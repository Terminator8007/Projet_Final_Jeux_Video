extends Area2D
@onready var toast: Node = $Toast
var enemies: Array = []
var toast_spawned: bool = false
var ennemis_defeat: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toast.visible = false
	toast.process_mode = Node.PROCESS_MODE_DISABLED
	# Initialisation de la liste des ennemis
	for child in get_tree().get_nodes_in_group("enemies"):
		if child.patrol_area == self:
			enemies.append(child)

func check_all_enemies_defeated() -> bool:
	for ennemi in enemies:
		if ennemi == null:
			ennemis_defeat = true
		else:
			ennemis_defeat = false
			return false
	return ennemis_defeat

func _on_timer_timeout() -> void:
	if check_all_enemies_defeated() and !toast_spawned:
		$Timer.stop()
		toast_spawned = true
		toast.visible = true
		toast.process_mode = Node.PROCESS_MODE_INHERIT
