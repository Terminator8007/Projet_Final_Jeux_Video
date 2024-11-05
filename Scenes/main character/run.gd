extends BaseState
class_name PlayerRun

@export var player : Player
var anim_player : AnimationPlayer

@export var move_speed := 300.0
@export var stop_speed := 2000.0

func manage_input() -> Vector2:
	if Input.is_action_just_pressed("Bouton A"):
		Transitioned.emit(self, "Attack")

	# Obtient la direction d'entrée
	var dir: Vector2 = Input.get_vector("Gauche", "Droite", "Haut", "Bas").normalized()

	# Vérifie si la direction n'est pas nulle (pour éviter un angle lorsque le joystick est relâché)
	if dir != Vector2.ZERO:
		# Obtient l'angle de la direction en radians
		var angle = dir.angle()

		# Quantifie l'angle pour limiter à 8 directions (chaque direction couvre 45 degrés)
		var eight_dir_angle = round(angle / (PI / 4)) * (PI / 4)

		# Convertit l'angle quantifié en un vecteur
		dir = Vector2(cos(eight_dir_angle), sin(eight_dir_angle))
	
	return dir
	

func update(delta : float) -> void:
	if not anim_player :
		anim_player = player.get_animation_player()

	var dir : = manage_input()
	
	if dir.length() > 0 :
		player.velocity = dir * move_speed
	else :
		player.velocity = player.velocity.move_toward(Vector2.ZERO, stop_speed * delta)
	
	if (player.velocity.length() == 0) :
		Transitioned.emit(self, "Idle")
	
	player.direction = dir

func physics_update(delta: float) -> void:
	print(player.velocity)
	if player.velocity.length() > 0:
		# Vérifie si le mouvement est diagonal (x et y sont tous deux non nuls)
		if player.velocity.x > 100 or player.velocity.x < -100:
			anim_player.play("Run_Coter")
			if (player.velocity.x > 0) :
				player.sprite.flip_h = false
			elif (player.velocity.x < 0) :
				player.sprite.flip_h = true
		elif player.velocity.y < 0:
			anim_player.play("Run_Haut")
		elif player.velocity.y > 0:
			anim_player.play("Run_Bas")
