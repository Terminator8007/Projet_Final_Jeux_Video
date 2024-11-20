extends BaseState
class_name PlayerIdle

@export var player : Player
var anim_player : AnimationPlayer
var last_direction : Vector2 = Vector2.DOWN

func manage_input() -> void:
	var dir : Vector2 = Input.get_vector("Gauche", "Droite", "Haut", "Bas").normalized()
	if (dir.length() > 0):
		Transitioned.emit(self, "Run")
	
	if Input.is_action_just_pressed("Bouton A"):
		Transitioned.emit(self, "Attaque1", last_direction)
	if Input.is_action_just_pressed("Bouton B"):
		if (player.special >= 40):
			player.special -= 40
			player.bar.special = player.special
			Transitioned.emit(self, "AttaqueSpeciale", last_direction)

func enter(direction = Vector2.DOWN) -> void:
	last_direction = direction
	anim_player = player.get_animation_player()
	
func update(delta: float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()
	manage_input()
	
func physics_update(delta: float) -> void:
	if not anim_player : return
	
	player.velocity = Vector2.ZERO
	
	if last_direction.x > 0.7:
		anim_player.play("Idle_Coter")
		player.sprite.flip_h = false
	elif last_direction.x < -0.7:
		anim_player.play("Idle_Coter")
		player.sprite.flip_h = true
	elif last_direction.y < -0.7:
		anim_player.play("Idle_Haut")
	elif last_direction.y > 0.7:
		anim_player.play("Idle_Bas")
