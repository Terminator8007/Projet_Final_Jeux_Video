extends BaseState
class_name PlayerIdle

@export var player : Player
var anim_player : AnimationPlayer

func manage_input() -> void:
	var dir : Vector2 = Input.get_vector("Gauche", "Droite", "Haut", "Bas").normalized()
	if (dir.length() > 0):
		Transitioned.emit(self, "Run")
	
	if Input.is_action_just_pressed("Bouton A"):
		Transitioned.emit(self, "Attack")

func enter():
	anim_player = player.get_animation_player()
	
func update(delta: float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
		
	anim_player.play("Idle_Bas")
